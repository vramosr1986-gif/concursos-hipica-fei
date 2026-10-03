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
  fecha_nacimiento_jinete: string | null;
  anio_nacimiento_caballo: number | null;
  estado_validacion: EstadoValidacion;
  categoria_principal: string | null;
  concursos: { id: string; nombre: string; rfhe: boolean }[];
};

const NOMBRE_CATEGORIA: Record<string, string> = {
  BENJAMIN: 'Benjamines',
  ALEVIN: 'Alevines',
  INFANTIL: 'Infantiles',
  JUVENIL_0: 'Juveniles 0*',
  JUVENIL: 'Juveniles',
  JUNIOR: 'Juniors',
  JOVEN_JINETE: 'Jóvenes Jinetes',
  ADULTO: 'Adultos',
  VETERANO: 'Veteranos',
  PONI: 'Ponis',
  CJ4: 'Caballos jóvenes 4 años',
  CJ5: 'Caballos jóvenes 5 años',
  CJ6: 'Caballos jóvenes 6 años',
  CJ7: 'Caballos jóvenes 7 años',
  CJ8_10: 'Caballos jóvenes 8-10 años',
  CABALLO_ADULTO: 'Caballo adulto',
};

const normalizar = (texto: string | null | undefined) =>
  (texto || '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();

const vieneDeRfhe = (b: Binomio) => b.concursos.some((c) => c.rfhe);

function faltan(b: Binomio): string[] {
  const lista: string[] = [];
  if (!b.fecha_nacimiento_jinete) lista.push('Sin fecha del jinete');
  if (!b.anio_nacimiento_caballo) lista.push('Sin año del caballo');
  return lista;
}

export default function JinetesYCaballosPage() {
  const [binomios, setBinomios] = useState<Binomio[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [busqueda, setBusqueda] = useState('');
  const [origen, setOrigen] = useState<'' | 'rfhe' | 'manual'>('');
  const [soloIncompletos, setSoloIncompletos] = useState(false);

  useEffect(() => {
    const cargar = async () => {
      setError('');
      const [binomiosRes, categoriasRes, inscripcionesRes, concursosRes] = await Promise.all([
        supabase
          .from('binomios')
          .select('id, nombre_jinete, nombre_caballo, ldn_jinete, lac_caballo, fh_jinete, fh_caballo, fecha_nacimiento_jinete, anio_nacimiento_caballo, estado_validacion')
          .order('nombre_jinete'),
        supabase.from('v_binomios_categorias').select('binomio_id, categoria_principal'),
        supabase.from('inscripciones').select('binomio_id, concurso_id'),
        supabase.from('concursos').select('id, nombre, rfhe_url'),
      ]);
      if (binomiosRes.error) {
        setError(binomiosRes.error.message);
        setLoading(false);
        return;
      }
      const categoria = new Map((categoriasRes.data || []).map((c) => [c.binomio_id, c.categoria_principal]));
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
        categoria_principal: categoria.get(b.id) || null,
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
      (!origen || (origen === 'rfhe') === vieneDeRfhe(b)) &&
      (!soloIncompletos || faltan(b).length > 0)
    );
  }, [binomios, busqueda, origen, soloIncompletos]);

  const incompletos = binomios.filter((b) => faltan(b).length > 0).length;

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

      {incompletos > 0 && (
        <div className="mb-4 flex flex-wrap items-center justify-between gap-3 rounded border border-amber-300 bg-amber-50 p-3 text-sm text-amber-900">
          <span>
            <strong>{incompletos}</strong> {incompletos === 1 ? 'binomio no tiene' : 'binomios no tienen'} fecha de nacimiento del jinete o del caballo.
            Sin ella no se puede calcular su categoría (Alevines, Infantiles, caballos jóvenes…).
          </span>
          {!soloIncompletos && (
            <button type="button" onClick={() => setSoloIncompletos(true)} className="btn btn-outline btn-sm">Ver solo esos</button>
          )}
        </div>
      )}

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
        <label className="flex items-center gap-2 pb-2 text-sm">
          <input type="checkbox" checked={soloIncompletos} onChange={(e) => setSoloIncompletos(e.target.checked)} />
          Solo los que les falta la fecha de nacimiento
        </label>
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
                    <th className="px-2 py-2">Categoría</th>
                    <th className="px-2 py-2">Concursos</th>
                    <th className="whitespace-nowrap px-2 py-2">Comprobado</th>
                    <th className="px-3 py-2" />
                  </tr>
                </thead>
                <tbody>
                  {visibles.map((b) => {
                    const pendientes = faltan(b);
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
                          {b.categoria_principal ? NOMBRE_CATEGORIA[b.categoria_principal] || b.categoria_principal : <span className="text-gray-400">—</span>}
                          {pendientes.length > 0 && (
                            <span className="mt-1 flex flex-col gap-0.5" title="Sin estos datos no se puede calcular la categoría">
                              {pendientes.map((p) => (
                                <span key={p} className="w-fit whitespace-nowrap rounded bg-amber-50 px-1.5 py-0.5 text-xs text-amber-800">{p}</span>
                              ))}
                            </span>
                          )}
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
