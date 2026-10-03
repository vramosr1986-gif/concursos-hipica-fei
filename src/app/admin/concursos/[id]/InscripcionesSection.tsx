'use client';

import { useCallback, useEffect, useMemo, useState } from 'react';
import { supabase } from '@/lib/supabase';
import { esPendienteConfirmacion, nombreConMarca } from '@/lib/rfhe-pruebas';

type Inscripcion = {
  id: string;
  binomio_id: string;
  dorsal: number;
  categoria: string | null;
  binomio: { nombre_jinete: string; nombre_caballo: string } | null;
};

type BinomioRegistrado = {
  id: string;
  nombre_jinete: string;
  nombre_caballo: string;
  categoria_principal: string | null;
};

type CategoriaEdad = { id: string; codigo: string; nombre: string };
type PruebaConcurso = { id: string; nombre: string; fecha: string };
type PruebaDeInscripcion = { nombre: string; pendiente: boolean };

const normalizar = (texto: string) => texto.normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();

async function cabecerasAdmin(): Promise<HeadersInit> {
  const { data: { session } } = await supabase.auth.getSession();
  if (!session?.access_token) throw new Error('La sesión ha caducado. Inicia sesión de nuevo.');
  return { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` };
}

/**
 * Inscripciones del concurso. Si viene de la RFHE, los inscritos llegan con la
 * importación y solo se les pone el dorsal. Si es manual, se inscriben desde
 * el listado de binomios registrados.
 */
export function InscripcionesSection({ concursoId, esRfhe }: { concursoId: string; esRfhe: boolean }) {
  const [inscripciones, setInscripciones] = useState<Inscripcion[]>([]);
  const [pendientes, setPendientes] = useState<Set<string>>(new Set());
  const [pruebasPorInscripcion, setPruebasPorInscripcion] = useState<Map<string, PruebaDeInscripcion[]>>(new Map());
  const [pruebasConcurso, setPruebasConcurso] = useState<PruebaConcurso[]>([]);
  const [pruebasElegidas, setPruebasElegidas] = useState<Set<string>>(new Set());
  const [registrados, setRegistrados] = useState<BinomioRegistrado[]>([]);
  const [categorias, setCategorias] = useState<CategoriaEdad[]>([]);
  const [busqueda, setBusqueda] = useState('');
  const [marcados, setMarcados] = useState<Set<string>>(new Set());
  const [ocupado, setOcupado] = useState(false);
  const [error, setError] = useState('');

  const cargarInscripciones = useCallback(async () => {
    const res = await fetch('/api/inscripciones?concursoId=' + concursoId);
    const data: Inscripcion[] = res.ok ? await res.json() : [];
    setInscripciones(data || []);

    // Inscripciones con alguna participación "Pte. Confirmación" en la RFHE.
    const ids = (data || []).map((i) => i.id);
    if (ids.length === 0) {
      setPendientes(new Set());
      return;
    }
    const { data: parts } = await supabase
      .from('participaciones')
      .select('inscripcion_id, observaciones, prueba:prueba_id(nombre, fecha)')
      .in('inscripcion_id', ids);
    const porInscripcion = new Map<string, PruebaDeInscripcion[]>();
    const conPendiente = new Set<string>();
    for (const p of (parts || []) as any[]) {
      const pendiente = esPendienteConfirmacion(p.observaciones);
      if (pendiente) conPendiente.add(p.inscripcion_id);
      const lista = porInscripcion.get(p.inscripcion_id) || [];
      lista.push({ nombre: p.prueba?.nombre || '—', pendiente });
      porInscripcion.set(p.inscripcion_id, lista);
    }
    setPendientes(conPendiente);
    setPruebasPorInscripcion(porInscripcion);
  }, [concursoId]);

  useEffect(() => {
    cargarInscripciones();
    Promise.all([
      supabase.from('v_binomios_categorias').select('binomio_id, nombre_jinete, nombre_caballo, categoria_principal').order('nombre_jinete'),
      supabase.from('categorias_edad').select('id, codigo, nombre').order('orden'),
      supabase.from('pruebas').select('id, nombre, fecha').eq('concurso_id', concursoId).order('fecha').order('hora_inicio'),
    ]).then(([binomiosRes, categoriasRes, pruebasRes]) => {
      setPruebasConcurso(pruebasRes.data || []);
      setRegistrados((binomiosRes.data || []).map((b) => ({
        id: b.binomio_id, nombre_jinete: b.nombre_jinete, nombre_caballo: b.nombre_caballo, categoria_principal: b.categoria_principal,
      })));
      setCategorias(categoriasRes.data || []);
    });
  }, [cargarInscripciones, concursoId]);

  const yaInscritos = useMemo(() => new Set(inscripciones.map((i) => i.binomio_id)), [inscripciones]);
  const disponibles = useMemo(() => {
    const termino = normalizar(busqueda.trim());
    return registrados.filter((b) =>
      !yaInscritos.has(b.id) &&
      (!termino || normalizar(`${b.nombre_jinete} ${b.nombre_caballo}`).includes(termino))
    );
  }, [registrados, yaInscritos, busqueda]);

  const inscribir = async (binomios: BinomioRegistrado[]) => {
    setError('');
    setOcupado(true);
    try {
      const headers = await cabecerasAdmin();
      let dorsal = Math.max(0, ...inscripciones.map((i) => i.dorsal || 0));
      for (const b of binomios) {
        dorsal += 1;
        const categoria = categorias.find((c) => c.codigo === b.categoria_principal);
        const res = await fetch('/api/inscripciones', {
          method: 'POST',
          headers,
          body: JSON.stringify({
            binomio_id: b.id,
            concurso_id: concursoId,
            dorsal,
            orden_salida: dorsal,
            categoria: categoria?.nombre || null,
            categoria_edad_id: categoria?.id || null,
          }),
        });
        const creada = await res.json().catch(() => ({}));
        if (!res.ok) {
          throw new Error(`${b.nombre_jinete} / ${b.nombre_caballo}: ${creada.error || 'no se pudo inscribir'}`);
        }
        for (const pruebaId of pruebasElegidas) {
          const { data: ultimos } = await supabase
            .from('participaciones').select('orden_salida').eq('prueba_id', pruebaId)
            .order('orden_salida', { ascending: false }).limit(1);
          const { error: errPart } = await supabase.from('participaciones').insert({
            prueba_id: pruebaId,
            inscripcion_id: creada.id,
            orden_salida: (ultimos?.[0]?.orden_salida || 0) + 1,
            estado: 'pendiente',
          });
          if (errPart) throw new Error(`${b.nombre_jinete}: inscrito, pero no se pudo meter en una prueba (${errPart.message})`);
        }
      }
      setMarcados(new Set());
    } catch (err) {
      setError(err instanceof Error ? err.message : 'No se pudo inscribir');
    } finally {
      await cargarInscripciones();
      setOcupado(false);
    }
  };

  const cambiarDorsal = async (inscripcion: Inscripcion, valor: string) => {
    const dorsal = Number(valor);
    if (!valor.trim() || dorsal === inscripcion.dorsal) return;
    setError('');
    if (!Number.isInteger(dorsal) || dorsal < 1) {
      setError('El dorsal tiene que ser un número entero mayor que 0.');
      return;
    }
    const otro = inscripciones.find((i) => i.dorsal === dorsal && i.id !== inscripcion.id);
    if (otro) {
      setError(`El dorsal ${dorsal} ya lo tiene ${otro.binomio?.nombre_jinete || 'otro binomio'}.`);
      return;
    }
    const { error: dbError } = await supabase.from('inscripciones').update({ dorsal }).eq('id', inscripcion.id);
    if (dbError) {
      setError(`No se pudo guardar el dorsal: ${dbError.message}`);
      return;
    }
    setInscripciones((actuales) => actuales.map((i) => (i.id === inscripcion.id ? { ...i, dorsal } : i)));
  };

  const borrar = async (inscripcion: Inscripcion) => {
    setError('');
    setOcupado(true);
    try {
      const res = await fetch('/api/inscripciones?id=' + inscripcion.id, { method: 'DELETE', headers: await cabecerasAdmin() });
      if (!res.ok) {
        const body = await res.json().catch(() => ({}));
        throw new Error(body.error || 'No se pudo quitar la inscripción');
      }
      await cargarInscripciones();
    } catch (err) {
      setError(err instanceof Error ? err.message : 'No se pudo quitar la inscripción');
    } finally {
      setOcupado(false);
    }
  };

  const ordenadas = [...inscripciones].sort((a, b) => a.dorsal - b.dorsal);

  const listadoManual = (
    <>
      <div className="flex flex-wrap items-end justify-between gap-3">
        <div>
          <h3 className="font-bold">Binomios registrados</h3>
          <p className="text-sm text-gray-600">Marca las pruebas, busca el binomio y pulsa «Inscribir». Después puedes cambiar el dorsal arriba.</p>
        </div>
        {marcados.size > 0 && (
          <button
            type="button"
            disabled={ocupado}
            onClick={() => inscribir(disponibles.filter((b) => marcados.has(b.id)))}
            className="btn btn-primary text-sm"
          >
            Inscribir los {marcados.size} marcados
          </button>
        )}
      </div>
      <fieldset className="mt-3 rounded border border-[#e4dfd4] p-3">
        <legend className="px-1 text-sm font-semibold">1. ¿En qué pruebas participa?</legend>
        {pruebasConcurso.length === 0 ? (
          <p className="text-sm text-amber-700">Primero crea las pruebas del concurso (más abajo).</p>
        ) : (
          <div className="flex flex-wrap gap-x-5 gap-y-2">
            {pruebasConcurso.map((p) => (
              <label key={p.id} className="flex items-center gap-2 text-sm">
                <input
                  type="checkbox"
                  checked={pruebasElegidas.has(p.id)}
                  onChange={() => setPruebasElegidas((actual) => {
                    const n = new Set(actual);
                    if (n.has(p.id)) n.delete(p.id); else n.add(p.id);
                    return n;
                  })}
                />
                {p.nombre}
              </label>
            ))}
          </div>
        )}
      </fieldset>
      <p className="mt-3 text-sm font-semibold">2. Busca el binomio y pulsa «Inscribir»</p>
      <input
        type="search"
        aria-label="Buscar binomio por jinete o caballo"
        value={busqueda}
        onChange={(e) => setBusqueda(e.target.value)}
        placeholder="Buscar jinete o caballo…"
        className="input mt-3 w-full"
      />
      <div className="mt-3 max-h-96 overflow-auto rounded border border-[#e4dfd4]">
        {disponibles.length === 0 ? (
          <p className="p-4 text-sm text-gray-600">
            {registrados.length === 0 ? 'No hay binomios registrados.' : 'No queda ningún binomio por inscribir con esa búsqueda.'}
          </p>
        ) : (
          <table className="min-w-full text-left text-sm">
            <thead className="sticky top-0 bg-[#f4f0e6] text-xs uppercase text-[#466257]">
              <tr>
                <th className="px-3 py-2"><span className="sr-only">Marcar</span></th>
                <th className="px-3 py-2">Jinete</th>
                <th className="px-3 py-2">Caballo</th>
                <th className="px-3 py-2">Categoría</th>
                <th className="px-3 py-2"></th>
              </tr>
            </thead>
            <tbody>
              {disponibles.map((b) => (
                <tr key={b.id} className="border-t border-[#eee9df]">
                  <td className="px-3 py-2">
                    <input
                      type="checkbox"
                      aria-label={`Marcar ${b.nombre_jinete} / ${b.nombre_caballo}`}
                      checked={marcados.has(b.id)}
                      onChange={() => setMarcados((m) => {
                        const n = new Set(m);
                        if (n.has(b.id)) n.delete(b.id); else n.add(b.id);
                        return n;
                      })}
                    />
                  </td>
                  <td className="px-3 py-2">{b.nombre_jinete}</td>
                  <td className="px-3 py-2">{b.nombre_caballo}</td>
                  <td className="px-3 py-2">{categorias.find((c) => c.codigo === b.categoria_principal)?.nombre || '—'}</td>
                  <td className="px-3 py-2 text-right">
                    <button type="button" disabled={ocupado} onClick={() => inscribir([b])} className="btn btn-outline btn-sm">
                      Inscribir
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </>
  );

  return (
    <div className="card p-6 max-w-4xl mb-8">
      <div className="mb-4 flex items-center justify-between gap-4">
        <div>
          <h2 className="text-xl font-bold">Binomios inscritos</h2>
          <p className="mt-1 text-sm text-gray-600">
            {esRfhe
              ? 'Concurso de la RFHE: los binomios admitidos vienen de la Federación. Solo tienes que poner el dorsal. Si hace falta, abajo puedes añadir alguno a mano.'
              : 'Concurso manual: inscribe los binomios desde el listado de binomios registrados de más abajo y pon el dorsal.'}
          </p>
        </div>
        <div className="text-right">
          <p className="text-xs text-gray-500">Total inscritos</p>
          <p className="text-2xl font-bold">{inscripciones.length}</p>
        </div>
      </div>

      {error && <p role="alert" className="mb-4 rounded border border-red-200 bg-red-50 p-3 text-sm text-red-700">{error}</p>}

      {inscripciones.length === 0 ? (
        <p className="mb-6 text-gray-600">Todavía no hay binomios inscritos.</p>
      ) : (
        <div className="table-responsive mb-2">
          <table className="table">
            <thead>
              <tr>
                <th>Dorsal</th>
                <th>Jinete</th>
                <th>Caballo</th>
                <th>Pruebas</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {ordenadas.map((i) => (
                <tr key={i.id}>
                  <td>
                    <input
                      key={`${i.id}-${i.dorsal}`}
                      type="number"
                      min={1}
                      defaultValue={i.dorsal}
                      aria-label={`Dorsal de ${i.binomio?.nombre_jinete || 'este binomio'}`}
                      title="Escribe el dorsal y pulsa Intro o haz clic fuera para guardarlo"
                      className="input w-20 font-bold"
                      onKeyDown={(e) => { if (e.key === 'Enter') (e.target as HTMLInputElement).blur(); }}
                      onBlur={(e) => cambiarDorsal(i, e.target.value)}
                    />
                  </td>
                  <td>{nombreConMarca(i.binomio?.nombre_jinete || '-', pendientes.has(i.id))}</td>
                  <td>{i.binomio?.nombre_caballo || '-'}</td>
                  <td className="text-sm">
                    {(pruebasPorInscripcion.get(i.id) || []).length === 0
                      ? <span className="text-amber-700">En ninguna prueba</span>
                      : (pruebasPorInscripcion.get(i.id) || []).map((p) => nombreConMarca(p.nombre, p.pendiente)).join(', ')}
                  </td>
                  <td className="text-right">
                    <button type="button" disabled={ocupado} onClick={() => borrar(i)} className="text-sm text-danger hover:underline">
                      Quitar del concurso
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
      {pendientes.size > 0 && (
        <p className="mb-6 text-sm text-gray-600">* Pendiente de confirmación en la RFHE.</p>
      )}

      {esRfhe ? (
        <details className="mt-6 border-t pt-4">
          <summary className="cursor-pointer font-semibold text-[#173b2f]">
            Añadir a mano un binomio que no viene en la lista de la RFHE (extra)
          </summary>
          <div className="mt-3">{listadoManual}</div>
        </details>
      ) : (
        <section className="mt-6 border-t pt-4">{listadoManual}</section>
      )}
    </div>
  );
}
