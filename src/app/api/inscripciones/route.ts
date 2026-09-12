import { NextRequest, NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase-admin';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();

    const { binomio_id, concurso_id, dorsal, categoria, orden_salida } = body;

    if (!binomio_id || !concurso_id || !dorsal) {
      return NextResponse.json(
        { error: 'Faltan campos obligatorios: binomio_id, concurso_id, dorsal' },
        { status: 400 }
      );
    }

    const { data, error } = await supabaseAdmin
      .from('inscripciones')
      .insert([
        {
          binomio_id,
          concurso_id,
          dorsal,
          categoria: categoria || null,
          
          orden_salida: orden_salida || null,
        },
      ])
      .select()
      .single();

    if (error) {
      if ((error as any).code === '23505') {
        return NextResponse.json(
          { error: 'Ya existe una inscripcion con ese dorsal en este concurso' },
          { status: 409 }
        );
      }
      throw error;
    }

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

    const { data, error } = await supabaseAdmin
      .from('inscripciones')
      .select(`
        id,
        binomio_id,
        concurso_id,
        dorsal,
        categoria,
        
        orden_salida,
        created_at,
        binomio:binomio_id (
          id,
          nombre_jinete,
          nombre_caballo,
          anio,
          licencia_federativa
        )
      `)
      .eq('concurso_id', concursoId)
      .order('dorsal', { ascending: true });

    if (error) throw error;

    return NextResponse.json(data);
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}

export async function DELETE(request: NextRequest) {
  try {
    const id = request.nextUrl.searchParams.get('id');

    if (!id) {
      return NextResponse.json({ error: 'id requerido' }, { status: 400 });
    }

    const { error } = await supabaseAdmin
      .from('inscripciones')
      .delete()
      .eq('id', id);

    if (error) throw error;

    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}