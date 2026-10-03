'use client';

import { useEffect, useState } from 'react';
import { useParams } from 'next/navigation';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';
import { JuezDeLaPrueba, pruebaJuezDeLaUrl, resolverPuntuador } from '@/lib/juez-actual';
import { CaballoConBandera } from '@/components/BanderaFH';
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
  puntuada: boolean;
  pendiente: boolean;
};

export default function PuntuarPruebaPage() {
  const params = useParams();
  const pruebaId = params.pruebaId as string;

  const [prueba, setPrueba] = useState<Prueba | null>(null);
  const [participaciones, setParticipaciones] = useState<Participacion[]>([]);
  const [loading, setLoading] = useState(true);
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
        const { data: hechas } = ids.length > 0
          ? await supabase.from('puntuaciones').select('participacion_id').eq('prueba_juez_id', pruebaJuez.id).in('participacion_id', ids)
          : { data: [] as { participacion_id: string }[] };
        const puntuadas = new Set((hechas || []).map((h) => h.participacion_id));

        for (const p of partsData || []) {
          parts.push({
            id: p.id,
            orden_salida: p.orden_salida,
            dorsal: (p as any).inscripcion?.dorsal || 0,
            jinete: (p as any).inscripcion?.binomio?.nombre_jinete || '-',
            caballo: (p as any).inscripcion?.binomio?.nombre_caballo || '-',
            fh_caballo: (p as any).inscripcion?.binomio?.fh_caballo || null,
            puntuada: puntuadas.has(p.id),
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

  const totalPuntuadas = participaciones.filter((p) => p.puntuada).length;

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
          <div className="table-responsive">
              <table className="table">
                <thead>
                  <tr>
                    <th className="text-center w-16">Orden</th>
                    <th className="text-center w-16">Dorsal</th>
                    <th>Jinete</th>
                    <th>Caballo</th>
                    <th>Concurso</th>
                    <th className="text-center">Estado</th>
                    <th className="text-right">Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  {participaciones.map((p) => (
                    <tr key={p.id} className="hover:bg-gray-50">
                      <td className="text-center font-bold text-lg">{p.orden_salida}</td>
                      <td className="text-center font-bold">{p.dorsal}</td>
                      <td className="font-medium">{nombreConMarca(p.jinete, p.pendiente)}</td>
                      <td><CaballoConBandera nombre={p.caballo} fh={p.fh_caballo} /></td>
                      <td className="text-sm text-gray-600">
                        {prueba.concurso?.nombre || '-'}
                      </td>
                      <td className="text-center">
                        {p.puntuada ? (
                          <span className="px-2 py-1 rounded text-xs bg-green-100 text-green-800 font-medium">
                            Puntuada
                          </span>
                        ) : (
                          <span className="px-2 py-1 rounded text-xs bg-amber-100 text-amber-800 font-medium">
                            Pendiente
                          </span>
                        )}
                      </td>
                      <td className="text-right">
                        <Link
                          href={'/juez/prueba/' + pruebaId + '/binomio/' + p.id + (esAdmin && pjActual ? '?pj=' + pjActual : '')}
                          className="btn btn-primary text-sm"
                        >
                          {p.puntuada ? 'Editar' : 'Puntuar'}
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