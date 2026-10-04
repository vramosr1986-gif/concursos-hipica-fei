'use client';

import { FormEvent, useCallback, useEffect, useState } from 'react';
import Link from 'next/link';
import { ArrowDown, ArrowDownUp, ArrowUp } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import { compararRfhe } from '@/lib/orden-reprises';
import { formatearFecha } from '@/lib/fechas';
import { categoriaDeReprise } from '@/lib/rfhe-pruebas';

type Prueba = {
  id: string;
  nombre: string;
  fecha: string;
  hora_inicio: string | null;
  pista: string | null;
  orden: number | null;
  reprise_nombre: string | null;
  num_jueces: number;
  num_binomios: number;
};

type Reprise = { id: string; codigo: string; nombre: string; categoria: string | null };
type CategoriaEdad = { id: string; codigo: string; nombre: string };

interface Props {
  concursoId: string;
  esRfhe: boolean;
  fechaInicio: string;
  fechaFin: string;
}

const DIAS = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
const diaSemana = (iso: string) => {
  const [a, m, d] = iso.split('-').map(Number);
  return DIAS[new Date(Date.UTC(a, m - 1, d)).getUTCDay()];
};

/**
 * Pruebas del concurso. En los de la RFHE llegan ya con día y reprise: solo
 * hay que poner hora y pista. También se pueden añadir a mano (como extra).
 */
