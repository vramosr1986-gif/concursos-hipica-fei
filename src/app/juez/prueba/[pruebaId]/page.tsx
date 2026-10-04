'use client';

import { useEffect, useState } from 'react';
import { useParams } from 'next/navigation';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';
import { JuezDeLaPrueba, pruebaJuezDeLaUrl, resolverPuntuador } from '@/lib/juez-actual';
import { CaballoConBandera } from '@/components/BanderaFH';

/** Pendiente: ninguna nota. Puntuando: le faltan notas. Puntuada: todos los ejercicios con nota. */
type EstadoNotas = 'pendiente' | 'puntuando' | 'puntuada';
const ESTADO_NOTAS: Record<EstadoNotas, { texto: string; clase: string }> = {
  pendiente: { texto: 'Pendiente', clase: 'bg-gray-100 text-gray-700' },
  puntuando: { texto: 'Puntuando', clase: 'bg-amber-100 text-amber-800' },
  puntuada: { texto: 'Puntuada', clase: 'bg-green-100 text-green-800' },
};
import { esPendienteConfirmacion, nombreConMarca } from '@/lib/rfhe-pruebas';

type Concurso = {
  id: string;
  nombre: string;
  ubicacion: string | null;
  fecha_inicio: string | null;
  fecha_fin: string | null;
};

type Jornada = {
  id: string;
  fecha: string;
  pista: string | null;
  hora_inicio: string | null;
  hora_fin: string | null;
};

type Prueba = {
  id: string;
  nombre: string;
  fecha: string;
  hora_inicio: string;
  pista: string | null;
  categoria: string | null;
  estado: string | null;
  reprise_id: string | null;
  reprise_nombre: string | null;
  reprise_codigo: string | null;
  letra_juez: string;
  concurso: Concurso | null;
  jornada: Jornada | null;
};

type Participacion = {
  id: string;
  orden_salida: number;
  dorsal: number;
  jinete: string;
  caballo: string;
  fh_caballo: string | null;
  /** Notas puestas por este juez / ejercicios de la reprise. */
  notas: number;
  estado: EstadoNotas;
  pendiente: boolean;
};

