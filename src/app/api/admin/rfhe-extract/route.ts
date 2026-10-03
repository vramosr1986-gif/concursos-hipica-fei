import { NextRequest, NextResponse } from 'next/server';
import { load } from 'cheerio';
import { verificarAdmin } from '@/lib/api-guard';

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
};

type InscritoRfhe = {
  numero: string;
  jinete: string;
  ldn: string;
  federacionJinete: string;
  reprises: RepriseInscrito[];
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

async function leerRespuestaLimitada(response: Response): Promise<Buffer> {
  const contentLength = Number(response.headers.get('content-length') || 0);
  if (contentLength > MAX_BYTES) {
    throw new Error('El archivo supera el límite de 8 MB');
  }

  if (!response.body) return Buffer.alloc(0);

  const reader = response.body.getReader();
  const chunks: Uint8Array[] = [];
  let total = 0;

  while (true) {
    const { done, value } = await reader.read();
    if (done) break;
    total += value.byteLength;
    if (total > MAX_BYTES) {
      await reader.cancel();
      throw new Error('El archivo supera el límite de 8 MB');
    }
    chunks.push(value);
  }

  return Buffer.concat(chunks.map((chunk) => Buffer.from(chunk)));
}

async function descargar(url: URL): Promise<{ bytes: Buffer; contentType: string }> {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), TIMEOUT_MS);

  try {
    const response = await fetch(url, {
      signal: controller.signal,
      redirect: 'manual',
      headers: { 'User-Agent': 'ConcursosHipica/1.0 (RFHE import preview)' },
    });

    if (response.status >= 300 && response.status < 400) {
      throw new Error('RFHE respondió con una redirección; abre el enlace final y vuelve a intentarlo');
    }
    if (!response.ok) {
      throw new Error(`RFHE respondió con el estado ${response.status}`);
    }

    return {
      bytes: await leerRespuestaLimitada(response),
      contentType: response.headers.get('content-type') || '',
    };
  } catch (error) {
    if (controller.signal.aborted) {
      throw new Error('La consulta a RFHE agotó el tiempo de espera');
    }
    throw error;
  } finally {
    clearTimeout(timeout);
  }
}

function normalizarEncabezado(valor: string): string {
  return valor.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase().trim();
}

function extraerInscritos($: ReturnType<typeof load>): InscritoRfhe[] {
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

    const inscritos: InscritoRfhe[] = [];
    let actual: InscritoRfhe | null = null;

    for (const row of filas.slice(indiceEncabezado + 1)) {
      const celdas = $(row).children('th, td')
        .map((_index, cell) => $(cell).text().replace(/\s+/g, ' ').trim())
        .toArray();
      if (celdas.length === 0) continue;

      if (/^\d+$/.test(celdas[0] || '') && celdas.length >= 8) {
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
        });
        continue;
      }

      if (actual && !(celdas[0] || '') && celdas.length >= 5 && (celdas[1] || '')) {
        actual.reprises.push({
          reprise: celdas[1],
          caballo: celdas[2] || '',
          lac: celdas[3] || '',
          federacionCaballo: celdas[4] || '',
        });
      }
    }

    if (inscritos.length > 0) return inscritos;
  }

  return [];
}

function extraerHtml(url: string, html: string): PaginaExtraida {
  const $ = load(html);
  const tablas: TablaExtraida[] = [];

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
    inscritos: extraerInscritos($),
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
