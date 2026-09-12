import { NextRequest, NextResponse } from 'next/server';
import { supabase } from '@/lib/supabase-server';

// POST: crear concurso
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();

    const { data, error } = await supabase
      .from('concursos')
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

// GET: obtener concursos
export async function GET() {
  try {
    const { data, error } = await supabase
      .from('concursos')
      .select('*')
      .order('fecha_inicio', { ascending: false });

    if (error) throw error;

    return NextResponse.json(data);
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}

