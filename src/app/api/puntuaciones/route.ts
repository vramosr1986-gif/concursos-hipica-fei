import { NextRequest, NextResponse } from 'next/server';
import { supabase } from '@/lib/supabase-server';

// GET: obtener puntuaciones de una participacion o una prueba
export async function GET(request: NextRequest) {
  try {
    const participacionId = request.nextUrl.searchParams.get('participacionId');
    const pruebaId = request.nextUrl.searchParams.get('pruebaId');
    const juezId = request.nextUrl.searchParams.get('juezId');

    let query = supabase
      .from('puntuaciones')
      .select(`
        id,
        participacion_id,
        prueba_juez_id,
        ejercicio_reprise_id,
        nota,
        comentario,
        created_at,
        updated_at,
        prueba_juez:prueba_juez_id(
          id,
          letra,
          juez_id,
          juez:juez_id(nombre, email)
        ),
        ejercicio:ejercicio_reprise_id(
          id,
          numero_orden,
          letra,
          descripcion,
          coeficiente
        )
      `);

    if (participacionId) {
      query = query.eq('participacion_id', participacionId);
    }

    if (juezId) {
      query = query.eq('prueba_juez.juez_id', juezId);
    }

    if (pruebaId) {
      const { data: parts } = await supabase
        .from('participaciones')
        .select('id')
        .eq('prueba_id', pruebaId);

      if (parts && parts.length > 0) {
        const ids = parts.map((p: any) => p.id);
        query = query.in('participacion_id', ids);
      } else {
        return NextResponse.json([]);
      }
    }

    const { data, error } = await query.order('created_at', { ascending: true });

    if (error) throw error;
    return NextResponse.json(data);
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}

// POST: crear o actualizar una puntuacion (upsert)
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();

    if (!body.participacion_id || !body.prueba_juez_id || !body.ejercicio_reprise_id) {
      return NextResponse.json(
        { error: 'Faltan campos: participacion_id, prueba_juez_id, ejercicio_reprise_id' },
        { status: 400 }
      );
    }

    if (typeof body.nota !== 'number' || body.nota < 0 || body.nota > 10) {
      return NextResponse.json(
        { error: 'La nota debe ser un numero entre 0 y 10' },
        { status: 400 }
      );
    }

    // 1. Obtener la letra del juez desde prueba_jueces
    const { data: pruebaJuez, error: pjError } = await supabase
      .from('prueba_jueces')
      .select('id, letra, juez_id')
      .eq('id', body.prueba_juez_id)
      .single();

    if (pjError || !pruebaJuez) {
      return NextResponse.json(
        { error: 'prueba_juez_id no valido: ' + (pjError?.message || 'no encontrado') },
        { status: 400 }
      );
    }

    // 2. Upsert con letra_juez incluido
    const { data, error } = await supabase
      .from('puntuaciones')
      .upsert(
        {
          participacion_id: body.participacion_id,
          prueba_juez_id: body.prueba_juez_id,
          ejercicio_reprise_id: body.ejercicio_reprise_id,
          nota: body.nota,
          comentario: body.comentario || null,
          letra_juez: pruebaJuez.letra,
          updated_at: new Date().toISOString(),
        },
        { onConflict: 'participacion_id,prueba_juez_id,ejercicio_reprise_id' }
      )
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

// PUT: actualizar una puntuacion existente por id
export async function PUT(request: NextRequest) {
  try {
    const body = await request.json();
    const { id, ...updates } = body;

    if (!id) {
      return NextResponse.json({ error: 'id requerido' }, { status: 400 });
    }

    const { data, error } = await supabase
      .from('puntuaciones')
      .update({
        ...updates,
        updated_at: new Date().toISOString(),
      })
      .eq('id', id)
      .select()
      .single();

    if (error) throw error;

    return NextResponse.json(data);
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}

// DELETE: eliminar una puntuacion
export async function DELETE(request: NextRequest) {
  try {
    const id = request.nextUrl.searchParams.get('id');

    if (!id) {
      return NextResponse.json({ error: 'id requerido' }, { status: 400 });
    }

    const { error } = await supabase
      .from('puntuaciones')
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