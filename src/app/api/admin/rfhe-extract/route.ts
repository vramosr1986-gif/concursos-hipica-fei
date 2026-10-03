import { NextRequest, NextResponse } from 'next/server';
import { load } from 'cheerio';
import { verificarAdmin } from '@/lib/api-guard';
import { request as httpsRequest } from 'node:https';
import { rootCertificates } from 'node:tls';
import { RAPIDSSL_INTERMEDIATE_PEM } from '@/lib/rfhe-ca';

export const runtime = 'nodejs';

const HOSTS_PERMITIDOS = new Set([
  'www.cbservicios.net',
  'cbservicios.net',
  'gestion.cbservicios.net',
]);
const MAX_BYTES = 8 * 1024 * 1024;
const TIMEOUT_MS = 15_000;

type TablaExtraida = {
  encabezados: string[];
  filas: string[][];
};

type RepriseInscrito = {
  reprise: string;
  caballo: string;
  lac: string;
  federacionCaballo: string;
  observaciones: string;
};

type InscritoRfhe = {
  numero: string;
  jinete: string;
  ldn: string;
  federacionJinete: string;
  reprises: RepriseInscrito[];
};

type ListaInscritosExtraida = {
  filas: InscritoRfhe[];
  tieneNumero: boolean;
};

type ConcursoCalendarioRfhe = {
  fecha: string;
  categoria: string;
  nombre: string;
  provincia: string;
  sede: string;
  urlDetalle: string;
};

type PaginaExtraida = {
  url: string;
  titulo: string;
  texto: string;
  tablas: TablaExtraida[];
  inscritos?: InscritoRfhe[];
  inscritosConNumero?: boolean;
};

function validarUrl(valor: unknown, campo: string): URL {
  if (typeof valor !== 'string' || !valor.trim()) {
    throw new Error(`Falta la URL de ${campo}`);
  }

  let url: URL;
  try {
    url = new URL(valor);
  } catch {
    throw new Error(`La URL de ${campo} no es válida`);
  }

  if (
    url.protocol !== 'https:' ||
    !HOSTS_PERMITIDOS.has(url.hostname.toLowerCase()) ||
    url.username ||
    url.password ||
    url.port
  ) {
    throw new Error(`La URL de ${campo} debe pertenecer a un dominio RFHE permitido`);
  }

  return url;
}

const CA_RFHE = [...rootCertificates, RAPIDSSL_INTERMEDIATE_PEM];

function descargar(url: URL): Promise<{ bytes: Buffer; contentType: string }> {
  return new Promise((resolve, reject) => {
    const req = httpsRequest(
      url,
      {
        ca: CA_RFHE,
        timeout: TIMEOUT_MS,
        headers: { 'User-Agent': 'ConcursosHipica/1.0 (RFHE import preview)' },
      },
      (res) => {
        const status = res.statusCode || 0;
        if (status >= 300 && status < 400) {
          res.resume();
          reject(new Error('RFHE respondió con una redirección; abre el enlace final y vuelve a intentarlo'));
          return;
        }
        if (status < 200 || status >= 300) {
          res.resume();
          reject(new Error(`RFHE respondió con el estado ${status}`));
          return;
        }
        if (Number(res.headers['content-length'] || 0) > MAX_BYTES) {
          res.destroy();
          reject(new Error('El archivo supera el límite de 8 MB'));
          return;
        }

        const chunks: Buffer[] = [];
        let total = 0;
        res.on('data', (chunk: Buffer) => {
          total += chunk.length;
          if (total > MAX_BYTES) {
            res.destroy();
            reject(new Error('El archivo supera el límite de 8 MB'));
            return;
          }
          chunks.push(chunk);
        });
        res.on('end', () =>
          resolve({ bytes: Buffer.concat(chunks), contentType: String(res.headers['content-type'] || '') })
        );
        res.on('error', reject);
      }
    );
    req.on('timeout', () => {
      req.destroy(new Error('La consulta a RFHE agotó el tiempo de espera'));
    });
    req.on('error', reject);
    req.end();
  });
}

function normalizarEncabezado(valor: string): string {
  return valor.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase().trim();
}

