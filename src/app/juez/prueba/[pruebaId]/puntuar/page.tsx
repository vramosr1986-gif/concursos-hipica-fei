'use client';

import { useEffect, useState, useMemo } from 'react';
import { useParams } from 'next/navigation';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';
import FilaEjercicio from '../binomio/[participacionId]/FilaEjercicio';

type Prueba = {
  id: string;
  nombre: string;
  fecha: string;
  hora_inicio: string;
  pista: string | null;
  reprise_id: string | null;
  reprise_nombre: string | null;
};

type Participacion = {
  id: string;
  orden_salida: number;
  dorsal: number;
  jinete: string;
  caballo: string;
  equipo_id: string | null;
  equipo_nombre: string | null;
};

type Ejercicio = {
  id: string;
  numero_orden: number;
  letra: string | null;
  descripcion: string;
  coeficiente: number;
  puntuacion_max: number;
  tipo: string;
};

type PuntuacionExistente = {
  ejercicio_reprise_id: string;
  nota: number;
  comentario: string | null;
};

type GrupoEquipo = {
  equipo_id: string | null;
  equipo_nombre: string | null;
  participaciones: Participacion[];
};

export default function PuntuarPruebaPage() {
  const params = useParams();
  const pruebaId = params.pruebaId as string;

  const [prueba, setPrueba] = useState<Prueba | null>(null);
  const [participaciones, setParticipaciones] = useState<Participacion[]>([]);
  const [ejercicios, setEjercicios] = useState<Ejercicio[]>([]);
  const [puntuaciones, setPuntuaciones] = useState<Record<string, Record<string, PuntuacionExistente>>>({});
  const [pruebaJuezId, setPruebaJuezId] = useState<string | null>(null);
  const [letraJuez, setLetraJuez] = useState<string>('');

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const [tabActiva, setTabActiva] = useState<{ grupo: string; participacion: string }>({
    grupo: '',
    participacion: '',
  });

  // Cargar todo
  useEffect(() => {
    const cargar = async () => {
      try {
        const { data: { user } } = await supabase.auth.getUser();
        if (!user) {
          setError('No autenticado');
          return;
        }

        // 1. Prueba
        const { data: pruebaData, error: pruebaErr } = await supabase
          .from('pruebas')
          .select('id, nombre, fecha, hora_inicio, pista, reprise_id, reprise:reprise_id(nombre)')
          .eq('id', pruebaId)
          .single();

        if (pruebaErr) throw pruebaErr;

        setPrueba({
          id: pruebaData.id,
          nombre: pruebaData.nombre,
          fecha: pruebaData.fecha,
          hora_inicio: pruebaData.hora_inicio,
          pista: pruebaData.pista,
          reprise_id: pruebaData.reprise_id,
          reprise_nombre: (pruebaData as any).reprise?.nombre || null,
        });

        // 2. Buscar prueba_juez para este juez
        const { data: pjData, error: pjErr } = await supabase
          .from('prueba_jueces')
          .select('id, letra')
          .eq('prueba_id', pruebaId)
          .eq('juez_id', user.id)
          .single();

        if (pjErr || !pjData) {
          setError('No tienes asignada esta prueba como juez.');
          return;
        }

        setPruebaJuezId(pjData.id);
        setLetraJuez(pjData.letra);

        // 3. Participaciones con equipo
        const { data: partsData, error: partsErr } = await supabase
          .from('participaciones')
          .select(`
            id,
            orden_salida,
            equipo_id,
            equipo:equipo_id(nombre),
            inscripcion:inscripcion_id(
              dorsal,
              binomio:binomio_id(nombre_jinete, nombre_caballo)
            )
          `)
          .eq('prueba_id', pruebaId)
          .order('orden_salida', { ascending: true });

        if (partsErr) throw partsErr;

        const parts: Participacion[] = (partsData || []).map((p: any) => ({
          id: p.id,
          orden_salida: p.orden_salida,
          dorsal: p.inscripcion?.dorsal || 0,
          jinete: p.inscripcion?.binomio?.nombre_jinete || '-',
          caballo: p.inscripcion?.binomio?.nombre_caballo || '-',
          equipo_id: p.equipo_id || null,
          equipo_nombre: p.equipo?.nombre || null,
        }));

        setParticipaciones(parts);

        // 4. Ejercicios
        if (pruebaData.reprise_id) {
          const { data: ejsData, error: ejsErr } = await supabase
            .from('ejercicios_reprise')
            .select('id, numero_orden, letra, descripcion, coeficiente, puntuacion_max, tipo')
            .eq('reprise_id', pruebaData.reprise_id)
            .order('numero_orden', { ascending: true });

          if (ejsErr) throw ejsErr;
          setEjercicios(ejsData || []);
        }

        // 5. Puntuaciones existentes
        const { data: puntData } = await supabase
          .from('puntuaciones')
          .select('participacion_id, ejercicio_reprise_id, nota, comentario')
          .eq('prueba_juez_id', pjData.id);

        const mapa: Record<string, Record<string, PuntuacionExistente>> = {};
        (puntData || []).forEach((p: any) => {
          if (!mapa[p.participacion_id]) mapa[p.participacion_id] = {};
          mapa[p.participacion_id][p.ejercicio_reprise_id] = {
            ejercicio_reprise_id: p.ejercicio_reprise_id,
            nota: p.nota,
            comentario: p.comentario,
          };
        });
        setPuntuaciones(mapa);

        // 6. Establecer tab inicial
        if (parts.length > 0) {
          const primerGrupo = parts[0].equipo_id || 'sin-equipo';
          setTabActiva({ grupo: primerGrupo, participacion: parts[0].id });
        }
      } catch (err: any) {
        setError(err.message || 'Error al cargar');
      } finally {
        setLoading(false);
      }
    };

    if (pruebaId) cargar();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [pruebaId]);

  // Agrupar por equipo
  const grupos = useMemo(() => {
    const g: Record<string, GrupoEquipo> = {};
    for (const p of participaciones) {
      const key = p.equipo_id || 'sin-equipo';
      if (!g[key]) {
        g[key] = {
          equipo_id: p.equipo_id,
          equipo_nombre: p.equipo_nombre,
          participaciones: [],
        };
      }
      g[key].participaciones.push(p);
    }
    return Object.values(g).sort((a, b) => {
      if (a.equipo_id === null && b.equipo_id !== null) return 1;
      if (a.equipo_id !== null && b.equipo_id === null) return -1;
      return (a.equipo_nombre || '').localeCompare(b.equipo_nombre || '');
    });
  }, [participaciones]);

  const guardarPuntuacion = async (participacionId: string, ejercicioId: string, nota: number, comentario: string) => {
    if (!pruebaJuezId) throw new Error('Sin prueba_juez_id');

    const res = await fetch('/api/puntuaciones', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        participacion_id: participacionId,
        prueba_juez_id: pruebaJuezId,
        ejercicio_reprise_id: ejercicioId,
        nota,
        comentario: comentario || null,
      }),
    });

    if (!res.ok) {
      const body = await res.json().catch(() => ({}));
      throw new Error(body.error || 'Error al guardar');
    }

    setPuntuaciones((prev) => ({
      ...prev,
      [participacionId]: {
        ...(prev[participacionId] || {}),
        [ejercicioId]: { ejercicio_reprise_id: ejercicioId, nota, comentario },
      },
    }));
  };

  const formatearFecha = (fecha: string) => {
    if (!fecha) return '-';
    const [y, m, d] = fecha.split('-');
    return d + '/' + m + '/' + y;
  };


  const contarPuntuados = (participacionId: string) => {
    return Object.keys(puntuaciones[participacionId] || {}).length;
  };

  if (loading) return <div className="container py-8 text-center">Cargando...</div>;
  if (error) return <div className="container py-8 text-center text-red-600">{error}</div>;
  if (!prueba) return <div className="container py-8 text-center">Prueba no encontrada</div>;

  const participacionActiva = participaciones.find((p) => p.id === tabActiva.participacion);

  return (
    <div className="container max-w-5xl py-8">
      <Link href={'/juez/prueba/' + pruebaId} className="text-primary mb-4 inline-block hover:underline">
        Volver a la prueba
      </Link>

      {/* CABECERA */}
      {/* CABECERA COMPACTA */}
      <div className="card p-4 mb-4 border-l-4 border-[#112d24]">
        <div className="flex items-center justify-between flex-wrap gap-3">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 rounded-full bg-[#112d24] text-white flex items-center justify-center text-2xl font-bold">
              {letraJuez}
            </div>
            <div>
              <p className="text-xs text-gray-500 uppercase font-bold">Prueba</p>
              <h1 className="text-lg font-bold">{prueba.nombre}</h1>
              <p className="text-xs text-gray-600">
                {formatearFecha(prueba.fecha)} · {prueba.hora_inicio.substring(0, 5)}
                {prueba.pista && ' · ' + prueba.pista}
                {prueba.reprise_nombre && ' · ' + prueba.reprise_nombre}
              </p>
            </div>
          </div>
          <div className="text-right">
            <p className="text-xs text-gray-500">Total binomios</p>
            <p className="text-2xl font-bold">{participaciones.length}</p>
          </div>
        </div>
      </div>

      {/* PESTAÑAS DE GRUPO (EQUIPOS) */}
      {grupos.length > 1 && (
        <div className="flex gap-2 mb-4 overflow-x-auto">
          {grupos.map((g) => (
            <button
              key={g.equipo_id || 'sin-equipo'}
              onClick={() =>
                setTabActiva({
                  grupo: g.equipo_id || 'sin-equipo',
                  participacion: g.participaciones[0].id,
                })
              }
              className={`px-4 py-2 rounded font-medium whitespace-nowrap ${
                tabActiva.grupo === (g.equipo_id || 'sin-equipo')
                  ? g.equipo_id
                    ? 'bg-teal-600 text-white'
                    : 'bg-gray-700 text-white'
                  : 'bg-white border hover:bg-gray-50'
              }`}
            >
              {g.equipo_id ? `🏆 ${g.equipo_nombre}` : '👤 Sin equipo'} ({g.participaciones.length})
            </button>
          ))}
        </div>
      )}

      {/* PESTAÑAS DE MIEMBROS DEL GRUPO ACTIVO */}
      {(() => {
        const grupoActivo = grupos.find((g) => (g.equipo_id || 'sin-equipo') === tabActiva.grupo);
        if (!grupoActivo || grupoActivo.participaciones.length <= 1) return null;

        return (
          <div className="card p-3 mb-4 bg-gray-50">
            <p className="text-xs font-bold text-gray-600 mb-2">MIEMBROS DEL EQUIPO</p>
            <div className="flex gap-2 overflow-x-auto">
              {grupoActivo.participaciones.map((p) => {
                const puntuados = contarPuntuados(p.id);
                const total = ejercicios.length;
                return (
                  <button
                    key={p.id}
                    onClick={() => setTabActiva({ ...tabActiva, participacion: p.id })}
                    className={`px-3 py-2 rounded text-sm whitespace-nowrap ${
                      tabActiva.participacion === p.id
                        ? 'bg-[#112d24] text-white'
                        : 'bg-white border hover:bg-gray-100'
                    }`}
                  >
                    #{p.orden_salida} · Dorsal {p.dorsal} · {p.jinete}
                    <span className={`ml-2 text-xs ${puntuados === total ? 'text-green-500' : 'text-amber-500'}`}>
                      {puntuados}/{total}
                    </span>
                  </button>
                );
              })}
            </div>
          </div>
        );
      })()}

      {/* EJERCICIOS DEL MIEMBRO ACTIVO */}
      {participacionActiva && (
        <>
          <div className="card p-4 mb-4 bg-teal-50 border border-teal-200">
            <p className="text-xs font-bold text-teal-700 uppercase">
              {participacionActiva.equipo_nombre ? 'Miembro del equipo' : 'Binomio individual'}
            </p>
            <p className="text-lg font-bold">
              Dorsal {participacionActiva.dorsal} · {participacionActiva.jinete} / {participacionActiva.caballo}
            </p>
            {participacionActiva.equipo_nombre && (
              <p className="text-sm text-teal-700">🏆 {participacionActiva.equipo_nombre}</p>
            )}
          </div>

          {/* INFO DE LA PRUEBA QUE SE ESTA PUNTUANDO */}
          <div className="card p-4 mb-4 border-l-4 border-[#112d24] bg-white">
            <p className="text-xs font-bold text-gray-600 uppercase mb-1">
              Estás puntuando la prueba
            </p>
            <p className="text-lg font-bold text-[#112d24]">{prueba.nombre}</p>
            <div className="flex flex-wrap gap-4 text-sm text-gray-700 mt-1">
              <span>📅 {formatearFecha(prueba.fecha)}</span>
              <span>⏰ {prueba.hora_inicio.substring(0, 5)}</span>
              {prueba.pista && <span>🏟 {prueba.pista}</span>}
              {prueba.reprise_nombre && <span>📝 {prueba.reprise_nombre}</span>}
            </div>
          </div>

          {/* BARRA DE PROGRESO DEL MIEMBRO */}
          <div className="card p-4 mb-6">
            <div className="flex items-center justify-between mb-2">
              <span className="text-sm font-bold">Progreso</span>
              <span className="text-sm">
                {contarPuntuados(participacionActiva.id)} / {ejercicios.length}
              </span>
            </div>
            <div className="w-full bg-gray-200 rounded-full h-3">
              <div
                className="bg-green-600 h-3 rounded-full transition-all"
                style={{
                  width:
                    ejercicios.length > 0
                      ? (contarPuntuados(participacionActiva.id) / ejercicios.length) * 100 + '%'
                      : '0%',
                }}
              />
            </div>
          </div>

          {/* EJERCICIOS */}
          <div className="space-y-3">
            {ejercicios.map((ej) => {
              const punt = puntuaciones[participacionActiva.id]?.[ej.id];
              return (
                <FilaEjercicio
                  key={ej.id}
                  ejercicio={ej}
                  notaActual={punt?.nota ?? null}
                  comentarioActual={punt?.comentario ?? null}
                  onGuardar={async (ejercicioId, nota, comentario) => {
                    await guardarPuntuacion(participacionActiva.id, ejercicioId, nota, comentario);
                  }}
                />
              );
            })}
          </div>

          {ejercicios.length === 0 && (
            <div className="card p-8 text-center text-gray-600">
              Esta prueba no tiene ejercicios asignados.
            </div>
          )}
        </>
      )}
    </div>
  );
}