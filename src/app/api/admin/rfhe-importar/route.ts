import { NextRequest, NextResponse } from 'next/server';
import { verificarAdmin } from '@/lib/api-guard';
import { supabaseAdmin } from '@/lib/supabase-admin';
import { extraer, validarUrl } from '@/lib/rfhe';
import {
  categoriaDeReprise, claveReprise, crearUrlInscritos, emparejarReprise, esPendienteConfirmacion, fechaDeJornada, sugerirJornada,
} from '@/lib/rfhe-pruebas';

export const runtime = 'nodejs';

type Reprise = { id: string; nombre: string; categoria: string | null };
type CategoriaEdad = { id: string; codigo: string; nombre: string };
type Binomio = { id: string; nombre_jinete: string; nombre_caballo: string; ldn_jinete: string | null; lac_caballo: string | null };

const clave = (texto: string | null | undefined) =>
  (texto || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase().replace(/\s+/g, ' ').trim();

function lanzar(error: { message: string } | null, que: string) {
  if (error) throw new Error(`${que}: ${error.message}`);
}

/**
 * Trae de la RFHE los inscritos de un concurso y crea en la base de datos:
 * binomios (si no existen), inscripciones, una prueba por reprise y los
 * participantes de cada prueba. Se puede repetir: nada se duplica.
 */
export async function POST(request: NextRequest) {
  const auth = await verificarAdmin(request);
  if (!auth.ok) return NextResponse.json({ error: auth.error }, { status: auth.status });

  try {
    const body = await request.json();
    const concursoId = typeof body.concurso_id === 'string' ? body.concurso_id : '';
    if (!concursoId) throw new Error('Falta el concurso');

    const urlConcurso = validarUrl(body.url, 'concurso');
    const urlInscritos = validarUrl(crearUrlInscritos(urlConcurso.toString()) || urlConcurso.toString(), 'inscritos');

    const { data: concurso, error: errConcurso } = await supabaseAdmin
      .from('concursos').select('id, fecha_inicio, fecha_fin').eq('id', concursoId).single();
    lanzar(errConcurso, 'No se encontró el concurso');
    if (!concurso) throw new Error('No se encontró el concurso');

    // Marca el concurso como importado de la RFHE (los inscritos vienen de allí, no se añaden a mano).
    const { error: errUrl } = await supabaseAdmin.from('concursos').update({ rfhe_url: urlConcurso.toString() }).eq('id', concursoId);
    lanzar(errUrl, 'No se pudo guardar el enlace RFHE del concurso (¿falta ejecutar la migración 047?)');

    const pagina = await extraer(urlInscritos);
    const inscritos = pagina.datos.inscritos || [];
    if (inscritos.length === 0) {
      return NextResponse.json({ error: 'La RFHE todavía no tiene inscritos publicados para este concurso.' }, { status: 404 });
    }

    const [repRes, catRes] = await Promise.all([
      supabaseAdmin.from('reprises').select('id, nombre, categoria'),
      supabaseAdmin.from('categorias_edad').select('id, codigo, nombre'),
    ]);
    lanzar(repRes.error, 'No se pudo leer el catálogo de reprises');
    const reprises = (repRes.data || []) as Reprise[];
    const categorias = (catRes.data || []) as CategoriaEdad[];

    // ---- 1. Binomios (jinete + caballo), en el orden de la lista RFHE ----
    type Fila = { jinete: string; ldn: string; caballo: string; lac: string; reprise: string; observaciones: string };
    const filas: Fila[] = inscritos.flatMap((i) => i.reprises
      .filter((r) => r.caballo && r.reprise)
      .map((r) => ({ jinete: i.jinete, ldn: i.ldn, caballo: r.caballo, lac: r.lac, reprise: r.reprise, observaciones: r.observaciones })));
    const claveBinomio = (f: { ldn: string; lac: string; jinete: string; caballo: string }) =>
      f.ldn && f.lac ? `${f.ldn}|${f.lac}` : `${clave(f.jinete)}|${clave(f.caballo)}`;

    const unicos = new Map<string, Fila>();
    for (const f of filas) if (!unicos.has(claveBinomio(f))) unicos.set(claveBinomio(f), f);

    const lacs = Array.from(new Set(Array.from(unicos.values()).map((f) => f.lac).filter(Boolean)));
    const existentes: Binomio[] = [];
    for (let i = 0; i < lacs.length; i += 200) {
      const { data, error } = await supabaseAdmin
        .from('binomios').select('id, nombre_jinete, nombre_caballo, ldn_jinete, lac_caballo')
        .in('lac_caballo', lacs.slice(i, i + 200));
      lanzar(error, 'No se pudieron leer los binomios');
      existentes.push(...((data || []) as Binomio[]));
    }
    const binomioPorClave = new Map<string, string>();
    for (const b of existentes) {
      binomioPorClave.set(claveBinomio({ ldn: b.ldn_jinete || '', lac: b.lac_caballo || '', jinete: b.nombre_jinete, caballo: b.nombre_caballo }), b.id);
    }

    const nuevosBinomios = Array.from(unicos.entries()).filter(([k]) => !binomioPorClave.has(k));
    if (nuevosBinomios.length > 0) {
      const { data, error } = await supabaseAdmin.from('binomios').insert(nuevosBinomios.map(([, f]) => ({
        nombre_jinete: f.jinete,
        nombre_caballo: f.caballo,
        ldn_jinete: f.ldn || null,
        lac_caballo: f.lac || null,
      }))).select('id, nombre_jinete, nombre_caballo, ldn_jinete, lac_caballo');
      lanzar(error, 'No se pudieron crear los binomios');
      for (const b of (data || []) as Binomio[]) {
        binomioPorClave.set(claveBinomio({ ldn: b.ldn_jinete || '', lac: b.lac_caballo || '', jinete: b.nombre_jinete, caballo: b.nombre_caballo }), b.id);
      }
    }

    // ---- 2. Inscripciones (una por binomio; dorsal correlativo) ----
    const { data: inscActuales, error: errInsc } = await supabaseAdmin
      .from('inscripciones').select('id, binomio_id, dorsal').eq('concurso_id', concursoId);
    lanzar(errInsc, 'No se pudieron leer las inscripciones');
    const inscripcionPorBinomio = new Map((inscActuales || []).map((i) => [i.binomio_id as string, i.id as string]));
    let dorsal = Math.max(0, ...(inscActuales || []).map((i) => Number(i.dorsal) || 0));

    const nuevasInscripciones = Array.from(unicos.entries())
      .map(([k, f]) => ({ binomioId: binomioPorClave.get(k)!, fila: f }))
      .filter(({ binomioId }) => binomioId && !inscripcionPorBinomio.has(binomioId))
      .map(({ binomioId, fila }) => {
        const cat = categoriaDeReprise(emparejarReprise(fila.reprise, reprises), categorias);
        dorsal += 1;
        return {
          binomio_id: binomioId,
          concurso_id: concursoId,
          dorsal,
          orden_salida: dorsal,
          categoria: cat?.nombre || null,
          categoria_edad_id: cat?.id || null,
        };
      });
    if (nuevasInscripciones.length > 0) {
      const { data, error } = await supabaseAdmin.from('inscripciones').insert(nuevasInscripciones).select('id, binomio_id');
      lanzar(error, 'No se pudieron crear las inscripciones');
      for (const i of data || []) inscripcionPorBinomio.set(i.binomio_id, i.id);
    }

    // ---- 3. Pruebas (una por reprise de la RFHE) ----
    const { data: pruebasActuales, error: errPruebas } = await supabaseAdmin
      .from('pruebas').select('id, nombre, orden').eq('concurso_id', concursoId);
    lanzar(errPruebas, 'No se pudieron leer las pruebas');
    const pruebaPorNombre = new Map((pruebasActuales || []).map((p) => [claveReprise(p.nombre), p.id as string]));
    let orden = Math.max(0, ...(pruebasActuales || []).map((p) => Number(p.orden) || 0));

    const nombresReprise = Array.from(new Set(filas.map((f) => f.reprise)));
    const sinReprise: string[] = [];
    const nuevasPruebas = nombresReprise
      .filter((n) => !pruebaPorNombre.has(claveReprise(n)))
      .map((nombre) => {
        const reprise = emparejarReprise(nombre, reprises);
        if (!reprise) sinReprise.push(nombre);
        const cat = categoriaDeReprise(reprise, categorias);
        const jornada = sugerirJornada(reprise?.nombre || nombre);
        return {
          nombre,
          reprise,
          jornada,
          fila: {
            concurso_id: concursoId,
            reprise_id: reprise?.id || null,
            nombre,
            categoria: cat?.nombre || null,
            categoria_edad_id: cat?.id || null,
            fecha: fechaDeJornada(jornada, concurso.fecha_inicio, concurso.fecha_fin),
            hora_inicio: '09:00:00',
            estado: 'programada',
          },
        };
      })
      // Sábado antes que domingo; dentro del día, en el orden de la lista RFHE.
      .sort((a, b) => a.fila.fecha.localeCompare(b.fila.fecha))
      .map((p) => ({ ...p, fila: { ...p.fila, orden: ++orden } }));

    if (nuevasPruebas.length > 0) {
      const { data, error } = await supabaseAdmin.from('pruebas').insert(nuevasPruebas.map((p) => p.fila)).select('id, nombre');
      lanzar(error, 'No se pudieron crear las pruebas');
      for (const p of data || []) pruebaPorNombre.set(claveReprise(p.nombre), p.id);
    }

    // ---- 4. Participantes de cada prueba (orden = orden de la lista RFHE) ----
    const pruebaIds = Array.from(new Set(nombresReprise.map((n) => pruebaPorNombre.get(claveReprise(n))!).filter(Boolean)));
    const { data: partActuales, error: errPart } = await supabaseAdmin
      .from('participaciones').select('id, prueba_id, inscripcion_id, orden_salida, observaciones').in('prueba_id', pruebaIds);
    lanzar(errPart, 'No se pudieron leer los participantes');
    const yaEsta = new Map((partActuales || []).map((p) => [`${p.prueba_id}|${p.inscripcion_id}`, p]));
    const ordenPorPrueba = new Map<string, number>();
    for (const p of partActuales || []) {
      ordenPorPrueba.set(p.prueba_id, Math.max(ordenPorPrueba.get(p.prueba_id) || 0, Number(p.orden_salida) || 0));
    }

    const nuevasParticipaciones: { prueba_id: string; inscripcion_id: string; orden_salida: number; estado: string; observaciones: string | null }[] = [];
    const cambiosObservaciones: { id: string; observaciones: string | null }[] = [];
    for (const f of filas) {
      const pruebaId = pruebaPorNombre.get(claveReprise(f.reprise));
      const inscripcionId = inscripcionPorBinomio.get(binomioPorClave.get(claveBinomio(f)) || '');
      if (!pruebaId || !inscripcionId) continue;
      const observaciones = f.observaciones.trim() || null;
      const existente = yaEsta.get(`${pruebaId}|${inscripcionId}`);
      if (existente) {
        // La RFHE quita el "Pte. Confirmación" al confirmar: se actualiza.
        if (existente.id && (existente.observaciones || null) !== observaciones) {
          cambiosObservaciones.push({ id: existente.id, observaciones });
          existente.observaciones = observaciones;
        }
        continue;
      }
      yaEsta.set(`${pruebaId}|${inscripcionId}`, { id: '', prueba_id: pruebaId, inscripcion_id: inscripcionId, orden_salida: 0, observaciones });
      const siguiente = (ordenPorPrueba.get(pruebaId) || 0) + 1;
      ordenPorPrueba.set(pruebaId, siguiente);
      nuevasParticipaciones.push({ prueba_id: pruebaId, inscripcion_id: inscripcionId, orden_salida: siguiente, estado: 'pendiente', observaciones });
    }
    for (let i = 0; i < nuevasParticipaciones.length; i += 500) {
      const { error } = await supabaseAdmin.from('participaciones').insert(nuevasParticipaciones.slice(i, i + 500));
      lanzar(error, 'No se pudieron crear los participantes');
    }
    for (const c of cambiosObservaciones) {
      const { error } = await supabaseAdmin.from('participaciones').update({ observaciones: c.observaciones }).eq('id', c.id);
      lanzar(error, 'No se pudieron actualizar las observaciones');
    }

    return NextResponse.json({
      fuente: pagina.datos.url,
      jinetes: inscritos.length,
      binomios_nuevos: nuevosBinomios.length,
      inscripciones_nuevas: nuevasInscripciones.length,
      pruebas_nuevas: nuevasPruebas.length,
      participaciones_nuevas: nuevasParticipaciones.length,
      observaciones_actualizadas: cambiosObservaciones.length,
      pendientes_confirmacion: filas.filter((f) => esPendienteConfirmacion(f.observaciones)).length,
      pruebas_sin_reprise: sinReprise,
    });
  } catch (error) {
    return NextResponse.json(
      { error: error instanceof Error ? error.message : 'No se pudo importar desde la RFHE' },
      { status: 400 }
    );
  }
}
