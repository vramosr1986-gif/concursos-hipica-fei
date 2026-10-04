import { NextRequest, NextResponse } from 'next/server';
import { verificarAdmin } from '@/lib/api-guard';
import { buscarCaballos, buscarJinetes } from '@/lib/rfhe';

export const runtime = 'nodejs';

/**
 * Apellidos con los que probar la búsqueda de un jinete:
 * "Abollo Fontela, Alba" → "Abollo Fontela"; "Alba Abollo Fontela" → "Abollo Fontela", "Abollo".
 */
function apellidosPosibles(nombre: string): string[] {
  const limpio = nombre.replace(/^(d|dña|dna|don|doña)\.?\s+/i, '').trim();
  if (limpio.includes(',')) return [limpio.split(',')[0].trim()];
  const palabras = limpio.split(/\s+/).filter(Boolean);
  if (palabras.length <= 1) return palabras;
  const candidatos = [palabras.slice(1).join(' '), palabras[1], palabras.slice(0, -1).join(' '), palabras[0]];
  return Array.from(new Set(candidatos.filter(Boolean)));
}

export async function POST(request: NextRequest) {
  const auth = await verificarAdmin(request);
  if (!auth.ok) return NextResponse.json({ error: auth.error }, { status: auth.status });

  try {
    const { tipo, nombre } = await request.json();
    const texto = typeof nombre === 'string' ? nombre.trim() : '';
    if (!texto) return NextResponse.json({ error: 'Escribe el nombre antes de buscar' }, { status: 400 });

    if (tipo === 'caballo') {
      return NextResponse.json({ busqueda: texto, resultados: await buscarCaballos(texto) });
    }
    if (tipo === 'jinete') {
      for (const apellidos of apellidosPosibles(texto)) {
        const resultados = await buscarJinetes(apellidos);
        if (resultados.length > 0) return NextResponse.json({ busqueda: apellidos, resultados });
      }
      return NextResponse.json({ busqueda: apellidosPosibles(texto)[0] || texto, resultados: [] });
    }
    return NextResponse.json({ error: 'Tipo de búsqueda no válido' }, { status: 400 });
  } catch (error) {
    return NextResponse.json(
      { error: error instanceof Error ? error.message : 'No se pudo consultar la RFHE' },
      { status: 502 }
    );
  }
}