function extraerInscritos($: ReturnType<typeof load>): ListaInscritosExtraida {
  const tablas = $('table').toArray().filter((table) => $(table).find('table').length === 0);

  for (const table of tablas) {
    const filas = $(table).find('tr').toArray();
    const indiceEncabezado = filas.findIndex((row) => {
      const celdas = $(row).children('th, td')
        .map((_index, cell) => normalizarEncabezado($(cell).text()))
        .toArray();
      return celdas.some((cell) => cell.includes('jinete')) &&
        celdas.some((cell) => cell === 'ldn') &&
        celdas.some((cell) => cell === 'lac') &&
        celdas.some((cell) => cell.includes('caballo'));
    });

    if (indiceEncabezado < 0) continue;

    const encabezados = $(filas[indiceEncabezado]).children('th, td')
      .map((_index, cell) => normalizarEncabezado($(cell).text()))
      .toArray();
    const indiceNumero = encabezados.findIndex((cell) => ['nº', 'n°', 'no'].includes(cell));
    const tieneNumero = indiceNumero >= 0;
    const indiceJinete = encabezados.findIndex((cell) => cell.includes('jinete'));
    const indiceLdn = encabezados.findIndex((cell) => cell === 'ldn');
    const indicesFh = encabezados.reduce<number[]>((indices, cell, index) => {
      if (cell === 'fh') indices.push(index);
      return indices;
    }, []);
    const indiceCaballo = encabezados.findIndex((cell) => cell.includes('caballo'));
    const indiceLac = encabezados.findIndex((cell) => cell === 'lac');
    const indiceReprise = encabezados.findIndex((cell) => cell.includes('repris'));
    const indiceObservaciones = encabezados.findIndex((cell) => cell.includes('observ'));

    const inscritos: InscritoRfhe[] = [];
    let actual: InscritoRfhe | null = null;

    for (const row of filas.slice(indiceEncabezado + 1)) {
      const celdas = $(row).children('th, td')
        .map((_index, cell) => $(cell).text().replace(/\s+/g, ' ').trim())
        .toArray();
      if (celdas.length === 0) continue;

      if (tieneNumero && /^\d+$/.test(celdas[0] || '') && celdas.length >= 8) {
        actual = {
          numero: celdas[0],
          jinete: celdas[1] || '',
          ldn: celdas[2] || '',
          federacionJinete: celdas[3] || '',
          reprises: [],
        };
        inscritos.push(actual);
        actual.reprises.push({
          reprise: celdas[4] || '',
          caballo: celdas[5] || '',
          lac: celdas[6] || '',
          federacionCaballo: celdas[7] || '',
          observaciones: celdas[8] || '',
        });
        continue;
      }

      if (!tieneNumero && indiceJinete >= 0 && indiceLdn >= 0 && celdas[indiceJinete] && celdas[indiceLdn]) {
        actual = {
          numero: '',
          jinete: celdas[indiceJinete],
          ldn: celdas[indiceLdn],
          federacionJinete: celdas[indicesFh[0]] || '',
          reprises: [],
        };
        inscritos.push(actual);
      } else if (tieneNumero && actual && !(celdas[0] || '') && celdas.length >= 5 && (celdas[1] || '')) {
        actual.reprises.push({
          reprise: celdas[1],
          caballo: celdas[2] || '',
          lac: celdas[3] || '',
          federacionCaballo: celdas[4] || '',
          observaciones: '',
        });
        continue;
      }

      if (actual && !tieneNumero && (celdas[indiceCaballo] || celdas[indiceLac] || celdas[indiceReprise])) {
        actual.reprises.push({
          reprise: celdas[indiceReprise] || '',
          caballo: celdas[indiceCaballo] || '',
          lac: celdas[indiceLac] || '',
          federacionCaballo: celdas[indicesFh[1]] || '',
          observaciones: celdas[indiceObservaciones] || '',
        });
      }
    }

    if (inscritos.length > 0) return { filas: inscritos, tieneNumero };
  }

  return { filas: [], tieneNumero: false };
}

function extraerHtml(url: string, html: string): PaginaExtraida {
  const $ = load(html);
  const tablas: TablaExtraida[] = [];
  const resultadoInscritos = extraerInscritos($);

  $('table').each((_tableIndex, table) => {
    if ($(table).find('table').length > 0) return;
    const elementosFila = $(table).find('tr').toArray();
    const indiceEncabezado = elementosFila.findIndex((row) => $(row).children('th').length > 0);
    const filas = elementosFila.map((row) =>
      $(row).children('th, td')
        .map((_cellIndex, cell) => $(cell).text().replace(/\s+/g, ' ').trim())
        .toArray()
    ).filter((row) => row.some(Boolean));

    if (filas.length === 0) return;

    const encabezadosIndex = indiceEncabezado >= 0 ? indiceEncabezado : 0;
    const encabezados = filas[encabezadosIndex] || [];
    const filasDatos = filas.slice(encabezadosIndex + 1).filter((row) => row.length > 1);
    if (encabezados.some(Boolean)) tablas.push({ encabezados, filas: filasDatos });
  });

  return {
    url,
    titulo: $('title').first().text().trim() || $('h1, h2, b').first().text().trim(),
    texto: $('body').text().replace(/\s+/g, ' ').trim(),
    tablas,
    inscritos: resultadoInscritos.filas,
    inscritosConNumero: resultadoInscritos.tieneNumero,
  };
}

