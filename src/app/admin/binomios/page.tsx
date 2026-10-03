'use client';

import { useEffect, useMemo, useState } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';
import { BanderaFH } from '@/components/BanderaFH';
import { buscarCaballoEnRfhe, buscarJineteEnRfhe } from '@/lib/rfhe-busqueda';

type EstadoValidacion = 'pendiente' | 'valido' | 'no_valido';

type Binomio = {
  id: string;
  nombre_jinete: string;
  nombre_caballo: string;
  ldn_jinete: string | null;
  lac_caballo: string | null;
  fh_jinete: string | null;
  fh_caballo: string | null;
  estado_validacion: EstadoValidacion;
  concursos: { id: string; nombre: string; rfhe: boolean }[];
};

const normalizar = (texto: string | null | undefined) =>
  (texto || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();

const vieneDeRfhe = (b: Binomio) => b.concursos.some((c) => c.rfhe);



export default function JinetesYCaballosPage() {
  const [binomios, setBinomios] = useState<Binomio[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [busqueda, setBusqueda] = useState('');
  const [origen, setOrigen] = useState<'' | 'rfhe' | 'manual'>('');

  useEffect(() => {
    const cargar = async () => {
      setError('');
      const [binomiosRes, inscripcionesRes, concursosRes] = await Promise.all([
        supabase
          .from('binomios')
          .select('id, nombre_jinete, nombre_caballo, ldn_jinete, lac_caballo, fh_jinete, fh_caballo, estado_validacion')
          .order('nombre_jinete'),
        supabase.from('inscripciones').select('binomio_id, concurso_id'),
        supabase.from('concursos').select('id, nombre, rfhe_url'),
      ]);
      if (binomiosRes.error) {
        setError(binomiosRes.error.message);
        setLoading(false);
        return;
      }
      // Si la columna rfhe_url aún no existe, se cargan los concursos sin ella.
      const concursosData = concursosRes.error
        ? (await supabase.from('concursos').select('id, nombre')).data || []
        : concursosRes.data || [];
      const concursos = new Map(concursosData.map((c: { id: string; nombre: string; rfhe_url?: string | null }) => [c.id, { id: c.id, nombre: c.nombre, rfhe: Boolean(c.rfhe_url) }]));
      const porBinomio = new Map<string, Binomio['concursos']>();
      for (const i of inscripcionesRes.data || []) {
        const c = concursos.get(i.concurso_id);
        if (!c) continue;
        porBinomio.set(i.binomio_id, [...(porBinomio.get(i.binomio_id) || []), c]);
      }
      setBinomios((binomiosRes.data || []).map((b) => ({
        ...b,
        estado_validacion: (b.estado_validacion || 'pendiente') as EstadoValidacion,
        concursos: porBinomio.get(b.id) || [],
      })));
      setLoading(false);
    };
    cargar();
  }, []);

  const visibles = useMemo(() => {
    const termino = normalizar(busqueda.trim());
    return binomios.filter((b) =>
      (!termino || normalizar(`${b.nombre_jinete} ${b.nombre_caballo} ${b.ldn_jinete || ''} ${b.lac_caballo || ''}`).includes(termino)) &&
      (!origen || (origen === 'rfhe') === vieneDeRfhe(b))
    );
  }, [binomios, busqueda, origen]);

  const cambiarValidacion = async (b: Binomio, estado: EstadoValidacion) => {
    setError('');
    const { error: dbError } = await supabase.from('binomios').update({ estado_validacion: estado }).eq('id', b.id);
    if (dbError) {
      setError(`No se pudo guardar: ${dbError.message}`);
      return;
    }
    setBinomios((actuales) => actuales.map((x) => (x.id === b.id ? { ...x, estado_validacion: estado } : x)));
  };

  const borrar = async (b: Binomio) => {
    const aviso = b.concursos.length > 0
      ? `\n\nTambién se quitará de ${b.concursos.length === 1 ? 'el concurso' : `los ${b.concursos.length} concursos`} en que está inscrito.`
      : '';
    if (!window.confirm(`¿Borrar a ${b.nombre_jinete} con ${b.nombre_caballo}?${aviso}`)) return;
    const { error: dbError } = await supabase.from('binomios').delete().eq('id', b.id);
    if (dbError) {
      setError(`No se pudo borrar: ${dbError.message}`);
      return;
    }
    setBinomios((actuales) => actuales.filter((x) => x.id !== b.id));
  };

  return (
    <div className="container max-w-7xl py-8">
      <div className="mb-6 flex flex-wrap items-start justify-between gap-4">
        <div className="max-w-2xl">
          <h1 className="text-3xl font-bold">Jinetes y caballos</h1>
          <p className="mt-1 text-gray-600">
            Cada pareja de jinete y caballo (binomio). Los de concursos de la RFHE se dan de alta solos al traer los inscritos;
            aquí se añaden los de concursos manuales y se corrigen los datos.
          </p>
        </div>
        <Link href="/admin/binomios/nuevo" className="btn btn-primary">+ Añadir jinete y caballo</Link>
      </div>

      {error && <p role="alert" className="mb-4 rounded border border-red-200 bg-red-50 p-3 text-sm text-red-700">{error}</p>}

      <div className="mb-4 flex flex-wrap items-end gap-3">
        <div className="min-w-60 flex-1">
          <label htmlFor="binomios-busqueda" className="mb-1 block text-xs font-bold">Buscar</label>
          <input
            id="binomios-busqueda"
            type="search"
            value={busqueda}
            onChange={(e) => setBusqueda(e.target.value)}
            placeholder="Jinete, caballo, LDN o LAC…"
            className="input w-full"
          />
        </div>
        <div>
          <label htmlFor="binomios-origen" className="mb-1 block text-xs font-bold">Origen</label>
          <select id="binomios-origen" value={origen} onChange={(e) => setOrigen(e.target.value as typeof origen)} className="input">
            <option value="">Todos</option>
            <option value="rfhe">De concursos de la RFHE</option>
            <option value="manual">Añadidos a mano</option>
          </select>
        </div>
      </div>

      {loading ? (
        <div className="card p-6 text-center">Cargando…</div>
      ) : (
        <div className="card overflow-hidden">
          <p className="border-b bg-gray-50 p-3 text-sm">{visibles.length} de {binomios.length} binomios</p>
          {visibles.length === 0 ? (
            <p className="p-6 text-center text-gray-600">
              {binomios.length === 0 ? 'Todavía no hay ninguno.' : 'Ninguno coincide con la búsqueda.'}
            </p>
          ) : (
            <div className="overflow-x-auto">
              <table className="min-w-full text-left text-sm">
                <thead className="bg-[#f4f0e6] text-xs uppercase text-[#466257]">
                  <tr>
                    <th className="px-2 py-2">Jinete</th>
                    <th className="px-2 py-2">Caballo</th>
                    <th className="px-2 py-2">Concursos</th>
                    <th className="whitespace-nowrap px-2 py-2">Comprobado</th>
                    <th className="px-3 py-2" />
                  </tr>
                </thead>
                <tbody>
                  {visibles.map((b) => {
                    return (
                      <tr key={b.id} className="border-t border-[#eee9df] align-top even:bg-[#fffdfa]">
                        <td className="px-2 py-2">
                          <span className="inline-flex items-center gap-1.5 font-medium"><BanderaFH codigo={b.fh_jinete} />{b.nombre_jinete}</span>
                          <span className="block text-xs text-gray-500">LDN {b.ldn_jinete || '—'}</span>
                        </td>
                        <td className="px-2 py-2">
                          <span className="inline-flex items-center gap-1.5"><BanderaFH codigo={b.fh_caballo} />{b.nombre_caballo}</span>
                          <span className="block text-xs text-gray-500">LAC {b.lac_caballo || '—'}</span>
                        </td>
                        <td className="px-2 py-2">
                          {b.concursos.length > 0 ? (
                            <ul className="space-y-0.5 text-xs">
                              {b.concursos.map((c) => (
                                <li key={c.id}>
                                  <Link href={`/admin/concursos/${c.id}`} className="text-primary hover:underline">{c.nombre}</Link>
                                </li>
                              ))}
                            </ul>
                          ) : (
                            <span className="whitespace-nowrap text-xs text-gray-500">Ninguno</span>
                          )}
                        </td>
                        <td className="px-2 py-2">
                          {vieneDeRfhe(b) ? (
                            <span className="whitespace-nowrap text-xs text-[#173b2f]">Viene de la RFHE</span>
                          ) : (
                          <select
                            aria-label={`Comprobado en la RFHE: ${b.nombre_jinete} / ${b.nombre_caballo}`}
                            value={b.estado_validacion}
                            onChange={(e) => cambiarValidacion(b, e.target.value as EstadoValidacion)}
                            className="input w-36 text-xs"
                          >
                            <option value="pendiente">Sin comprobar</option>
                            <option value="valido">Sí, es correcto</option>
                            <option value="no_valido">No, hay un error</option>
                          </select>
                          )}
                        </td>
                        <td className="whitespace-nowrap px-2 py-2 text-right">
                          <div className="flex flex-col items-end gap-1">
                            <Link href={`/admin/binomios/${b.id}`} className="btn btn-outline btn-sm whitespace-nowrap">Editar datos</Link>
                            <button type="button" onClick={() => buscarJineteEnRfhe(b.nombre_jinete)} className="whitespace-nowrap text-xs text-primary hover:underline" title="Abre en otra pestaña la búsqueda de este jinete en la RFHE">
                              Buscar jinete en la RFHE
                            </button>
                            <button type="button" onClick={() => buscarCaballoEnRfhe(b.nombre_caballo)} className="whitespace-nowrap text-xs text-primary hover:underline" title="Abre en otra pestaña la búsqueda de este caballo en la RFHE">
                              Buscar caballo en la RFHE
                            </button>
                            <button type="button" onClick={() => borrar(b)} className="whitespace-nowrap text-xs text-danger hover:underline">Borrar</button>
                          </div>
                        </td>
                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
