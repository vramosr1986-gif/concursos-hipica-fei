import { NextRequest, NextResponse } from 'next/server';
import { load } from 'cheerio';
import { verificarAdmin } from '@/lib/api-guard';
import { decodificarHtml, descargar, extraer, extraerConcursosCalendario, validarUrl } from '@/lib/rfhe';

export const runtime = 'nodejs';

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
    const concursos = extraerConcursosCalendario($, year);
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
