'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase';
import { FilaPrueba, TablaPruebas } from '@/components/TablaPruebas';

export default function PanelJuezPage() {
  const router = useRouter();
  const [pruebas, setPruebas] = useState<FilaPrueba[]>([]);
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
          'letra, prueba:prueba_id (id, concurso_id, nombre, fecha, hora_inicio, pista, categoria, estado, concurso:concurso_id (nombre), reprise:reprise_id (nombre, codigo), participaciones (id))'
        )
        .eq('juez_id', user.id);

      if (dbError) throw dbError;

      const filas = (asignaciones || []).map((a: any) => a.prueba && { letra: a.letra, prueba: a.prueba }).filter(Boolean);
      const participacionAPrueba = new Map<string, string>();
      for (const { prueba } of filas) {
        for (const p of prueba.participaciones || []) participacionAPrueba.set(p.id, prueba.id);
      }

      // Una sola consulta para contar lo que este juez ya ha puntuado en cada prueba.
      const puntuadasPorPrueba = new Map<string, number>();
      if (participacionAPrueba.size > 0) {
        const { data: puntuaciones } = await supabase
          .from('puntuaciones')
          .select('participacion_id')
          .eq('juez_id', user.id)
          .in('participacion_id', Array.from(participacionAPrueba.keys()));
        for (const p of puntuaciones || []) {
          const pruebaId = participacionAPrueba.get(p.participacion_id);
          if (pruebaId) puntuadasPorPrueba.set(pruebaId, (puntuadasPorPrueba.get(pruebaId) || 0) + 1);
        }
      }

      setPruebas(filas.map(({ letra, prueba }) => ({
        id: prueba.id,
        concurso_id: prueba.concurso_id,
        concurso_nombre: prueba.concurso?.nombre || '—',
        nombre: prueba.nombre,
        fecha: prueba.fecha,
        hora_inicio: prueba.hora_inicio,
        pista: prueba.pista,
        categoria: prueba.categoria,
        estado: prueba.estado,
        reprise_nombre: prueba.reprise?.nombre || null,
        reprise_codigo: prueba.reprise?.codigo || null,
        jueces: [],
        letra_juez: letra,
        num_binomios: (prueba.participaciones || []).length,
        num_puntuaciones: puntuadasPorPrueba.get(prueba.id) || 0,
      })));
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
              {pruebas.reduce((sum, p) => sum + (p.num_puntuaciones || 0), 0)}
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
        <TablaPruebas modo="juez" pruebas={pruebas} />
      )}
    </div>
  );
}