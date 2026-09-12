'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase';

type PruebaJuez = {
  id: string;
  nombre: string;
  fecha: string;
  hora_inicio: string;
  pista: string | null;
  categoria: string | null;
  estado: string;
  reprise_nombre: string | null;
  reprise_codigo: string | null;
  letra: string;
  num_binomios: number;
  num_puntuaciones: number;
};

export default function PanelJuezPage() {
  const router = useRouter();
  const [pruebas, setPruebas] = useState<PruebaJuez[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [nombreJuez, setNombreJuez] = useState('');

  const cargarPruebas = async () => {
    setLoading(true);
    setError('');

    try {
      const {
        data: { user },
      } = await supabase.auth.getUser();

      if (!user) {
        router.push('/login');
        return;
      }

      const { data: perfil } = await supabase
        .from('profiles')
        .select('nombre, email')
        .eq('id', user.id)
        .single();

      if (perfil) {
        setNombreJuez(perfil.nombre || perfil.email);
      }

      const { data: asignaciones, error: dbError } = await supabase
        .from('prueba_jueces')
        .select(
          'letra, prueba:prueba_id (id, nombre, fecha, hora_inicio, pista, categoria, estado, reprise:reprise_id (nombre, codigo))'
        )
        .eq('juez_id', user.id);

      if (dbError) throw dbError;

      const pruebasEnriquecidas: PruebaJuez[] = [];

      for (const a of asignaciones || []) {
        const prueba = (a as any).prueba;
        if (!prueba) continue;

        const { count: binomiosCount } = await supabase
          .from('participaciones')
          .select('id', { count: 'exact', head: true })
          .eq('prueba_id', prueba.id);

        const { data: participaciones } = await supabase
          .from('participaciones')
          .select('id')
          .eq('prueba_id', prueba.id);

        const participacionesIds: string[] = [];
        if (participaciones) {
          participaciones.forEach((p: any) => participacionesIds.push(p.id));
        }

        let numPuntuaciones = 0;
        if (participacionesIds.length > 0) {
          const { count } = await supabase
            .from('puntuaciones')
            .select('id', { count: 'exact', head: true })
            .eq('juez_id', user.id)
            .in('participacion_id', participacionesIds);
          numPuntuaciones = count || 0;
        }

        pruebasEnriquecidas.push({
          id: prueba.id,
          nombre: prueba.nombre,
          fecha: prueba.fecha,
          hora_inicio: prueba.hora_inicio,
          pista: prueba.pista,
          categoria: prueba.categoria,
          estado: prueba.estado,
          reprise_nombre: prueba.reprise?.nombre || null,
          reprise_codigo: prueba.reprise?.codigo || null,
          letra: a.letra,
          num_binomios: binomiosCount || 0,
          num_puntuaciones: numPuntuaciones,
        });
      }

      pruebasEnriquecidas.sort((a, b) => {
        if (a.fecha !== b.fecha) return a.fecha.localeCompare(b.fecha);
        return a.hora_inicio.localeCompare(b.hora_inicio);
      });

      setPruebas(pruebasEnriquecidas);
    } catch (err: any) {
      setError(err.message || 'Error al cargar tus pruebas');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    cargarPruebas();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const formatearFecha = (fecha: string) => {
    if (!fecha) return '-';
    const [y, m, d] = fecha.split('-');
    const dias = ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'];
    const date = new Date(parseInt(y), parseInt(m) - 1, parseInt(d));
    return dias[date.getDay()] + ' ' + d + '/' + m + '/' + y;
  };

  const colorEstado = (estado: string) => {
    const colores: Record<string, string> = {
      programada: 'bg-blue-100 text-blue-800',
      en_curso: 'bg-amber-100 text-amber-800',
      finalizada: 'bg-green-100 text-green-800',
    };
    return colores[estado] || 'bg-gray-100 text-gray-800';
  };

  return (
    <div className="container max-w-6xl py-8">
      <div className="mb-6">
        <h1 className="text-3xl font-bold">Panel del Juez</h1>
        <p className="text-gray-600 mt-1">Bienvenido/a, {nombreJuez}</p>
      </div>

      <div className="card p-4 mb-6 bg-[#112d24] text-white">
        <div className="flex items-center justify-between">
          <div>
            <p className="text-sm opacity-75">Pruebas asignadas</p>
            <p className="text-3xl font-bold">{pruebas.length}</p>
          </div>
          <div className="text-right">
            <p className="text-sm opacity-75">Puntuaciones registradas</p>
            <p className="text-3xl font-bold">
              {pruebas.reduce((sum, p) => sum + p.num_puntuaciones, 0)}
            </p>
          </div>
        </div>
      </div>

      {error && (
        <div className="mb-4 p-4 bg-red-100 border border-red-300 text-red-700 rounded">
          {error}
        </div>
      )}

      {loading ? (
        <div className="card p-6 text-center">Cargando tus pruebas...</div>
      ) : pruebas.length === 0 ? (
        <div className="card p-8 text-center">
          <h2 className="text-xl font-semibold mb-2">
            No tienes pruebas asignadas
          </h2>
          <p className="text-gray-600">
            Contacta con el administrador para que te asigne a una prueba.
          </p>
        </div>
      ) : (
        <div className="grid gap-4">
          {pruebas.map((p) => (
            <div key={p.id} className="card p-6">
              <div className="flex items-start justify-between gap-4">
                <div className="flex-1">
                  <div className="flex items-center gap-3 mb-2">
                    <span className="px-3 py-1 rounded text-sm font-bold bg-amber-100 text-amber-800">
                      Letra {p.letra}
                    </span>
                    <span
                      className={'px-2 py-1 rounded text-xs font-medium ' + colorEstado(p.estado)}
                    >
                      {p.estado}
                    </span>
                  </div>

                  <h3 className="text-xl font-bold mb-1">{p.nombre}</h3>

                  {p.reprise_nombre && (
                    <p className="text-sm text-gray-600 mb-2">
                      <strong>Reprise:</strong> {p.reprise_nombre}
                      {p.reprise_codigo && (
                        <span className="text-xs font-mono ml-1 text-gray-400">
                          ({p.reprise_codigo})
                        </span>
                      )}
                    </p>
                  )}

                  <div className="grid grid-cols-2 md:grid-cols-4 gap-3 text-sm mt-3">
                    <div>
                      <span className="text-gray-500">Fecha:</span>
                      <br />
                      <strong>{formatearFecha(p.fecha)}</strong>
                    </div>
                    <div>
                      <span className="text-gray-500">Hora:</span>
                      <br />
                      <strong>{p.hora_inicio.substring(0, 5)}</strong>
                    </div>
                    <div>
                      <span className="text-gray-500">Pista:</span>
                      <br />
                      <strong>{p.pista || '-'}</strong>
                    </div>
                    <div>
                      <span className="text-gray-500">Categoria:</span>
                      <br />
                      <strong>{p.categoria || '-'}</strong>
                    </div>
                  </div>
                </div>

                <div className="text-right">
                  <div className="mb-3">
                    <p className="text-xs text-gray-500">Binomios</p>
                    <p className="text-2xl font-bold">{p.num_binomios}</p>
                  </div>
                  <div className="mb-3">
                    <p className="text-xs text-gray-500">Puntuaciones</p>
                    <p className="text-2xl font-bold text-green-600">
                      {p.num_puntuaciones}
                    </p>
                  </div>
                  <Link
                    href={'/juez/prueba/' + p.id}
                    className="btn btn-primary"
                  >
                    Puntuar
                  </Link>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}