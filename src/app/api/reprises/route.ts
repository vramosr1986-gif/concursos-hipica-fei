import { NextRequest, NextResponse } from 'next/server';
import { supabase } from '@/lib/supabase-server';
import { verificarAdmin } from '@/lib/api-guard';

// GET: obtener reprises
export async function GET() {
  try {
    const { data, error } = await supabase
      .from('reprises')
      .select('*')
      .order('fei_numero', { ascending: true });

    if (error) throw error;

    return NextResponse.json(data);
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}

// POST: crear nueva reprise
export async function POST(request: NextRequest) {
  const auth = await verificarAdmin(request);
  if (!auth.ok) {
    return NextResponse.json({ error: auth.error }, { status: auth.status });
  }

  try {
    const body = await request.json();

    const { data, error } = await supabase
      .from('reprises')
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
    const { error } = await supabase.from('reprises').delete().eq('id', id);
    if (error) throw error;
    return NextResponse.json({ success: true });
  } catch (error) {
    return NextResponse.json(
      { error: (error as Error).message },
      { status: 500 }
    );
  }
}


