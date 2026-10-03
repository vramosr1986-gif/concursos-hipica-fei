import { NextRequest, NextResponse } from 'next/server';
import { JSDOM } from 'jsdom';
import { getDocument } from 'pdfjs-dist/legacy/build/pdf.mjs';
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

function extraerInscritos(document: Document): InscritoRfhe[] {
  const tablas = Array.from(document.querySelectorAll('table')).filter(
    (table) => !table.querySelector('table')
  );

  for (const table of tablas) {
    const filas = Array.from(table.querySelectorAll('tr'));
    const indiceEncabezado = filas.findIndex((row) => {
      const celdas = Array.from(row.querySelectorAll(':scope > th, :scope > td'))
        .map((cell) => normalizarEncabezado(cell.textContent || ''));
      return celdas.some((cell) => cell.includes('jinete')) &&
        celdas.some((cell) => cell === 'ldn') &&
        celdas.some((cell) => cell === 'lac') &&
        celdas.some((cell) => cell.includes('caballo'));
    });

    if (indiceEncabezado < 0) continue;

    const inscritos: InscritoRfhe[] = [];
    let actual: InscritoRfhe | null = null;

    for (const row of filas.slice(indiceEncabezado + 1)) {
      const celdas = Array.from(row.querySelectorAll(':scope > th, :scope > td'))
        .map((cell) => (cell.textContent || '').replace(/\s+/g, ' ').trim());
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
  const dom = new JSDOM(html);
  const document = dom.window.document;
  const tablas: TablaExtraida[] = [];

  document.querySelectorAll('table').forEach((table) => {
    if (table.querySelector('table')) return;
    const elementosFila = Array.from(table.querySelectorAll('tr'));
    const indiceEncabezado = elementosFila.findIndex((row) => row.querySelector(':scope > th'));
    const filas = elementosFila.map((tr) =>
      Array.from(tr.querySelectorAll('th, td')).map((cell) =>
        (cell.textContent || '').replace(/\s+/g, ' ').trim()
      )
    ).filter((row) => row.some(Boolean));

    if (filas.length === 0) return;

    const encabezadosIndex = indiceEncabezado >= 0 ? indiceEncabezado : 0;
    const encabezados = filas[encabezadosIndex] || [];
    const filasDatos = filas.slice(encabezadosIndex + 1).filter((row) => row.length > 1);
    if (encabezados.some(Boolean)) tablas.push({ encabezados, filas: filasDatos });
  });

  return {
    url,
    titulo: document.title.trim() || document.querySelector('h1, h2, b')?.textContent?.trim() || '',
    texto: (document.body?.textContent || '').replace(/\s+/g, ' ').trim(),
    tablas,
    inscritos: extraerInscritos(document),
  };
}

function extraerConcursosCalendario(document: Document): ConcursoCalendarioRfhe[] {
  const concursos: ConcursoCalendarioRfhe[] = [];

  document.querySelectorAll('a[href*="PRGNAME=RFHECALCON"]').forEach((anchor) => {
    const row = anchor.closest('tr');
    if (!row) return;

    const cells = Array.from(row.querySelectorAll(':scope > td'))
      .map((cell) => (cell.textContent || '').replace(/\s+/g, ' ').trim());
    if (cells.length < 6) return;

    try {
      const urlDetalle = new URL((anchor as HTMLAnchorElement).href);
      if (urlDetalle.protocol !== 'https:' || !HOSTS_PERMITIDOS.has(urlDetalle.hostname.toLowerCase())) return;

      concursos.push({
        fecha: cells[0] || '',
        categoria: cells[1] || '',
        nombre: (anchor.textContent || '').replace(/\s+/g, ' ').trim(),
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

async function extraerPdf(url: string, bytes: Buffer) {
  const pdf = await getDocument({ data: new Uint8Array(bytes) }).promise;
  const paginas: { numero: number; texto: string }[] = [];

  for (let numero = 1; numero <= pdf.numPages; numero += 1) {
    const pagina = await pdf.getPage(numero);
    const contenido = await pagina.getTextContent();
    const texto = contenido.items
      .map((item) => ('str' in item ? item.str : ''))
      .filter(Boolean)
      .join(' ')
      .replace(/\s+/g, ' ')
      .trim();
    paginas.push({ numero, texto });
  }

  return { url, paginas, texto: paginas.map((pagina) => pagina.texto).join('\n\n') };
}

async function extraer(url: URL, tipo: 'html' | 'avance') {
  const { bytes, contentType } = await descargar(url);
  const esPdf = contentType.toLowerCase().includes('pdf') || bytes.subarray(0, 5).toString() === '%PDF-';

  if (tipo === 'avance' && esPdf) {
    return { tipo: 'pdf' as const, datos: await extraerPdf(url.toString(), bytes) };
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
    const avanceUrl = validarUrl(body.avanceUrl, 'avance');

    const resultados = await Promise.allSettled([
      extraer(concursoUrl, 'html'),
      extraer(inscritosUrl, 'html'),
      extraer(avanceUrl, 'avance'),
    ]);

    const resultado = (index: number) => {
      const item = resultados[index];
      if (item.status === 'fulfilled') return item.value;
      return { error: item.reason instanceof Error ? item.reason.message : 'No se pudo extraer esta URL' };
    };

    return NextResponse.json({
      concurso: resultado(0),
      inscritos: resultado(1),
      avance: resultado(2),
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
    const dom = new JSDOM(html);
    const concursos = extraerConcursosCalendario(dom.window.document);
    const titulo = dom.window.document.title.trim() || `Calendario RFHE ${year}`;

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