function extraerConcursosCalendario($: ReturnType<typeof load>): ConcursoCalendarioRfhe[] {
  const concursos: ConcursoCalendarioRfhe[] = [];

  $('a[href*="PRGNAME=RFHECALCON"]').each((_anchorIndex, anchor) => {
    const row = $(anchor).closest('tr');
    if (row.length === 0) return;

    const cells = row.children('td')
      .map((_cellIndex, cell) => $(cell).text().replace(/\s+/g, ' ').trim())
      .toArray();
    if (cells.length < 6) return;

    try {
      const href = $(anchor).attr('href');
      if (!href) return;
      const urlDetalle = new URL(href, 'https://www.cbservicios.net');
      if (urlDetalle.protocol !== 'https:' || !HOSTS_PERMITIDOS.has(urlDetalle.hostname.toLowerCase())) return;

      concursos.push({
        fecha: cells[0] || '',
        categoria: cells[1] || '',
        nombre: $(anchor).text().replace(/\s+/g, ' ').trim(),
        provincia: cells[4] || '',
        sede: cells[5] || '',
        urlDetalle: urlDetalle.toString(),
      });
    } catch {
      return;
    }
  });

  return concursos;
}

function decodificarHtml(bytes: Buffer, contentType: string): string {
  const encabezado = bytes.subarray(0, 2048).toString('ascii');
  const codificacionLatin = /charset\s*=\s*["']?(?:iso-8859-1|latin-1|latin1|windows-1252)/i;
  const esLatin = codificacionLatin.test(contentType) || codificacionLatin.test(encabezado);
  return new TextDecoder(esLatin ? 'windows-1252' : 'utf-8').decode(bytes);
}

async function extraer(url: URL) {
  const { bytes, contentType } = await descargar(url);
  if (contentType.toLowerCase().includes('pdf') || bytes.subarray(0, 5).toString() === '%PDF-') {
    throw new Error('Esta página no acepta avances PDF; introduce una URL HTML de concurso o admitidos');
  }

  const html = decodificarHtml(bytes, contentType);
  if (!html.trim()) throw new Error('RFHE devolvió una página vacía');
  return { tipo: 'html' as const, datos: extraerHtml(url.toString(), html) };
}

export async function POST(request: NextRequest) {
  const auth = await verificarAdmin(request);
  if (!auth.ok) {
    return NextResponse.json({ error: auth.error }, { status: auth.status });
  }

  try {
    const body = await request.json();
    const concursoUrl = validarUrl(body.concursoUrl, 'concurso');
    const inscritosUrl = validarUrl(body.inscritosUrl, 'inscritos');

    const resultados = await Promise.allSettled([
      extraer(concursoUrl),
      extraer(inscritosUrl),
    ]);

    const resultado = (index: number) => {
      const item = resultados[index];
      if (item.status === 'fulfilled') return item.value;
      return { error: item.reason instanceof Error ? item.reason.message : 'No se pudo extraer esta URL' };
    };

    return NextResponse.json({
      concurso: resultado(0),
      inscritos: resultado(1),
    });
  } catch (error) {
    return NextResponse.json(
      { error: error instanceof Error ? error.message : 'No se pudieron extraer los datos' },
      { status: 400 }
    );
  }
}

export async function GET(request: NextRequest) {
  const auth = await verificarAdmin(request);
  if (!auth.ok) {
    return NextResponse.json({ error: auth.error }, { status: auth.status });
  }

  const year = Number(request.nextUrl.searchParams.get('year') || new Date().getFullYear());
  const currentYear = new Date().getFullYear();
  if (!Number.isInteger(year) || year < 2000 || year > currentYear + 10) {
    return NextResponse.json({ error: 'Año no válido' }, { status: 400 });
  }

  const calendarUrl = new URL('https://www.cbservicios.net/Magic94Scripts/mgrqispi94.dll');
  calendarUrl.searchParams.set('APPNAME', 'CBRFHE');
  calendarUrl.searchParams.set('PRGNAME', 'RFHETMP98');
  calendarUrl.searchParams.set(
    'ARGUMENTS',
    year === currentYear ? '-A02' : `-A02,-A${year}`
  );

  try {
    const { bytes, contentType } = await descargar(calendarUrl);
    const html = decodificarHtml(bytes, contentType);
    const $ = load(html);
    const concursos = extraerConcursosCalendario($);
    const titulo = $('title').first().text().trim() || `Calendario RFHE ${year}`;

    return NextResponse.json({
      year,
      titulo,
      url: calendarUrl.toString(),
      total: concursos.length,
      concursos,
    });
  } catch (error) {
    return NextResponse.json(
      { error: error instanceof Error ? error.message : 'No se pudo cargar el calendario RFHE' },
      { status: 502 }
    );
  }
}
