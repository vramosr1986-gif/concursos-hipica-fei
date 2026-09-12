'use client';

import { useEffect, useState } from 'react';
import { useParams } from 'next/navigation';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

type Prueba = {
  id: string;
  nombre: string;
  fecha: string;
  hora_inicio: string;
  pista: string | null;
  categoria: string | null;
  reprise_id: string | null;
  reprise_nombre: string | null;
  reprise_codigo: string | null;
  letra_juez: string;
};

type Participacion = {
  id: string;
  orden_salida: number;
  dorsal: number;
  jinete: string;
  caballo: string;
  equipo_id: string | null;
  equipo_nombre: string | null;
  puntuada: boolean;
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

        // 1. Cargar prueba
        const { data: pruebaData, error: pruebaErr } = await supabase
          .from('pruebas')
          .select('id, nombre, fecha, hora_inicio, pista, categoria, reprise_id, reprise:reprise_id(nombre, codigo)')
          .eq('id', pruebaId)
          .single();

        if (pruebaErr) throw pruebaErr;

        // 2. Obtener letra del juez
        const { data: pruebaJuez } = await supabase
          .from('prueba_jueces')
          .select('id, letra')
          .eq('prueba_id', pruebaId)
          .eq('juez_id', user.id)
          .single();

        if (!pruebaJuez) {
          setError('No tienes asignada esta prueba como juez.');
          return;
        }

        setPrueba({
          ...(pruebaData as any),
          reprise_nombre: (pruebaData as any).reprise?.nombre || null,
          reprise_codigo: (pruebaData as any).reprise?.codigo || null,
          letra_juez: pruebaJuez.letra,
        });

        // 3. Cargar participaciones con equipo
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

        const parts: Participacion[] = [];

        for (const p of partsData || []) {
          // Ver si ya la he puntuado
          const { count } = await supabase
            .from('puntuaciones')
            .select('id', { count: 'exact', head: true })
            .eq('participacion_id', p.id)
            .eq('prueba_juez_id', pruebaJuez.id);

          parts.push({
            id: p.id,
            orden_salida: p.orden_salida,
            dorsal: (p as any).inscripcion?.dorsal || 0,
            jinete: (p as any).inscripcion?.binomio?.nombre_jinete || '-',
            caballo: (p as any).inscripcion?.binomio?.nombre_caballo || '-',
            equipo_id: (p as any).equipo_id || null,
            equipo_nombre: (p as any).equipo?.nombre || null,
            puntuada: (count || 0) > 0,
          });
        }

        setParticipaciones(parts);
      } catch (err: any) {
        setError(err.message || 'Error al cargar');
      } finally {
        setLoading(false);
      }
    };

    if (pruebaId) cargar();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [pruebaId]);

  const formatearFecha = (fecha: string) => {
    if (!fecha) return '-';
    const [y, m, d] = fecha.split('-');
    return d + '/' + m + '/' + y;
  };

  // Agrupar participaciones por equipo
  const agruparPorEquipo = (): GrupoEquipo[] => {
    const grupos: Record<string, GrupoEquipo> = {};

    for (const p of participaciones) {
      const key = p.equipo_id || 'sin-equipo';
      if (!grupos[key]) {
        grupos[key] = {
          equipo_id: p.equipo_id,
          equipo_nombre: p.equipo_nombre,
          participaciones: [],
        };
      }
      grupos[key].participaciones.push(p);
    }

    // Ordenar: primero los equipos (por nombre), luego los sin equipo
    const ordenados = Object.values(grupos).sort((a, b) => {
      if (a.equipo_id === null && b.equipo_id !== null) return 1;
      if (a.equipo_id !== null && b.equipo_id === null) return -1;
      return (a.equipo_nombre || '').localeCompare(b.equipo_nombre || '');
    });

    return ordenados;
  };

  if (loading) return <div className="container py-8 text-center">Cargando...</div>;
  if (error) return <div className="container py-8 text-center text-red-600">{error}</div>;
  if (!prueba) return <div className="container py-8 text-center">Prueba no encontrada</div>;

  const grupos = agruparPorEquipo();
  const totalPuntuadas = participaciones.filter((p) => p.puntuada).length;

  return (
    <div className="container max-w-5xl py-8">
      <Link href="/juez" className="text-primary mb-4 inline-block hover:underline">
        Volver al panel
      </Link>

      {/* CABECERA */}
      <div className="card p-6 mb-6 bg-[#112d24] text-white">
        <div className="flex items-start justify-between gap-4">
          <div>
            <p className="text-sm opacity-75">Puntuando con letra</p>
            <p className="text-5xl font-bold mb-2">{prueba.letra_juez}</p>
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
            <p className="text-xs opacity-75">Puntuadas</p>
            <p className="text-3xl font-bold">{totalPuntuadas} / {participaciones.length}</p>
          </div>
        </div>
      </div>

      {/* BINOMIOS AGRUPADOS POR EQUIPO */}
      <div className="space-y-6">
        {grupos.map((grupo) => (
          <div key={grupo.equipo_id || 'sin-equipo'} className="card overflow-hidden">
            {/* CABECERA DEL GRUPO */}
            <div className={`p-4 border-b ${grupo.equipo_id ? 'bg-teal-50' : 'bg-gray-50'}`}>
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  {grupo.equipo_id ? (
                    <>
                      <span className="text-2xl">🏆</span>
                      <div>
                        <p className="text-xs text-teal-700 font-bold uppercase">Equipo</p>
                        <h2 className="text-xl font-bold text-teal-900">{grupo.equipo_nombre}</h2>
                      </div>
                    </>
                  ) : (
                    <>
                      <span className="text-2xl">👤</span>
                      <div>
                        <p className="text-xs text-gray-600 font-bold uppercase">Sin equipo</p>
                        <h2 className="text-xl font-bold text-gray-800">Binomios individuales</h2>
                      </div>
                    </>
                  )}
                </div>
                <div className="text-right">
                  <p className="text-xs text-gray-600">Binomios</p>
                  <p className="text-2xl font-bold">{grupo.participaciones.length}</p>
                </div>
              </div>
            </div>

            {/* TABLA DE BINOMIOS DEL GRUPO */}
            <div className="table-responsive">
              <table className="table">
                <thead>
                  <tr>
                    <th className="text-center w-16">Orden</th>
                    <th className="text-center w-16">Dorsal</th>
                    <th>Jinete</th>
                    <th>Caballo</th>
                    <th className="text-center">Estado</th>
                    <th className="text-right">Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  {grupo.participaciones.map((p) => (
                    <tr key={p.id} className="hover:bg-gray-50">
                      <td className="text-center font-bold text-lg">{p.orden_salida}</td>
                      <td className="text-center font-bold">{p.dorsal}</td>
                      <td className="font-medium">{p.jinete}</td>
                      <td>{p.caballo}</td>
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
                          href={'/juez/prueba/' + pruebaId + '/binomio/' + p.id}
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
        ))}
      </div>

      {participaciones.length === 0 && (
        <div className="card p-8 text-center text-gray-600">
          No hay binomios asignados a esta prueba todavia.
        </div>
      )}
    </div>
  );
}