// Inscribir un binomio en un concurso (dorsal siguiente) y meterlo en las
// pruebas elegidas. Si ya estaba inscrito o ya estaba en una prueba, no se duplica.
import { supabase } from './supabase';
import { fetchConSesion } from './juez-actual';

export type PruebaParaInscribir = { id: string; categoria: string | null; categoria_edad_id: string | null };

export async function inscribirEnConcurso(
  concursoId: string,
  binomioId: string,
  pruebas: PruebaParaInscribir[],
): Promise<{ inscripcionId: string; dorsal: number; yaEstaba: boolean }> {
  const { data: actuales, error } = await supabase
    .from('inscripciones').select('id, binomio_id, dorsal').eq('concurso_id', concursoId);
  if (error) throw new Error(error.message);

  let inscripcion = (actuales || []).find((i) => i.binomio_id === binomioId);
  const yaEstaba = Boolean(inscripcion);
  if (!inscripcion) {
    const dorsal = Math.max(0, ...(actuales || []).map((i) => Number(i.dorsal) || 0)) + 1;
    // La categoría la marca la primera prueba elegida (su reprise).
    const res = await fetchConSesion('/api/inscripciones', {
      method: 'POST',
      body: JSON.stringify({
        binomio_id: binomioId,
        concurso_id: concursoId,
        dorsal,
        orden_salida: dorsal,
        categoria: pruebas[0]?.categoria || null,
        categoria_edad_id: pruebas[0]?.categoria_edad_id || null,
      }),
    });
    const creada = await res.json().catch(() => ({}));
    if (!res.ok) throw new Error(creada.error || 'No se pudo inscribir en el concurso');
    inscripcion = { id: creada.id, binomio_id: binomioId, dorsal };
  }

  for (const prueba of pruebas) {
    const { data: ya } = await supabase
      .from('participaciones').select('id').eq('prueba_id', prueba.id).eq('inscripcion_id', inscripcion.id).maybeSingle();
    if (ya) continue;
    const { data: ultimos } = await supabase
      .from('participaciones').select('orden_salida').eq('prueba_id', prueba.id)
      .order('orden_salida', { ascending: false }).limit(1);
    const { error: errPart } = await supabase.from('participaciones').insert({
      prueba_id: prueba.id,
      inscripcion_id: inscripcion.id,
      orden_salida: (ultimos?.[0]?.orden_salida || 0) + 1,
      estado: 'pendiente',
    });
    if (errPart) throw new Error(`Inscrito, pero no se pudo meter en una prueba: ${errPart.message}`);
  }

  return { inscripcionId: inscripcion.id, dorsal: Number(inscripcion.dorsal), yaEstaba };
}
