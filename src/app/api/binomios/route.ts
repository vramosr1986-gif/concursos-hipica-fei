import { NextRequest, NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase-admin';

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();

    const {
      nombre_jinete,
      nombre_caballo,
      anio_nacimiento_caballo,
      fecha_nacimiento_jinete,
      licencia_federativa,
    } = body;

    if (!nombre_jinete || !nombre_caballo) {
      return NextResponse.json(
        { error: 'Jinete y caballo son obligatorios' },
        { status: 400 }
      );
    }

    const { data, error } = await supabaseAdmin
      .from('binomios')
      .insert([
        {
          nombre_jinete,
          nombre_caballo,
          anio_nacimiento_caballo: anio_nacimiento_caballo || null,
          fecha_nacimiento_jinete: fecha_nacimiento_jinete || null,
          licencia_federativa: licencia_federativa || null,
        },
      ])
      .select()
      .single();

    if (error) {
      if ((error as any).code === '23505') {
        return NextResponse.json(
          { error: 'Ya existe un binomio con esa licencia federativa' },
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

export async function GET() {
  try {
    const { data, error } = await supabaseAdmin
      .from('binomios')
      .select('*')
      .order('nombre_jinete', { ascending: true });

    if (error) throw error;

    return NextResponse.json(data);
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}

export async function PUT(request: NextRequest) {
  try {
    const body = await request.json();
    const { id, ...updates } = body;

    if (!id) {
      return NextResponse.json({ error: 'id requerido' }, { status: 400 });
    }

    const { data, error } = await supabaseAdmin
      .from('binomios')
      .update(updates)
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

export async function DELETE(request: NextRequest) {
  try {
    const id = request.nextUrl.searchParams.get('id');

    if (!id) {
      return NextResponse.json({ error: 'id requerido' }, { status: 400 });
    }

    const { error } = await supabaseAdmin.from('binomios').delete().eq('id', id);

    if (error) throw error;

    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}