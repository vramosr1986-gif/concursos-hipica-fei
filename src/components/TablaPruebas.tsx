'use client';

import { Fragment, useMemo, useState } from 'react';
import Link from 'next/link';
import { ArrowDown, ArrowDownUp, ArrowUp, Plus, X } from 'lucide-react';
import { formatearFecha } from '@/lib/fechas';

export const LETRAS_JUEZ = ['A', 'B', 'C', 'D', 'E'];

export type JuezDePrueba = { id: string; juez_id: string; letra: string; nombre: string };

export type FilaPrueba = {
  id: string;
  concurso_id: string;
  concurso_nombre: string;
  nombre: string;
  fecha: string;
  hora_inicio: string;
  pista: string | null;
  categoria: string | null;
  estado: string | null;
  reprise_nombre: string | null;
  reprise_codigo: string | null;
  jueces: JuezDePrueba[];
  num_binomios: number;
  /** Solo en el panel del juez. */
  letra_juez?: string;
  num_puntuaciones?: number;
};

type OpcionJuez = { id: string; nombre: string };

type Props =
  | { modo: 'juez'; pruebas: FilaPrueba[] }
  | {
      modo: 'admin';
      pruebas: FilaPrueba[];
      juecesDisponibles: OpcionJuez[];
      onCambiarPista: (pruebaIds: string[], pista: string) => Promise<void>;
      onAsignarJuez: (pruebaIds: string[], juezId: string, letra: string) => Promise<void>;
      onQuitarJuez: (asignacionId: string) => Promise<void>;
    };

type CampoOrden = 'fecha' | 'concurso' | 'nombre' | 'reprise' | 'pista';
type Agrupacion = 'ninguna' | 'concurso' | 'fecha' | 'reprise' | 'pista';

