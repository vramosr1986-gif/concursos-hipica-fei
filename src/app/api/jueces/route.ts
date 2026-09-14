import { NextRequest, NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase-admin';
import { verificarAdmin } from '@/lib/api-guard';

export async function POST(request: NextRequest) {
  const auth = await verificarAdmin(request);
  if (!auth.ok) {
    return NextResponse.json({ error: auth.error }, { status: auth.status });
  }

  try {
    const body = await request.json();

    const { concurso_id, user_id, nombre, letra_oficial, experiencia } = body;

    if (!concurso_id || !user_id || !nombre || !letra_oficial) {
      return NextResponse.json(
        { error: 'Faltan campos obligatorios' },
        { status: 400 }
      );
    }

    const { data, error } = await supabaseAdmin
      .from('jueces')
      .insert([
        {
          concurso_id,
          user_id,
          nombre,
          letra_oficial,
          experiencia: experiencia || null,
        },
      ])
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

    const { data, error } = await supabaseAdmin
      .from('jueces')
      .select('*')
      .eq('concurso_id', concursoId)
      .order('letra_oficial', { ascending: true });

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
  const auth = await verificarAdmin(request);
  if (!auth.ok) {
    return NextResponse.json({ error: auth.error }, { status: auth.status });
  }

  try {
    const id = request.nextUrl.searchParams.get('id');

    if (!id) {
      return NextResponse.json({ error: 'id requerido' }, { status: 400 });
    }

    const { error } = await supabaseAdmin.from('jueces').delete().eq('id', id);

    if (error) throw error;

    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}
