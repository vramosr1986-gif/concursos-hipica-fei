import { createClient } from '@supabase/supabase-js';
import { supabaseAdmin } from './supabase-admin';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

export type GuardResult =
  | { ok: true; userId: string; rol: string }
  | { ok: false; error: string; status: number };

// Valida que la peticion traiga un token de sesion valido y devuelve el rol.
async function autenticar(request: Request): Promise<GuardResult> {
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

  const { data: profile } = await supabaseAdmin
    .from('profiles')
    .select('rol')
    .eq('id', userData.user.id)
    .single();

  const rol = profile?.rol || null;
  if (!rol) {
    return { ok: false, error: 'Usuario sin rol asignado', status: 403 };
  }

  return { ok: true, userId: userData.user.id, rol };
}

// Requiere sesion + rol admin.
export async function verificarAdmin(request: Request): Promise<GuardResult> {
  const auth = await autenticar(request);
  if (!auth.ok) return auth;
  if (auth.rol !== 'admin') {
    return { ok: false, error: 'No tienes permisos de admin', status: 403 };
  }
  return auth;
}

// Requiere sesion + rol admin o juez (para puntuaciones).
export async function verificarAdminOJuez(request: Request): Promise<GuardResult> {
  const auth = await autenticar(request);
  if (!auth.ok) return auth;
  if (auth.rol !== 'admin' && auth.rol !== 'juez') {
    return { ok: false, error: 'Permiso denegado', status: 403 };
  }
  return auth;
}