export function PruebasSection({ concursoId, esRfhe, fechaInicio, fechaFin }: Props) {
  const [pruebas, setPruebas] = useState<Prueba[]>([]);
  const [reprises, setReprises] = useState<Reprise[]>([]);
  const [categorias, setCategorias] = useState<CategoriaEdad[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [aviso, setAviso] = useState('');
  const [guardando, setGuardando] = useState(false);
  const [nueva, setNueva] = useState({ reprise_id: '', nombre: '', fecha: fechaInicio, hora: '09:00', pista: '' });
  const [marcadas, setMarcadas] = useState<Set<string>>(new Set());
  const [pistaMasiva, setPistaMasiva] = useState('');
  const [busqueda, setBusqueda] = useState('');
  const [filtroDia, setFiltroDia] = useState('');
  const [filtroPista, setFiltroPista] = useState('');
  const [orden, setOrden] = useState<{ campo: 'dia' | 'prueba' | 'hora' | 'pista'; direccion: 'asc' | 'desc' }>({ campo: 'dia', direccion: 'asc' });

  const cargarPruebas = useCallback(async () => {
    setError('');
    const { data, error: dbError } = await supabase
      .from('pruebas')
      .select('id, nombre, fecha, hora_inicio, pista, orden, reprise:reprise_id(nombre), prueba_jueces(count), participaciones(count)')
      .eq('concurso_id', concursoId)
      .order('fecha', { ascending: true })
      .order('hora_inicio', { ascending: true })
      .order('orden', { ascending: true });
    if (dbError) {
      setError(dbError.message);
    } else {
      setPruebas((data || []).map((p: any) => ({
        id: p.id,
        nombre: p.nombre,
        fecha: p.fecha,
        hora_inicio: p.hora_inicio,
        pista: p.pista,
        orden: p.orden,
        reprise_nombre: p.reprise?.nombre || null,
        num_jueces: p.prueba_jueces?.[0]?.count ?? 0,
        num_binomios: p.participaciones?.[0]?.count ?? 0,
      })));
    }
    setLoading(false);
  }, [concursoId]);

  useEffect(() => {
    cargarPruebas();
    Promise.all([
      supabase.from('reprises').select('id, codigo, nombre, categoria'),
      supabase.from('categorias_edad').select('id, codigo, nombre'),
    ]).then(([repRes, catRes]) => {
      setReprises(((repRes.data || []) as Reprise[]).sort(compararRfhe));
      setCategorias(catRes.data || []);
    });
  }, [cargarPruebas]);

  const guardarCampo = async (prueba: Prueba, campo: 'hora_inicio' | 'pista', valor: string) => {
    let nuevoValor: string | null;
    if (campo === 'hora_inicio') {
      if (!valor || valor === prueba.hora_inicio?.slice(0, 5)) return; // la hora es obligatoria
      nuevoValor = `${valor.slice(0, 5)}:00`;
    } else {
      nuevoValor = valor.trim() || null;
      if (nuevoValor === (prueba.pista || null)) return;
    }
    setError('');
    setAviso('');
    const { error: dbError } = await supabase.from('pruebas').update({ [campo]: nuevoValor }).eq('id', prueba.id);
    if (dbError) {
      setError(`No se pudo guardar: ${dbError.message}`);
      return;
    }
    setPruebas((ps) => ps.map((p) => (p.id === prueba.id ? { ...p, [campo]: nuevoValor } : p)));
    setAviso(campo === 'hora_inicio' ? `Hora de «${prueba.nombre}» guardada` : `Pista de «${prueba.nombre}» guardada`);
  };

  const alternar = (id: string) => setMarcadas((m) => {
    const n = new Set(m);
    if (n.has(id)) n.delete(id); else n.add(id);
    return n;
  });

  const ponerPistaMarcadas = async (e: FormEvent) => {
    e.preventDefault();
    const ids = Array.from(marcadas);
    if (ids.length === 0) return;
    setError('');
    setAviso('');
    const pista = pistaMasiva.trim() || null;
    const { error: dbError } = await supabase.from('pruebas').update({ pista }).in('id', ids);
    if (dbError) {
      setError(`No se pudo guardar la pista: ${dbError.message}`);
      return;
    }
    setPruebas((ps) => ps.map((p) => (marcadas.has(p.id) ? { ...p, pista } : p)));
    setAviso(`Pista «${pista || 'sin pista'}» puesta en ${ids.length} pruebas`);
    setMarcadas(new Set());
  };

  const dias = Array.from(new Set(pruebas.map((p) => p.fecha))).sort();
  const pistas = Array.from(new Set(pruebas.map((p) => p.pista).filter(Boolean))).sort() as string[];

  const normalizar = (t: string | null | undefined) => (t || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase();
  const comparar = (a: string, b: string) => a.localeCompare(b, 'es', { numeric: true, sensitivity: 'base' });
  const valor = (p: Prueba, campo: typeof orden.campo) =>
    campo === 'dia' ? `${p.fecha} ${p.hora_inicio || ''} ${String(p.orden ?? 0).padStart(4, '0')}`
      : campo === 'hora' ? `${p.hora_inicio || ''} ${p.fecha}`
        : campo === 'pista' ? p.pista || '\uffff'
          : p.nombre;
  const termino = normalizar(busqueda.trim());
  const visibles = pruebas
    .filter((p) =>
      (!termino || [p.nombre, p.reprise_nombre, p.pista].some((v) => normalizar(v).includes(termino))) &&
      (!filtroDia || p.fecha === filtroDia) &&
      (!filtroPista || (filtroPista === '__sin' ? !p.pista : p.pista === filtroPista)))
    .sort((a, b) => {
      const c = comparar(valor(a, orden.campo), valor(b, orden.campo)) || comparar(valor(a, 'dia'), valor(b, 'dia'));
      return orden.direccion === 'asc' ? c : -c;
    });
  const hayFiltros = Boolean(busqueda || filtroDia || filtroPista);

  const cabecera = (campo: typeof orden.campo, titulo: string) => (
    <th className="px-3 py-2" aria-sort={orden.campo === campo ? (orden.direccion === 'asc' ? 'ascending' : 'descending') : 'none'}>
      <button
        type="button"
        onClick={() => setOrden((o) => ({ campo, direccion: o.campo === campo && o.direccion === 'asc' ? 'desc' : 'asc' }))}
        className="inline-flex items-center gap-1 uppercase"
        title={`Ordenar por ${titulo.toLowerCase()}`}
      >
        {titulo}
        {orden.campo === campo
          ? orden.direccion === 'asc' ? <ArrowUp className="size-3.5" aria-hidden="true" /> : <ArrowDown className="size-3.5" aria-hidden="true" />
          : <ArrowDownUp className="size-3.5 opacity-50" aria-hidden="true" />}
      </button>
    </th>
  );

  const anadirPrueba = async (e: FormEvent) => {
    e.preventDefault();
    setError('');
    setAviso('');
    const reprise = reprises.find((r) => r.id === nueva.reprise_id);
    if (!reprise) { setError('Elige la reprise'); return; }
    if (nueva.fecha < fechaInicio || nueva.fecha > fechaFin) {
      setError(`El día debe estar entre ${formatearFecha(fechaInicio)} y ${formatearFecha(fechaFin)}`);
      return;
    }
    setGuardando(true);
    const categoria = categoriaDeReprise(reprise, categorias);
    const { error: dbError } = await supabase.from('pruebas').insert({
      concurso_id: concursoId,
      reprise_id: reprise.id,
      nombre: nueva.nombre.trim() || reprise.nombre,
      categoria: categoria?.nombre || null,
      categoria_edad_id: categoria?.id || null,
      es_caballos_jovenes: /CJ[4-8]/.test(reprise.codigo),
      fecha: nueva.fecha,
      hora_inicio: `${nueva.hora || '09:00'}:00`,
      pista: nueva.pista.trim() || null,
      orden: Math.max(0, ...pruebas.map((p) => p.orden || 0)) + 1,
      estado: 'programada',
    });
    setGuardando(false);
    if (dbError) {
      setError(dbError.message);
      return;
    }
    setNueva({ ...nueva, reprise_id: '', nombre: '' });
    setAviso('Prueba añadida');
    cargarPruebas();
  };

  const borrarPrueba = async (prueba: Prueba) => {
    if (!confirm(`¿Borrar la prueba «${prueba.nombre}»? Se quitan también sus jueces y binomios.`)) return;
    const { error: dbError } = await supabase.from('pruebas').delete().eq('id', prueba.id);
    if (dbError) {
      setError(dbError.message);
      return;
    }
    setPruebas((ps) => ps.filter((p) => p.id !== prueba.id));
  };

  const formulario = (
    <form onSubmit={anadirPrueba} className="grid gap-3 sm:grid-cols-2 lg:grid-cols-6">
      <div className="lg:col-span-2">
        <label htmlFor="nueva-reprise" className="mb-1 block text-xs font-bold">Reprise *</label>
        <select
          id="nueva-reprise"
          required
          value={nueva.reprise_id}
          onChange={(e) => setNueva({ ...nueva, reprise_id: e.target.value })}
          className="input w-full"
        >
          <option value="">-- Elegir reprise --</option>
          {reprises.map((r) => <option key={r.id} value={r.id}>{r.nombre}</option>)}
        </select>
      </div>
      <div className="lg:col-span-2">
        <label htmlFor="nueva-nombre" className="mb-1 block text-xs font-bold">Nombre (solo si es distinto de la reprise)</label>
        <input id="nueva-nombre" type="text" value={nueva.nombre} onChange={(e) => setNueva({ ...nueva, nombre: e.target.value })} className="input w-full" />
      </div>
      <div>
        <label htmlFor="nueva-fecha" className="mb-1 block text-xs font-bold">Día *</label>
        <input id="nueva-fecha" type="date" required min={fechaInicio} max={fechaFin} value={nueva.fecha} onChange={(e) => setNueva({ ...nueva, fecha: e.target.value })} className="input w-full" />
      </div>
      <div>
        <label htmlFor="nueva-hora" className="mb-1 block text-xs font-bold">Hora</label>
        <input id="nueva-hora" type="time" value={nueva.hora} onChange={(e) => setNueva({ ...nueva, hora: e.target.value })} className="input w-full" />
      </div>
      <div className="lg:col-span-2">
        <label htmlFor="nueva-pista" className="mb-1 block text-xs font-bold">Pista</label>
        <input id="nueva-pista" type="text" placeholder="Ej. Pista A" value={nueva.pista} onChange={(e) => setNueva({ ...nueva, pista: e.target.value })} className="input w-full" />
      </div>
      <div className="flex items-end lg:col-span-4">
        <button type="submit" disabled={guardando} className="btn btn-primary">
          {guardando ? 'Guardando…' : 'Añadir prueba'}
        </button>
      </div>
    </form>
  );

  return (
    <div className="card p-6 max-w-6xl mb-8">
      <h2 className="text-xl font-bold">Pruebas del concurso</h2>
      <p className="mt-1 text-sm text-gray-600">
        {esRfhe
          ? 'Las pruebas vienen de la RFHE con su día y su reprise, y cada binomio ya está en las pruebas de las reprises en las que se inscribió. Solo tienes que poner la hora y la pista: escríbelas en la tabla y se guardan solas.'
          : 'Añade las pruebas abajo. La hora y la pista se pueden cambiar en la tabla y se guardan solas.'}
      </p>

      {error && <p role="alert" className="mt-3 rounded border border-red-200 bg-red-50 p-3 text-sm text-red-700">{error}</p>}
      {aviso && !error && <p role="status" className="mt-3 text-sm text-green-700">{aviso}</p>}

      {loading ? (
        <p className="py-4 text-center text-gray-600">Cargando pruebas…</p>
      ) : pruebas.length === 0 ? (
        <p className="mt-4 text-gray-600">Todavía no hay pruebas.</p>
      ) : (
        <>
        <div className="mt-4 flex flex-wrap items-end gap-3">
          <div className="min-w-48 flex-1">
            <label htmlFor="pruebas-concurso-busqueda" className="mb-1 block text-xs font-bold">Buscar</label>
            <input id="pruebas-concurso-busqueda" type="search" value={busqueda} onChange={(e) => setBusqueda(e.target.value)} placeholder="Prueba, reprise o pista…" className="input w-full" />
          </div>
          <div>
            <label htmlFor="pruebas-concurso-dia" className="mb-1 block text-xs font-bold">Día</label>
            <select id="pruebas-concurso-dia" value={filtroDia} onChange={(e) => setFiltroDia(e.target.value)} className="input">
              <option value="">Todos</option>
              {dias.map((d) => <option key={d} value={d}>{diaSemana(d)} {formatearFecha(d)}</option>)}
            </select>
          </div>
          <div>
            <label htmlFor="pruebas-concurso-pista" className="mb-1 block text-xs font-bold">Pista</label>
            <select id="pruebas-concurso-pista" value={filtroPista} onChange={(e) => setFiltroPista(e.target.value)} className="input">
              <option value="">Todas</option>
              {pistas.map((p) => <option key={p} value={p}>{p}</option>)}
              <option value="__sin">Sin pista</option>
            </select>
          </div>
          {hayFiltros && (
            <button type="button" onClick={() => { setBusqueda(''); setFiltroDia(''); setFiltroPista(''); }} className="btn btn-outline btn-sm">Limpiar filtros</button>
          )}
          <p className="ml-auto pb-2 text-sm text-gray-600">{visibles.length} de {pruebas.length} pruebas</p>
        </div>
        <div className="mt-3 flex flex-wrap items-end gap-3 rounded border border-[#e4dfd4] bg-[#f8f7f3] p-3">
          <div className="flex flex-wrap items-center gap-2 text-sm">
            <span className="font-semibold">Marcar:</span>
            <button type="button" onClick={() => setMarcadas(new Set(visibles.map((p) => p.id)))} className="btn btn-outline btn-sm">{hayFiltros ? 'Las que se ven' : 'Todas'}</button>
            {dias.length > 1 && dias.map((d) => (
              <button
                key={d}
                type="button"
                onClick={() => setMarcadas(new Set(pruebas.filter((p) => p.fecha === d).map((p) => p.id)))}
                className="btn btn-outline btn-sm"
              >
                Las del {diaSemana(d).toLowerCase()}
              </button>
            ))}
            {marcadas.size > 0 && <button type="button" onClick={() => setMarcadas(new Set())} className="btn btn-outline btn-sm">Ninguna</button>}
          </div>
          <form onSubmit={ponerPistaMarcadas} className="ml-auto flex flex-wrap items-end gap-2">
            <div>
              <label htmlFor="pista-masiva" className="mb-1 block text-xs font-bold">Pista para las {marcadas.size} marcadas</label>
              <input id="pista-masiva" type="text" value={pistaMasiva} onChange={(e) => setPistaMasiva(e.target.value)} placeholder="Ej. Pista A" className="input w-36" />
            </div>
            <button type="submit" disabled={marcadas.size === 0} className="btn btn-primary text-sm">Poner esta pista a las marcadas</button>
          </form>
        </div>
        <div className="mt-3 overflow-x-auto rounded border border-[#e4dfd4]">
          <table className="min-w-full text-left text-sm">
            <thead className="bg-[#f4f0e6] text-xs uppercase text-[#466257]">
              <tr>
                <th className="px-3 py-2"><span className="sr-only">Marcar</span></th>
                {cabecera('dia', 'Día')}
                {cabecera('prueba', 'Prueba')}
                {cabecera('hora', 'Hora')}
                {cabecera('pista', 'Pista')}
                <th className="px-3 py-2 text-center">Jueces</th>
                <th className="px-3 py-2 text-center">Binomios</th>
                <th className="px-3 py-2" />
              </tr>
            </thead>
            <tbody>
              {visibles.length === 0 && (
                <tr><td colSpan={8} className="px-3 py-6 text-center text-gray-600">Ninguna prueba coincide con los filtros.</td></tr>
              )}
              {visibles.map((p) => (
                <tr key={p.id} className="border-t border-[#eee9df] align-middle even:bg-[#fffdfa]">
                  <td className="px-3 py-2">
                    <input type="checkbox" aria-label={`Marcar ${p.nombre}`} checked={marcadas.has(p.id)} onChange={() => alternar(p.id)} />
                  </td>
                  <td className="whitespace-nowrap px-3 py-2">
                    {diaSemana(p.fecha)}
                    <span className="block text-xs text-gray-500">{formatearFecha(p.fecha)}</span>
                  </td>
                  <td className="min-w-48 px-3 py-2 font-medium text-[#173b2f]">
                    {p.nombre}
                    {p.reprise_nombre && p.reprise_nombre !== p.nombre && (
                      <span className="block text-xs font-normal text-gray-500">Reprise: {p.reprise_nombre}</span>
                    )}
                    {!p.reprise_nombre && <span className="block text-xs font-normal text-amber-700">Sin reprise: ábrela para elegirla</span>}
                  </td>
                  <td className="px-3 py-2">
                    <input
                      key={`${p.id}-h-${p.hora_inicio}`}
                      type="time"
                      aria-label={`Hora de ${p.nombre}`}
                      defaultValue={p.hora_inicio?.slice(0, 5) || ''}
                      onBlur={(e) => guardarCampo(p, 'hora_inicio', e.target.value)}
                      className="input w-28"
                    />
                  </td>
                  <td className="px-3 py-2">
                    <input
                      key={`${p.id}-p-${p.pista}`}
                      type="text"
                      aria-label={`Pista de ${p.nombre}`}
                      defaultValue={p.pista || ''}
                      placeholder="Escribe la pista"
                      onKeyDown={(e) => { if (e.key === 'Enter') (e.target as HTMLInputElement).blur(); }}
                      onBlur={(e) => guardarCampo(p, 'pista', e.target.value)}
                      className="input w-32"
                    />
                  </td>
                  <td className="px-3 py-2 text-center">{p.num_jueces}</td>
                  <td className="px-3 py-2 text-center">{p.num_binomios}</td>
                  <td className="whitespace-nowrap px-3 py-2 text-right">
                    <Link href={`/admin/concursos/${concursoId}/pruebas/${p.id}`} className="btn btn-outline btn-sm" title="Ver y cambiar los jueces y los binomios de esta prueba">
                      Abrir prueba
                    </Link>
                    <Link href={`/juez/prueba/${p.id}`} className="btn btn-primary btn-sm ml-2" title="Poner notas en esta prueba eligiendo con qué juez">
                      Puntuar
                    </Link>
                    <button type="button" onClick={() => borrarPrueba(p)} className="ml-2 text-sm text-danger hover:underline">
                      Borrar
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        </>
      )}

      {esRfhe ? (
        <details className="mt-6 border-t pt-4">
          <summary className="cursor-pointer font-semibold text-[#173b2f]">Añadir a mano una prueba que no viene de la RFHE (extra)</summary>
          <div className="mt-3">{formulario}</div>
        </details>
      ) : (
        <section className="mt-6 border-t pt-4">
          <h3 className="mb-3 font-bold">Añadir prueba</h3>
          {formulario}
        </section>
      )}
    </div>
  );
}
