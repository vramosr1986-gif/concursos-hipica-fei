import { NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { supabaseAdmin } from '@/lib/supabase-admin';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

async function verificarAdmin(request: Request) {
  const authHeader = request.headers.get('authorization') || '';
  const token = authHeader.replace('Bearer ', '');

  console.log('=== [verificarAdmin] INICIO ===');
  console.log('[1] Token recibido:', token ? token.slice(0, 30) + '...' : 'VACIO');
  console.log('[1b] Longitud token:', token.length);

  if (!token) {
    return { ok: false, error: 'No hay token de sesion', status: 401 };
  }

  const supabaseUser = createClient(supabaseUrl, supabaseAnonKey, {
    global: { headers: { Authorization: `Bearer ${token}` } },
  });

  const { data: userData, error: userError } = await supabaseUser.auth.getUser();
  console.log('[2] userData:', userData?.user?.id, '|', userData?.user?.email);
  console.log('[2b] userError:', userError?.message || 'null');

  if (userError || !userData?.user) {
    return { ok: false, error: 'Token invalido', status: 401 };
  }

  const { data: profile, error: profileError } = await supabaseAdmin
    .from('profiles')
    .select('rol')
    .eq('id', userData.user.id)
    .single();

  console.log('[3] profile:', JSON.stringify(profile));
  console.log('[3b] profileError:', profileError?.message || 'null');
  console.log('[3c] Rol esperado admin, rol actual:', profile?.rol);
  console.log('=== [verificarAdmin] FIN ===');

  if (profileError || !profile || profile.rol !== 'admin') {
    return { ok: false, error: 'No tienes permisos de admin', status: 403 };
  }

  return { ok: true, user: userData.user };
}

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
