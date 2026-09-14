import { NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase-admin';
import { verificarAdmin } from '@/lib/api-guard';

export async function GET(request: Request) {
  const auth = await verificarAdmin(request);
  if (!auth.ok) {
    return NextResponse.json({ error: auth.error }, { status: auth.status });
  }

  const { data, error } = await supabaseAdmin
    .from('profiles')
    .select('id, email, nombre, rol, created_at')
    .order('created_at', { ascending: false });

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({ usuarios: data });
}

export async function POST(request: Request) {
  const auth = await verificarAdmin(request);
  if (!auth.ok) {
    return NextResponse.json({ error: auth.error }, { status: auth.status });
  }

  try {
    const body = await request.json();
    const { email, password, nombre, role } = body;

    if (!email || !password) {
      return NextResponse.json(
        { error: 'Email y contrasena son obligatorios' },
        { status: 400 }
      );
    }

    const rolFinal = role === 'admin' ? 'admin' : 'juez';

    const { data: authData, error: authError } =
      await supabaseAdmin.auth.admin.createUser({
        email,
        password,
        email_confirm: true,
        user_metadata: { nombre },
      });

    if (authError || !authData.user) {
      return NextResponse.json(
        { error: authError?.message || 'Error al crear el usuario' },
        { status: 400 }
      );
    }

    const { error: profileError } = await supabaseAdmin
      .from('profiles')
      .insert({
        id: authData.user.id,
        email,
        nombre: nombre || null,
        rol: rolFinal,
      });

    if (profileError) {
      await supabaseAdmin.auth.admin.deleteUser(authData.user.id);
      return NextResponse.json(
        { error: profileError.message },
        { status: 500 }
      );
    }

    return NextResponse.json({
      ok: true,
      usuario: {
        id: authData.user.id,
        email,
        nombre,
        rol: rolFinal,
      },
    });
  } catch (err: any) {
    return NextResponse.json(
      { error: err.message || 'Error inesperado' },
      { status: 500 }
    );
  }
}