const normalizar = (texto: string | null | undefined) =>
  (texto || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLocaleLowerCase('es');

const textoReprise = (p: FilaPrueba) => p.reprise_nombre || '';

function valorOrden(p: FilaPrueba, campo: CampoOrden): string {
  switch (campo) {
    case 'fecha': return `${p.fecha} ${p.hora_inicio}`;
    case 'concurso': return p.concurso_nombre;
    case 'nombre': return p.nombre;
    case 'reprise': return textoReprise(p);
    case 'pista': return p.pista || '';
  }
}

function claveGrupo(p: FilaPrueba, agrupacion: Agrupacion): { clave: string; titulo: string } {
  switch (agrupacion) {
    case 'concurso': return { clave: p.concurso_id, titulo: p.concurso_nombre };
    case 'fecha': return { clave: p.fecha, titulo: formatearFecha(p.fecha) };
    case 'reprise': return { clave: textoReprise(p) || '—', titulo: textoReprise(p) || 'Sin reprise' };
    case 'pista': return { clave: p.pista || '—', titulo: p.pista || 'Sin pista' };
    default: return { clave: '', titulo: '' };
  }
}

const comparar = (a: string, b: string) => a.localeCompare(b, 'es', { numeric: true, sensitivity: 'base' });

export function TablaPruebas(props: Props) {
  const { modo, pruebas } = props;
  const esAdmin = props.modo === 'admin';

  const [busqueda, setBusqueda] = useState('');
  const [filtroConcurso, setFiltroConcurso] = useState('');
  const [filtroReprise, setFiltroReprise] = useState('');
  const [desde, setDesde] = useState('');
  const [hasta, setHasta] = useState('');
  const [orden, setOrden] = useState<{ campo: CampoOrden; direccion: 'asc' | 'desc' }>({ campo: 'fecha', direccion: 'asc' });
  const [agrupacion, setAgrupacion] = useState<Agrupacion>('ninguna');
  const [seleccion, setSeleccion] = useState<Set<string>>(new Set());
  const [filaJuezAbierta, setFilaJuezAbierta] = useState<string | null>(null);
  const [masivo, setMasivo] = useState({ pista: '', juezId: '', letra: LETRAS_JUEZ[0] });
  const [nuevoJuez, setNuevoJuez] = useState({ juezId: '', letra: LETRAS_JUEZ[0] });
  const [ocupado, setOcupado] = useState(false);
  const [aviso, setAviso] = useState<{ tipo: 'ok' | 'error'; texto: string } | null>(null);

  const concursos = useMemo(
    () => Array.from(new Map(pruebas.map((p) => [p.concurso_id, p.concurso_nombre])).entries()).sort((a, b) => comparar(a[1], b[1])),
    [pruebas]
  );
  const reprises = useMemo(
    () => Array.from(new Set(pruebas.map(textoReprise).filter(Boolean))).sort(comparar),
    [pruebas]
  );

  const visibles = useMemo(() => {
    const termino = normalizar(busqueda.trim());
    return pruebas
      .filter((p) =>
        (!termino || [p.concurso_nombre, p.nombre, p.reprise_nombre, p.reprise_codigo, p.pista, p.categoria]
          .some((v) => normalizar(v).includes(termino))) &&
        (!filtroConcurso || p.concurso_id === filtroConcurso) &&
        (!filtroReprise || textoReprise(p) === filtroReprise) &&
        (!desde || p.fecha >= desde) &&
        (!hasta || p.fecha <= hasta)
      )
      .sort((a, b) => {
        const c = comparar(valorOrden(a, orden.campo), valorOrden(b, orden.campo)) ||
          comparar(valorOrden(a, 'fecha'), valorOrden(b, 'fecha'));
        return orden.direccion === 'asc' ? c : -c;
      });
  }, [pruebas, busqueda, filtroConcurso, filtroReprise, desde, hasta, orden]);

  const grupos = useMemo(() => {
    if (agrupacion === 'ninguna') return [{ clave: '', titulo: '', filas: visibles }];
    const mapa = new Map<string, { clave: string; titulo: string; filas: FilaPrueba[] }>();
    for (const p of visibles) {
      const { clave, titulo } = claveGrupo(p, agrupacion);
      if (!mapa.has(clave)) mapa.set(clave, { clave, titulo, filas: [] });
      mapa.get(clave)!.filas.push(p);
    }
    const lista = Array.from(mapa.values());
    // Por fecha se ordenan los grupos cronológicamente; el resto alfabéticamente.
    return lista.sort((a, b) => (agrupacion === 'fecha' ? comparar(a.clave, b.clave) : comparar(a.titulo, b.titulo)));
  }, [visibles, agrupacion]);

  const hayFiltros = Boolean(busqueda || filtroConcurso || filtroReprise || desde || hasta);
  const seleccionVisible = visibles.filter((p) => seleccion.has(p.id)).map((p) => p.id);
  const todasMarcadas = visibles.length > 0 && seleccionVisible.length === visibles.length;

  const cambiarOrden = (campo: CampoOrden) =>
    setOrden((o) => ({ campo, direccion: o.campo === campo && o.direccion === 'asc' ? 'desc' : 'asc' }));

  const alternar = (id: string) =>
    setSeleccion((s) => {
      const n = new Set(s);
      if (n.has(id)) n.delete(id); else n.add(id);
      return n;
    });

  const ejecutar = async (accion: () => Promise<void>, ok: string) => {
    setOcupado(true);
    setAviso(null);
    try {
      await accion();
      setAviso({ tipo: 'ok', texto: ok });
    } catch (err) {
      setAviso({ tipo: 'error', texto: err instanceof Error ? err.message : 'No se pudo guardar' });
    } finally {
      setOcupado(false);
    }
  };

  const cabecera = (campo: CampoOrden, titulo: string, className = '') => (
    <th aria-sort={orden.campo === campo ? (orden.direccion === 'asc' ? 'ascending' : 'descending') : 'none'} className={`whitespace-nowrap px-3 py-2 ${className}`}>
      <button type="button" onClick={() => cambiarOrden(campo)} className="inline-flex items-center gap-1.5">
        {titulo}
        {orden.campo === campo
          ? orden.direccion === 'asc' ? <ArrowUp className="size-3.5" aria-hidden="true" /> : <ArrowDown className="size-3.5" aria-hidden="true" />
          : <ArrowDownUp className="size-3.5 opacity-50" aria-hidden="true" />}
      </button>
    </th>
  );

  // Admin: selección + 9 columnas; juez: 9 columnas + "Puntuadas".
  const columnas = 10;

  return (
    <div className="space-y-4">
      {/* BUSCADOR Y FILTROS */}
      <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-6">
        <div className="lg:col-span-2">
          <label htmlFor="pruebas-busqueda" className="mb-1 block text-xs font-bold">Buscar</label>
          <input
            id="pruebas-busqueda"
            type="search"
            value={busqueda}
            onChange={(e) => setBusqueda(e.target.value)}
            placeholder="Concurso, prueba, reprise, pista…"
            className="input w-full"
          />
        </div>
        <div>
          <label htmlFor="pruebas-concurso" className="mb-1 block text-xs font-bold">Concurso</label>
          <select id="pruebas-concurso" value={filtroConcurso} onChange={(e) => setFiltroConcurso(e.target.value)} className="input w-full">
            <option value="">Todos</option>
            {concursos.map(([id, nombre]) => <option key={id} value={id}>{nombre}</option>)}
          </select>
        </div>
        <div>
          <label htmlFor="pruebas-reprise" className="mb-1 block text-xs font-bold">Reprise</label>
          <select id="pruebas-reprise" value={filtroReprise} onChange={(e) => setFiltroReprise(e.target.value)} className="input w-full">
            <option value="">Todas</option>
            {reprises.map((r) => <option key={r} value={r}>{r}</option>)}
          </select>
        </div>
        <div>
          <label htmlFor="pruebas-desde" className="mb-1 block text-xs font-bold">Desde</label>
          <input id="pruebas-desde" type="date" value={desde} onChange={(e) => setDesde(e.target.value)} className="input w-full" />
        </div>
        <div>
          <label htmlFor="pruebas-hasta" className="mb-1 block text-xs font-bold">Hasta</label>
          <input id="pruebas-hasta" type="date" value={hasta} min={desde || undefined} onChange={(e) => setHasta(e.target.value)} className="input w-full" />
        </div>
      </div>

      <div className="flex flex-wrap items-end justify-between gap-3">
        <div className="flex flex-wrap items-end gap-3">
          <div>
            <label htmlFor="pruebas-agrupar" className="mb-1 block text-xs font-bold">Agrupar por</label>
            <select id="pruebas-agrupar" value={agrupacion} onChange={(e) => setAgrupacion(e.target.value as Agrupacion)} className="input">
              <option value="ninguna">Sin agrupar</option>
              <option value="concurso">Concurso</option>
              <option value="fecha">Fecha</option>
              <option value="reprise">Reprise</option>
              <option value="pista">Pista</option>
            </select>
          </div>
          {hayFiltros && (
            <button
              type="button"
              className="btn btn-outline text-sm"
              onClick={() => { setBusqueda(''); setFiltroConcurso(''); setFiltroReprise(''); setDesde(''); setHasta(''); }}
            >
              Limpiar filtros
            </button>
          )}
        </div>
        <p className="text-sm text-gray-600">{visibles.length} de {pruebas.length} pruebas</p>
      </div>

      {/* ACCIONES SOBRE VARIAS PRUEBAS (ADMIN) */}
      {props.modo === 'admin' && seleccionVisible.length > 0 && (
        <div className="flex flex-wrap items-end gap-3 rounded border border-[#b88746]/40 bg-[#b88746]/10 p-3">
          <p className="w-full text-sm font-semibold">{seleccionVisible.length} pruebas marcadas: puedes ponerles la misma pista o el mismo juez a la vez</p>
          <form
            className="flex items-end gap-2"
            onSubmit={(e) => {
              e.preventDefault();
              ejecutar(() => props.onCambiarPista(seleccionVisible, masivo.pista.trim()), `Pista asignada a ${seleccionVisible.length} pruebas`);
            }}
          >
            <div>
              <label htmlFor="masivo-pista" className="mb-1 block text-xs font-bold">Pista</label>
              <input id="masivo-pista" type="text" value={masivo.pista} onChange={(e) => setMasivo({ ...masivo, pista: e.target.value })} placeholder="Ej. Pista A" className="input w-36" />
            </div>
            <button type="submit" disabled={ocupado} className="btn btn-primary text-sm">Poner esta pista a las marcadas</button>
          </form>
          <form
            className="flex flex-wrap items-end gap-2"
            onSubmit={(e) => {
              e.preventDefault();
              if (!masivo.juezId) return;
              ejecutar(() => props.onAsignarJuez(seleccionVisible, masivo.juezId, masivo.letra), `Juez asignado a ${seleccionVisible.length} pruebas`);
            }}
          >
            <div>
              <label htmlFor="masivo-juez" className="mb-1 block text-xs font-bold">Juez</label>
              <select id="masivo-juez" value={masivo.juezId} onChange={(e) => setMasivo({ ...masivo, juezId: e.target.value })} className="input min-w-44" required>
                <option value="">-- Elegir juez --</option>
                {props.juecesDisponibles.map((j) => <option key={j.id} value={j.id}>{j.nombre}</option>)}
              </select>
            </div>
            <div>
              <label htmlFor="masivo-letra" className="mb-1 block text-xs font-bold">Letra</label>
              <select id="masivo-letra" value={masivo.letra} onChange={(e) => setMasivo({ ...masivo, letra: e.target.value })} className="input">
                {LETRAS_JUEZ.map((l) => <option key={l} value={l}>{l}</option>)}
              </select>
            </div>
            <button type="submit" disabled={ocupado || !masivo.juezId} className="btn btn-primary text-sm">Añadir este juez a las marcadas</button>
          </form>
          <button type="button" className="btn btn-outline text-sm" onClick={() => setSeleccion(new Set())}>Desmarcar todas</button>
        </div>
      )}

      {aviso && (
        <p role={aviso.tipo === 'error' ? 'alert' : 'status'} className={`rounded p-3 text-sm ${aviso.tipo === 'error' ? 'border border-red-200 bg-red-50 text-red-700' : 'border border-green-200 bg-green-50 text-green-800'}`}>
          {aviso.texto}
        </p>
      )}

      {/* TABLA */}
      {visibles.length === 0 ? (
        <p className="rounded border border-[#e4dfd4] bg-white p-6 text-center text-gray-600">
          {pruebas.length === 0 ? 'No hay pruebas todavía.' : 'Ninguna prueba coincide con la búsqueda.'}
        </p>
      ) : (
        <div className="overflow-x-auto rounded border border-[#e4dfd4] bg-white">
          <table className="min-w-full text-left text-sm">
            <thead className="bg-[#f4f0e6] text-xs uppercase text-[#466257]">
              <tr>
                {esAdmin && (
                  <th className="px-3 py-2">
                    <input
                      type="checkbox"
                      aria-label="Marcar todas las pruebas de la lista"
                      title="Marcar todas las pruebas de la lista"
                      checked={todasMarcadas}
                      onChange={() => setSeleccion(todasMarcadas ? new Set() : new Set(visibles.map((p) => p.id)))}
                    />
                  </th>
                )}
                {cabecera('fecha', 'Fecha')}
                <th className="px-3 py-2">Hora</th>
                {cabecera('concurso', 'Concurso')}
                {cabecera('nombre', 'Prueba')}
                {cabecera('reprise', 'Reprise')}
                {cabecera('pista', 'Pista')}
                {esAdmin ? <th className="px-3 py-2">Jueces</th> : <th className="px-3 py-2">Letra</th>}
                <th className="px-3 py-2 text-center">Binomios</th>
                {!esAdmin && <th className="px-3 py-2 text-center">Puntuadas</th>}
                <th className="px-3 py-2" />
              </tr>
            </thead>
            <tbody>
              {grupos.map((grupo) => (
                <Fragment key={grupo.clave || 'todas'}>
                  {agrupacion !== 'ninguna' && (
                    <tr className="border-t border-[#e4dfd4] bg-[#173b2f]/5">
                      <th colSpan={columnas} scope="colgroup" className="px-3 py-2 text-left font-semibold text-[#173b2f]">
                        {grupo.titulo} <span className="font-normal text-gray-500">· {grupo.filas.length} pruebas</span>
                      </th>
                    </tr>
                  )}
                  {grupo.filas.map((p) => (
                    <Fragment key={p.id}>
                      <tr className="border-t border-[#eee9df] align-top even:bg-[#fffdfa]">
                        {esAdmin && (
                          <td className="px-3 py-2">
                            <input type="checkbox" aria-label={`Seleccionar ${p.nombre}`} checked={seleccion.has(p.id)} onChange={() => alternar(p.id)} />
                          </td>
                        )}
                        <td className="whitespace-nowrap px-3 py-2">{formatearFecha(p.fecha)}</td>
                        <td className="whitespace-nowrap px-3 py-2">{p.hora_inicio?.substring(0, 5) || '—'}</td>
                        <td className="min-w-40 px-3 py-2">{p.concurso_nombre}</td>
                        <td className="min-w-40 px-3 py-2 font-medium text-[#173b2f]">
                          {p.nombre}
                          {p.categoria && <span className="block text-xs font-normal text-gray-500">{p.categoria}</span>}
                        </td>
                        <td className="min-w-40 px-3 py-2">
                          {p.reprise_nombre || '—'}
                          {p.reprise_codigo && <span className="block font-mono text-xs text-gray-400">{p.reprise_codigo}</span>}
                        </td>
                        <td className="px-3 py-2">
                          {props.modo === 'admin' ? (
                            <input
                              key={`${p.id}-${p.pista || ''}`}
                              type="text"
                              aria-label={`Pista de ${p.nombre}`}
                              defaultValue={p.pista || ''}
                              placeholder="Escribe la pista"
                              disabled={ocupado}
                              className="input w-28 text-sm"
                              onKeyDown={(e) => { if (e.key === 'Enter') (e.target as HTMLInputElement).blur(); }}
                              onBlur={(e) => {
                                const valor = e.target.value.trim();
                                if (valor !== (p.pista || '')) ejecutar(() => props.onCambiarPista([p.id], valor), 'Pista guardada');
                              }}
                            />
                          ) : (p.pista || '—')}
                        </td>
                        <td className="px-3 py-2">
                          {props.modo === 'admin' ? (
                            <div className="flex min-w-44 flex-wrap items-center gap-1.5">
                              {[...p.jueces].sort((a, b) => comparar(a.letra, b.letra)).map((j) => (
                                <span key={j.id} className="inline-flex items-center gap-1 rounded bg-amber-100 px-2 py-0.5 text-xs text-amber-900">
                                  <strong>{j.letra}</strong> {j.nombre}
                                  <button
                                    type="button"
                                    aria-label={`Quitar a ${j.nombre} de ${p.nombre}`}
                                    disabled={ocupado}
                                    onClick={() => ejecutar(() => props.onQuitarJuez(j.id), 'Juez quitado')}
                                    title="Quitar este juez de la prueba"
                                    className="rounded hover:bg-amber-200"
                                  >
                                    <X className="size-3" aria-hidden="true" />
                                  </button>
                                </span>
                              ))}
                              <button
                                type="button"
                                aria-expanded={filaJuezAbierta === p.id}
                                onClick={() => {
                                  setFilaJuezAbierta(filaJuezAbierta === p.id ? null : p.id);
                                  const libre = LETRAS_JUEZ.find((l) => !p.jueces.some((j) => j.letra === l)) || LETRAS_JUEZ[0];
                                  setNuevoJuez({ juezId: '', letra: libre });
                                }}
                                className="inline-flex items-center gap-0.5 rounded border border-dashed border-gray-400 px-1.5 py-0.5 text-xs text-gray-600 hover:bg-gray-100"
                              >
                                <Plus className="size-3" aria-hidden="true" /> Añadir juez
                              </button>
                            </div>
                          ) : (
                            <span className="rounded bg-amber-100 px-2 py-0.5 text-sm font-bold text-amber-800">{p.letra_juez}</span>
                          )}
                        </td>
                        <td className="px-3 py-2 text-center">{p.num_binomios}</td>
                        {!esAdmin && <td className="px-3 py-2 text-center">{p.num_puntuaciones ?? 0} / {p.num_binomios}</td>}
                        <td className="whitespace-nowrap px-3 py-2 text-right">
                          {modo === 'admin' ? (
                            <>
                              <Link href={`/admin/concursos/${p.concurso_id}/pruebas/${p.id}`} className="btn btn-outline text-sm" title="Ver y cambiar los jueces y los binomios (jinete y caballo) de esta prueba">Abrir prueba</Link>
                              <Link href={`/juez/prueba/${p.id}`} className="btn btn-primary ml-2 text-sm" title="Poner notas en esta prueba eligiendo con qué juez">Puntuar</Link>
                            </>
                          ) : (
                            <Link href={`/juez/prueba/${p.id}`} className="btn btn-primary text-sm" title="Ver los binomios de esta prueba y poner las notas">Puntuar</Link>
                          )}
                        </td>
                      </tr>
                      {props.modo === 'admin' && filaJuezAbierta === p.id && (
                        <tr className="bg-blue-50/60">
                          <td colSpan={columnas} className="px-3 py-2">
                            <form
                              className="flex flex-wrap items-end gap-2"
                              onSubmit={(e) => {
                                e.preventDefault();
                                if (!nuevoJuez.juezId) return;
                                ejecutar(async () => {
                                  await props.onAsignarJuez([p.id], nuevoJuez.juezId, nuevoJuez.letra);
                                  setFilaJuezAbierta(null);
                                }, 'Juez asignado');
                              }}
                            >
                              <span className="self-center text-sm font-semibold">Añadir juez a «{p.nombre}»</span>
                              <select aria-label="Juez" value={nuevoJuez.juezId} onChange={(e) => setNuevoJuez({ ...nuevoJuez, juezId: e.target.value })} className="input min-w-44 text-sm" required>
                                <option value="">-- Elegir juez --</option>
                                {props.juecesDisponibles
                                  .filter((j) => !p.jueces.some((a) => a.juez_id === j.id))
                                  .map((j) => <option key={j.id} value={j.id}>{j.nombre}</option>)}
                              </select>
                              <select aria-label="Letra" value={nuevoJuez.letra} onChange={(e) => setNuevoJuez({ ...nuevoJuez, letra: e.target.value })} className="input text-sm">
                                {LETRAS_JUEZ.map((l) => (
                                  <option key={l} value={l} disabled={p.jueces.some((j) => j.letra === l)}>{l}</option>
                                ))}
                              </select>
                              <button type="submit" disabled={ocupado || !nuevoJuez.juezId} className="btn btn-primary text-sm">Guardar juez</button>
                              <button type="button" onClick={() => setFilaJuezAbierta(null)} className="btn btn-outline text-sm">Cancelar</button>
                            </form>
                          </td>
                        </tr>
                      )}
                    </Fragment>
                  ))}
                </Fragment>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
