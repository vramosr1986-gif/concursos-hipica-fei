import { NextRequest, NextResponse } from 'next/server';

import { supabase } from '@/lib/supabase-server';

export async function GET(request: NextRequest) {
  const concursoId = request.nextUrl.searchParams.get('concursoId');

  if (!concursoId) {
    return NextResponse.json(
      { error: 'concursoId requerido' },
      { status: 400 }
    );
  }

  const { data, error } = await supabase
    .from('jueces')
    .select('id, nombre, letra_oficial, experiencia')
    .eq('concurso_id', concursoId)
    .order('letra_oficial', { ascending: true });

  if (error) {
    return NextResponse.json(
      { error: error.message },
      { status: 500 }
    );
  }

  return NextResponse.json(data ?? []);
}

