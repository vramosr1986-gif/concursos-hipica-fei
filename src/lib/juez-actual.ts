// Con qué juez (letra) se puntúa una prueba. Un juez puntúa con su propia
// asignación; un admin puede puntuar en nombre de cualquier juez de la prueba.
import { supabase } from './supabase';

export type JuezDeLaPrueba = { id: string; letra: string; nombre: string };

export type PuntuadorActual =
  | { ok: true; esAdmin: boolean; pruebaJuezId: string; letra: string; nombreJuez: string; jueces: JuezDeLaPrueba[] }
  | { ok: false; error: string; esAdmin: boolean; jueces: JuezDeLaPrueba[] };

/** `?pj=` en la URL: asignación elegida por el admin para puntuar. */
export function pruebaJuezDeLaUrl(): string | null {
  if (typeof window === 'undefined') return null;
  return new URLSearchParams(window.location.search).get('pj');
}

export async function resolverPuntuador(pruebaId: string, pruebaJuezElegido: string | null): Promise<PuntuadorActual> {
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return { ok: false, error: 'No has iniciado sesión.', esAdmin: false, jueces: [] };

  const [{ data: perfil }, { data: asignaciones }] = await Promise.all([
    supabase.from('profiles').select('rol').eq('id', user.id).single(),
    supabase.from('prueba_jueces').select('id, letra, juez_id, juez:juez_id(nombre, email)').eq('prueba_id', pruebaId).order('letra'),
  ]);
  const esAdmin = perfil?.rol === 'admin';
  const filas = (asignaciones || []) as any[];
  const jueces: JuezDeLaPrueba[] = filas.map((a) => ({ id: a.id, letra: a.letra, nombre: a.juez?.nombre || a.juez?.email || 'Sin nombre' }));
  const propia = filas.find((a) => a.juez_id === user.id);

  let elegida = null as (typeof filas)[number] | null;
  if (esAdmin) {
    elegida = filas.find((a) => a.id === pruebaJuezElegido) || propia || (filas.length === 1 ? filas[0] : null);
    if (!elegida) {
      return {
        ok: false,
        esAdmin,
        jueces,
        error: jueces.length === 0
          ? 'Esta prueba todavía no tiene jueces. Asígnalos primero (en Pruebas o al abrir la prueba).'
          : 'Elige con qué juez vas a puntuar.',
      };
    }
  } else {
    elegida = propia || null;
    if (!elegida) return { ok: false, esAdmin, jueces: [], error: 'No tienes asignada esta prueba como juez.' };
  }

  return {
    ok: true,
    esAdmin,
    jueces,
    pruebaJuezId: elegida.id,
    letra: elegida.letra,
    nombreJuez: elegida.juez?.nombre || elegida.juez?.email || '',
  };
}

/** fetch con el token de la sesión (las API de puntuaciones lo exigen). */
export async function fetchConSesion(url: string, init: RequestInit = {}): Promise<Response> {
  const { data: { session } } = await supabase.auth.getSession();
  return fetch(url, {
    ...init,
    headers: {
      'Content-Type': 'application/json',
      ...(init.headers || {}),
      Authorization: `Bearer ${session?.access_token || ''}`,
    },
  });
}
