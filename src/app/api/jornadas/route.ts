import { NextRequest, NextResponse } from 'next/server';
import { supabase } from '@/lib/supabase-server';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();

    const { data, error } = await supabase
      .from('jornadas')
      .insert([body])
      .select()
      .single();

    if (error) throw error;

    return NextResponse.json(data, { status: 201 });
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}

export async function GET(request: NextRequest) {
  try {
    const concursoId = request.nextUrl.searchParams.get('concursoId');

    if (!concursoId) {
      return NextResponse.json(
        { error: 'concursoId requerido' },
        { status: 400 }
      );
    }

    const { data, error } = await supabase
      .from('jornadas')
      .select('*')
      .eq('concurso_id', concursoId)
      .order('fecha', { ascending: true });

    if (error) throw error;

    return NextResponse.json(data);
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}

