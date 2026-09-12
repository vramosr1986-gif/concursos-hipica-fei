'use client';

import { useEffect, useState } from 'react';
import { useParams } from 'next/navigation';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';
import FilaEjercicio from './FilaEjercicio';

type Prueba = {
  id: string;
  nombre: string;
  fecha: string;
  hora_inicio: string;
  pista: string | null;
  reprise_id: string | null;
  reprise_nombre: string | null;
  reprise_codigo: string | null;
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

export default function PuntuarBinomioPage() {
  const params = useParams();
  const pruebaId = params.pruebaId as string;
  const participacionId = params.participacionId as string;

  const [prueba, setPrueba] = useState<Prueba | null>(null);
  const [participacion, setParticipacion] = useState<Participacion | null>(null);
  const [ejercicios, setEjercicios] = useState<Ejercicio[]>([]);
  const [puntuaciones, setPuntuaciones] = useState<Record<string, PuntuacionExistente>>({});
  const [pruebaJuezId, setPruebaJuezId] = useState<string | null>(null);
  const [letraJuez, setLetraJuez] = useState<string>('');

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

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
          .select('id, nombre, fecha, hora_inicio, pista, reprise_id, reprise:reprise_id(nombre, codigo)')
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
          reprise_codigo: (pruebaData as any).reprise?.codigo || null,
        });

        // 2. Participacion
        const { data: partData, error: partErr } = await supabase
          .from('participaciones')
          .select('id, orden_salida, equipo_id, equipo:equipo_id(nombre), inscripcion:inscripcion_id(dorsal, binomio:binomio_id(nombre_jinete, nombre_caballo))')
          .eq('id', participacionId)
          .single();

        if (partErr) throw partErr;

        setParticipacion({
          id: partData.id,
          orden_salida: partData.orden_salida,
          dorsal: (partData as any).inscripcion?.dorsal || 0,
          jinete: (partData as any).inscripcion?.binomio?.nombre_jinete || '-',
          caballo: (partData as any).inscripcion?.binomio?.nombre_caballo || '-',
          equipo_id: (partData as any).equipo_id || null,
          equipo_nombre: (partData as any).equipo?.nombre || null,
        });

        // 3. Ejercicios
        if (pruebaData.reprise_id) {
          const { data: ejsData, error: ejsErr } = await supabase
            .from('ejercicios_reprise')
            .select('id, numero_orden, letra, descripcion, coeficiente, puntuacion_max, tipo')
            .eq('reprise_id', pruebaData.reprise_id)
            .order('numero_orden', { ascending: true });

          if (ejsErr) throw ejsErr;
          setEjercicios(ejsData || []);
        }

        // 4. Buscar prueba_juez para este juez y prueba
        const { data: pjData, error: pjErr } = await supabase
          .from('prueba_jueces')
          .select('id, letra')
          .eq('prueba_id', pruebaId)
          .eq('juez_id', user.id)
          .single();

        if (pjErr) {
          setError('No tienes asignada esta prueba como juez.');
          return;
        }

        setPruebaJuezId(pjData.id);
        setLetraJuez(pjData.letra);

        // 5. Puntuaciones existentes
        const { data: puntData, error: puntErr } = await supabase
          .from('puntuaciones')
          .select('ejercicio_reprise_id, nota, comentario')
          .eq('participacion_id', participacionId)
          .eq('prueba_juez_id', pjData.id);

        if (puntErr) throw puntErr;

        const mapa: Record<string, PuntuacionExistente> = {};
        (puntData || []).forEach((p: any) => {
          mapa[p.ejercicio_reprise_id] = {
            ejercicio_reprise_id: p.ejercicio_reprise_id,
            nota: p.nota,
            comentario: p.comentario,
          };
        });
        setPuntuaciones(mapa);

      } catch (err: any) {
        setError(err.message || 'Error al cargar');
      } finally {
        setLoading(false);
      }
    };

    if (pruebaId && participacionId) cargar();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [pruebaId, participacionId]);

  const guardarPuntuacion = async (ejercicioId: string, nota: number, comentario: string) => {
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

    // Actualizar cache local
    setPuntuaciones((prev) => ({
      ...prev,
      [ejercicioId]: { ejercicio_reprise_id: ejercicioId, nota, comentario },
    }));
  };

  const formatearFecha = (fecha: string) => {
    if (!fecha) return '-';
    const [y, m, d] = fecha.split('-');
    return d + '/' + m + '/' + y;
  };

  const puntuados = Object.keys(puntuaciones).length;
  const total = ejercicios.length;
  const porcentaje = total > 0 ? Math.round((puntuados / total) * 100) : 0;

  if (loading) return <div className="container py-8 text-center">Cargando...</div>;
  if (error) return <div className="container py-8 text-center text-red-600">{error}</div>;
  if (!prueba || !participacion) return <div className="container py-8 text-center">No encontrado</div>;

  return (
    <div className="container max-w-5xl py-8">
      <Link href={'/juez/prueba/' + pruebaId} className="text-primary mb-4 inline-block hover:underline">
        Volver a la prueba
      </Link>

      {/* CABECERA */}
      <div className="card p-6 mb-6 bg-[#112d24] text-white">
        <div className="flex items-start justify-between gap-4">
          <div>
            <p className="text-sm opacity-75">Puntuando con letra</p>
            <p className="text-5xl font-bold mb-2">{letraJuez}</p>
            <h1 className="text-xl font-bold">{prueba.nombre}</h1>
            <p className="text-sm opacity-75">
              {formatearFecha(prueba.fecha)} | {prueba.hora_inicio.substring(0, 5)}
              {prueba.pista && ' | ' + prueba.pista}
            </p>
            {prueba.reprise_nombre && (
              <p className="text-sm mt-1">Reprise: {prueba.reprise_nombre}</p>
            )}
          </div>
          <div className="text-right">
            <p className="text-sm opacity-75">Dorsal</p>
            <p className="text-5xl font-bold">{participacion.dorsal}</p>
          </div>
        </div>

        <div className="mt-4 pt-4 border-t border-white/20">
          <p className="text-lg font-bold">{participacion.jinete}</p>
          <p className="text-sm opacity-90">{participacion.caballo}</p>
        {participacion.equipo_nombre && (
          <p className="text-sm mt-1 text-teal-200">
            🏆 Equipo: <strong>{participacion.equipo_nombre}</strong>
          </p>
        )}
          
        </div>
      </div>

      {/* BARRA DE PROGRESO */}
      <div className="card p-4 mb-6">
        <div className="flex items-center justify-between mb-2">
          <span className="text-sm font-bold">Progreso de puntuacion</span>
          <span className="text-sm">
            {puntuados} / {total} ({porcentaje}%)
          </span>
        </div>
        <div className="w-full bg-gray-200 rounded-full h-3">
          <div
            className="bg-green-600 h-3 rounded-full transition-all"
            style={{ width: porcentaje + '%' }}
          />
        </div>
      </div>

      {/* EJERCICIOS */}
      <div className="space-y-3">
        {ejercicios.map((ej) => {
          const punt = puntuaciones[ej.id];
          return (
            <FilaEjercicio
              key={ej.id}
              ejercicio={ej}
              notaActual={punt?.nota ?? null}
              comentarioActual={punt?.comentario ?? null}
              onGuardar={guardarPuntuacion}
            />
          );
        })}
      </div>

      {ejercicios.length === 0 && (
        <div className="card p-8 text-center text-gray-600">
          Esta prueba no tiene ejercicios asignados.
        </div>
      )}
    </div>
  );
}