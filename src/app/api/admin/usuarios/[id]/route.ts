import { NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { supabaseAdmin } from '@/lib/supabase-admin';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

async function verificarAdmin(request: Request) {
  const authHeader = request.headers.get('authorization') || '';
  const token = authHeader.replace('Bearer ', '');

  if (!token) {
    return { ok: false, error: 'No hay token de sesion', status: 401 };
  }

  const supabaseUser = createClient(supabaseUrl, supabaseAnonKey, {
    global: { headers: { Authorization: `Bearer ${token}` } },
  });

  const { data: userData, error: userError } = await supabaseUser.auth.getUser();
  if (userError || !userData?.user) {
    return { ok: false, error: 'Token invalido', status: 401 };
  }

  const { data: profile, error: profileError } = await supabaseAdmin
    .from('profiles')
    .select('rol')
    .eq('id', userData.user.id)
    .single();

  if (profileError || !profile || profile.rol !== 'admin') {
    return { ok: false, error: 'No tienes permisos de admin', status: 403 };
  }

  return { ok: true, user: userData.user };
}

export async function DELETE(
  request: Request,
  { params }: { params: { id: string } }
) {
  const auth = await verificarAdmin(request);
  if (!auth.ok) {
    return NextResponse.json({ error: auth.error }, { status: auth.status });
  }

  // 1. No puedes eliminarte a ti mismo
  if (auth.user?.id === params.id) {
    return NextResponse.json(
      { error: 'No puedes eliminarte a ti mismo' },
      { status: 400 }
    );
  }

  // 2. Obtener el perfil del usuario a eliminar
  const { data: targetProfile, error: targetError } = await supabaseAdmin
    .from('profiles')
    .select('rol')
    .eq('id', params.id)
    .single();

  if (targetError || !targetProfile) {
    return NextResponse.json(
      { error: 'El usuario no existe' },
      { status: 404 }
    );
  }

  // 3. Si el objetivo es admin, verificar que queden más admins
  if (targetProfile.rol === 'admin') {
    const { count: adminsCount, error: countError } = await supabaseAdmin
      .from('profiles')
      .select('*', { count: 'exact', head: true })
      .eq('rol', 'admin');

    if (countError) {
      return NextResponse.json(
        { error: 'Error al verificar admins' },
        { status: 500 }
      );
    }

    if (adminsCount !== null && adminsCount <= 1) {
      return NextResponse.json(
        {
          error:
            'No puedes eliminar al ultimo administrador. Asigna primero otro admin.',
        },
        { status: 400 }
      );
    }
  }

  // 4. Eliminar el usuario de Auth (el CASCADE borra profiles)
  const { error: deleteError } = await supabaseAdmin.auth.admin.deleteUser(
    params.id
  );

  if (deleteError) {
    return NextResponse.json({ error: deleteError.message }, { status: 500 });
  }

  return NextResponse.json({ ok: true });
}

export async function PATCH(
  request: Request,
  { params }: { params: { id: string } }
) {
  const auth = await verificarAdmin(request);
  if (!auth.ok) {
    return NextResponse.json({ error: auth.error }, { status: auth.status });
  }

  const body = await request.json();
  const { rol } = body;

  if (rol !== 'admin' && rol !== 'juez') {
    return NextResponse.json({ error: 'Rol invalido' }, { status: 400 });
  }

  // Si vamos a degradar a un admin a juez, verificar que queden admins
  if (rol === 'juez') {
    const { data: targetProfile } = await supabaseAdmin
      .from('profiles')
      .select('rol')
      .eq('id', params.id)
      .single();

    if (targetProfile?.rol === 'admin') {
      const { count: adminsCount } = await supabaseAdmin
        .from('profiles')
        .select('*', { count: 'exact', head: true })
        .eq('rol', 'admin');

      if (adminsCount !== null && adminsCount <= 1) {
        return NextResponse.json(
          {
            error:
              'No puedes quitar el rol admin al ultimo administrador. Asigna primero otro admin.',
          },
          { status: 400 }
        );
      }
    }
  }

  const { error } = await supabaseAdmin
    .from('profiles')
    .update({ rol, updated_at: new Date().toISOString() })
    .eq('id', params.id);

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({ ok: true });
}