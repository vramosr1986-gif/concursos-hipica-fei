import { NextRequest, NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase-admin';
import { verificarAdmin } from '@/lib/api-guard';
import { datosQueFaltan, esMismoBinomio } from '@/lib/binomios';

export async function POST(request: NextRequest) {
  const auth = await verificarAdmin(request);
  if (!auth.ok) {
    return NextResponse.json({ error: auth.error }, { status: auth.status });
  }

  try {
    const body = await request.json();

    const {
      nombre_jinete,
      nombre_caballo,
      anio_nacimiento_caballo,
      fecha_nacimiento_jinete,
      licencia_federativa,
      ldn_jinete,
      lac_caballo,
      fh_jinete,
      fh_caballo,
      consentimiento_datos_at,
    } = body;

    if (!nombre_jinete || !nombre_caballo) {
      return NextResponse.json(
        { error: 'Jinete y caballo son obligatorios' },
        { status: 400 }
      );
    }

    const datos = {
      nombre_jinete,
      nombre_caballo,
      // Sin permiso expreso no se guardan fechas de nacimiento.
      anio_nacimiento_caballo: consentimiento_datos_at ? anio_nacimiento_caballo || null : null,
      fecha_nacimiento_jinete: consentimiento_datos_at ? fecha_nacimiento_jinete || null : null,
      consentimiento_datos_at: consentimiento_datos_at || null,
      licencia_federativa: licencia_federativa || null,
      ldn_jinete: ldn_jinete || null,
      lac_caballo: lac_caballo || null,
      fh_jinete: fh_jinete || null,
      fh_caballo: fh_caballo || null,
    };

    // Si el binomio ya existe no se duplica: se rellenan los datos que le falten.
    const { data: todos, error: errTodos } = await supabaseAdmin
      .from('binomios')
      .select('id, nombre_jinete, nombre_caballo, ldn_jinete, lac_caballo, licencia_federativa, fh_jinete, fh_caballo, fecha_nacimiento_jinete, anio_nacimiento_caballo, consentimiento_datos_at');
    if (errTodos) throw errTodos;
    const existente = (todos || []).find((b) => esMismoBinomio(b, datos));

    if (existente) {
      const cambios = datosQueFaltan(existente, datos);
      // Las fechas solo se completan junto con su permiso.
      if (!existente.consentimiento_datos_at && !cambios.consentimiento_datos_at) {
        delete cambios.fecha_nacimiento_jinete;
        delete cambios.anio_nacimiento_caballo;
      }
      if (Object.keys(cambios).length > 0) {
        const { error: errUpd } = await supabaseAdmin.from('binomios').update(cambios).eq('id', existente.id);
        if (errUpd) throw errUpd;
      }
      return NextResponse.json({ ...existente, ...cambios, ya_existia: true, completados: Object.keys(cambios) }, { status: 200 });
    }

    const { data, error } = await supabaseAdmin
      .from('binomios')
      .insert([datos])
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
  const auth = await verificarAdmin(request);
  if (!auth.ok) {
    return NextResponse.json({ error: auth.error }, { status: auth.status });
  }

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
  const auth = await verificarAdmin(request);
  if (!auth.ok) {
    return NextResponse.json({ error: auth.error }, { status: auth.status });
  }

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