export default function PuntuarPruebaPage() {
  const params = useParams();
  const pruebaId = params.pruebaId as string;

  const [prueba, setPrueba] = useState<Prueba | null>(null);
  const [participaciones, setParticipaciones] = useState<Participacion[]>([]);
  const [loading, setLoading] = useState(true);
  const [ejerciciosReprise, setEjerciciosReprise] = useState(0);
  const [error, setError] = useState('');
  // Admin: con qué juez puntúa (?pj= en la URL) y lista de jueces de la prueba.
  const [pj, setPj] = useState<string | null>(null);
  const [esAdmin, setEsAdmin] = useState(false);
  const [jueces, setJueces] = useState<JuezDeLaPrueba[]>([]);
  const [pjActual, setPjActual] = useState<string | null>(null);
  const [listo, setListo] = useState(false);

  useEffect(() => {
    setPj(pruebaJuezDeLaUrl());
    setListo(true);
  }, []);

  const elegirJuez = (id: string) => {
    const url = new URL(window.location.href);
    url.searchParams.set('pj', id);
    window.history.replaceState(null, '', url.toString());
    setLoading(true);
    setError('');
    setPj(id);
  };

  useEffect(() => {
    const cargar = async () => {
      try {
        const { data: { user } } = await supabase.auth.getUser();
        if (!user) {
          setError('No autenticado');
          return;
        }

        const { data: pruebaData, error: pruebaErr } = await supabase
          .from('pruebas')
          .select(`
            id, nombre, fecha, hora_inicio, pista, categoria, estado,
            reprise_id,
            reprise:reprise_id(nombre, codigo),
            concurso:concurso_id(id, nombre, ubicacion, fecha_inicio, fecha_fin),
            jornada:jornada_id(id, fecha, pista, hora_inicio, hora_fin)
          `)
          .eq('id', pruebaId)
          .single();

        if (pruebaErr) throw pruebaErr;

        const puntuador = await resolverPuntuador(pruebaId, pj);
        setEsAdmin(puntuador.esAdmin);
        setJueces(puntuador.jueces);
        if (!puntuador.ok) {
          setError(puntuador.error);
          return;
        }
        setPjActual(puntuador.pruebaJuezId);
        const pruebaJuez = { id: puntuador.pruebaJuezId, letra: puntuador.letra };

        setPrueba({
          id: (pruebaData as any).id,
          nombre: (pruebaData as any).nombre,
          fecha: (pruebaData as any).fecha,
          hora_inicio: (pruebaData as any).hora_inicio,
          pista: (pruebaData as any).pista,
          categoria: (pruebaData as any).categoria,
          estado: (pruebaData as any).estado,
          reprise_id: (pruebaData as any).reprise_id,
          reprise_nombre: (pruebaData as any).reprise?.nombre || null,
          reprise_codigo: (pruebaData as any).reprise?.codigo || null,
          letra_juez: pruebaJuez.letra,
          concurso: (pruebaData as any).concurso || null,
          jornada: (pruebaData as any).jornada || null,
        });

        const { data: partsData, error: partsErr } = await supabase
          .from('participaciones')
          .select(`
            id,
            orden_salida,
            observaciones,
            inscripcion:inscripcion_id(
              dorsal,
              binomio:binomio_id(nombre_jinete, nombre_caballo, fh_caballo)
            )
          `)
          .eq('prueba_id', pruebaId)
          .order('orden_salida', { ascending: true });

        if (partsErr) throw partsErr;

        const parts: Participacion[] = [];
        const ids = (partsData || []).map((p) => p.id);
        const [{ data: hechas }, { count: totalEjercicios }] = await Promise.all([
          ids.length > 0
            ? supabase.from('puntuaciones').select('participacion_id').eq('prueba_juez_id', pruebaJuez.id).in('participacion_id', ids)
            : Promise.resolve({ data: [] as { participacion_id: string }[] }),
          (pruebaData as any).reprise_id
            ? supabase.from('ejercicios_reprise').select('id', { count: 'exact', head: true }).eq('reprise_id', (pruebaData as any).reprise_id)
            : Promise.resolve({ count: 0 }),
        ]);
        const notasPorBinomio = new Map<string, number>();
        for (const h of hechas || []) notasPorBinomio.set(h.participacion_id, (notasPorBinomio.get(h.participacion_id) || 0) + 1);
        const estadoDe = (notas: number): EstadoNotas =>
          notas === 0 ? 'pendiente' : totalEjercicios && notas >= totalEjercicios ? 'puntuada' : 'puntuando';
        setEjerciciosReprise(totalEjercicios || 0);

        for (const p of partsData || []) {
          parts.push({
            id: p.id,
            orden_salida: p.orden_salida,
            dorsal: (p as any).inscripcion?.dorsal || 0,
            jinete: (p as any).inscripcion?.binomio?.nombre_jinete || '-',
            caballo: (p as any).inscripcion?.binomio?.nombre_caballo || '-',
            fh_caballo: (p as any).inscripcion?.binomio?.fh_caballo || null,
            notas: notasPorBinomio.get(p.id) || 0,
            estado: estadoDe(notasPorBinomio.get(p.id) || 0),
            pendiente: esPendienteConfirmacion((p as any).observaciones),
          });
        }

        setParticipaciones(parts);
      } catch (err: any) {
        setError(err.message || 'Error al cargar');
      } finally {
        setLoading(false);
      }
    };

    if (pruebaId && listo) cargar();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [pruebaId, pj, listo]);

  const formatearFecha = (fecha: string | null | undefined) => {
    if (!fecha) return '-';
    const [y, m, d] = fecha.split('-');
    return d + '/' + m + '/' + y;
  };

  const selectorJuez = esAdmin && jueces.length > 0 && (
    <div className="card mb-4 flex flex-wrap items-center gap-3 p-4">
      <label htmlFor="puntuar-como" className="font-semibold">Puntuando como:</label>
      <select id="puntuar-como" value={pjActual || ''} onChange={(e) => elegirJuez(e.target.value)} className="input">
        {!pjActual && <option value="">-- Elige el juez --</option>}
        {jueces.map((j) => <option key={j.id} value={j.id}>Letra {j.letra} · {j.nombre}</option>)}
      </select>
      <span className="text-sm text-gray-600">Eres admin: las notas se guardan a nombre del juez que elijas.</span>
    </div>
  );

  if (loading) return <div className="container py-8 text-center">Cargando...</div>;
  if (error) {
    return (
      <div className="container max-w-5xl py-8">
        {selectorJuez}
        <p className={esAdmin && jueces.length > 0 ? 'text-center text-gray-700' : 'text-center text-red-600'}>{error}</p>
      </div>
    );
  }
  if (!prueba) return <div className="container py-8 text-center">Prueba no encontrada</div>;

  const totalPuntuadas = participaciones.filter((p) => p.estado === 'puntuada').length;

  return (
    <div className="container max-w-5xl py-8">
      <Link href="/juez" className="text-primary mb-4 inline-block hover:underline">
        Volver al panel
      </Link>
      {selectorJuez}

            {/* CABECERA COMPACTA */}
      <div className="card mb-6 overflow-hidden">
        <div className="bg-[#112d24] text-white px-5 py-4">
          <div className="flex items-center justify-between gap-4 flex-wrap">
            <div className="flex items-baseline gap-3 flex-wrap min-w-0">
              {prueba.concurso && (
                <>
                  <span className="text-[#e8c98d] font-serif text-lg truncate">
                    {prueba.concurso.nombre}
                  </span>
                  <span className="text-white/40">&middot;</span>
                </>
              )}
              <span className="text-lg font-bold truncate">{prueba.nombre}</span>
            </div>
            <div className="flex items-center gap-3 text-sm flex-shrink-0">
              <span className="px-2 py-0.5 rounded bg-[#b88746] text-white font-bold">
                Letra {prueba.letra_juez}
              </span>
              <span className="opacity-75">
                {totalPuntuadas} / {participaciones.length} puntuadas
              </span>
            </div>
          </div>
          <div className="flex flex-wrap items-center gap-x-4 gap-y-1 mt-2 text-xs opacity-75">
            <span>{formatearFecha(prueba.jornada?.fecha || prueba.fecha)}</span>
            <span>{(prueba.jornada?.hora_inicio || prueba.hora_inicio)?.substring(0, 5)}</span>
            {(prueba.jornada?.pista || prueba.pista) && (
              <span>{prueba.jornada?.pista || prueba.pista}</span>
            )}
            {prueba.categoria && <span>{prueba.categoria}</span>}
            {prueba.reprise_codigo && (
              <span className="font-mono">{prueba.reprise_codigo}</span>
            )}
          </div>
        </div>
      </div>

      {participaciones.length > 0 && (
        <div className="card overflow-hidden">
          <div className="overflow-x-auto">
              <table className="w-full text-left text-sm">
                <thead className="bg-[#f4f0e6] text-xs uppercase text-[#466257]">
                  <tr>
                    <th className="w-12 px-2 py-2 text-center" title="Orden de salida">Orden</th>
                    <th className="w-14 px-2 py-2 text-center">Dorsal</th>
                    <th className="px-2 py-2">Jinete / caballo</th>
                    <th className="px-2 py-2 text-right">
                      <span className="sr-only">Estado y puntuar</span>
                    </th>
                  </tr>
                </thead>
                <tbody>
                  {participaciones.map((p) => (
                    <tr key={p.id} className="border-t border-[#eee9df] hover:bg-gray-50">
                      <td className="px-2 py-2 text-center text-lg font-bold">{p.orden_salida}</td>
                      <td className="px-2 py-2 text-center font-bold">{p.dorsal}</td>
                      <td className="px-2 py-2">
                        <span className="block font-medium">{nombreConMarca(p.jinete, p.pendiente)}</span>
                        <span className="block text-gray-600"><CaballoConBandera nombre={p.caballo} fh={p.fh_caballo} /></span>
                      </td>
                      <td className="whitespace-nowrap px-2 py-2 text-right">
                        <span className={`mr-2 hidden rounded px-2 py-1 text-xs font-medium sm:inline-block ${ESTADO_NOTAS[p.estado].clase}`}>
                          {ESTADO_NOTAS[p.estado].texto}
                          {p.estado === 'puntuando' && ejerciciosReprise > 0 && ` ${p.notas}/${ejerciciosReprise}`}
                        </span>
                        <Link
                          href={'/juez/prueba/' + pruebaId + '/binomio/' + p.id + (esAdmin && pjActual ? '?pj=' + pjActual : '')}
                          className={`btn text-sm ${p.estado === 'puntuada' ? 'btn-outline' : 'btn-primary'}`}
                        >
                          {p.estado === 'puntuada' ? 'Editar' : p.estado === 'puntuando' ? 'Seguir' : 'Puntuar'}
                        </Link>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
        </div>
      )}

      {participaciones.length === 0 && (
        <div className="card p-8 text-center text-gray-600">
          No hay binomios asignados a esta prueba todavía.
        </div>
      )}
    </div>
  );
}