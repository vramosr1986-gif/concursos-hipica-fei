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
  const [esAdmin, setEsAdmin] = useState(false);

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
        .select('nombre, email, rol')
        .eq('id', user.id)
        .single();

      if (perfil) {
        setNombreJuez(perfil.nombre || perfil.email);
      }
      const admin = perfil?.rol === 'admin';
      setEsAdmin(admin);

      const camposPrueba = 'id, concurso_id, nombre, fecha, hora_inicio, pista, categoria, estado, concurso:concurso_id (nombre), reprise_id, reprise:reprise_id (nombre, codigo), participaciones (id), prueba_jueces (id)';

      // Juez: sus asignaciones. Admin: todas las pruebas (puede puntuar en nombre de cualquier juez).
      let filas: { letra: string; pruebaJuezId: string | null; prueba: any }[];
      if (admin) {
        const { data, error: dbError } = await supabase.from('pruebas').select(camposPrueba);
        if (dbError) throw dbError;
        filas = (data || []).map((prueba: any) => ({ letra: '—', pruebaJuezId: null, prueba }));
      } else {
        const { data, error: dbError } = await supabase
          .from('prueba_jueces')
          .select(`id, letra, prueba:prueba_id (${camposPrueba})`)
          .eq('juez_id', user.id);
        if (dbError) throw dbError;
        filas = (data || []).filter((a: any) => a.prueba).map((a: any) => ({ letra: a.letra, pruebaJuezId: a.id, prueba: a.prueba }));
      }

      const participacionAPrueba = new Map<string, string>();
      for (const { prueba } of filas) {
        for (const p of prueba.participaciones || []) participacionAPrueba.set(p.id, prueba.id);
      }

      // Ejercicios de cada reprise: un binomio está puntuado solo con todas sus notas.
      const repriseIds = Array.from(new Set(filas.map((f) => f.prueba.reprise_id).filter(Boolean)));
      const ejerciciosPorReprise = new Map<string, number>();
      if (repriseIds.length > 0) {
        const { data: ejs } = await supabase.from('ejercicios_reprise').select('reprise_id').in('reprise_id', repriseIds);
        for (const e of ejs || []) ejerciciosPorReprise.set(e.reprise_id, (ejerciciosPorReprise.get(e.reprise_id) || 0) + 1);
      }

      // Notas por binomio (del juez; el admin, de todos los jueces de la prueba).
      const notasPorBinomio = new Map<string, number>();
      const ids = Array.from(participacionAPrueba.keys());
      for (let i = 0; i < ids.length; i += 300) {
        let consulta = supabase.from('puntuaciones').select('participacion_id').in('participacion_id', ids.slice(i, i + 300));
        if (!admin) consulta = consulta.in('prueba_juez_id', filas.map((f) => f.pruebaJuezId as string));
        const { data: notas } = await consulta;
        for (const n of notas || []) notasPorBinomio.set(n.participacion_id, (notasPorBinomio.get(n.participacion_id) || 0) + 1);
      }
      const puntuadosPorPrueba = new Map<string, Set<string>>();
      for (const { prueba } of filas) {
        const ejercicios = ejerciciosPorReprise.get(prueba.reprise_id) || 0;
        const jueces = admin ? (prueba.prueba_jueces || []).length : 1;
        const necesarias = ejercicios * jueces;
        const completos = new Set<string>();
        for (const p of prueba.participaciones || []) {
          if (necesarias > 0 && (notasPorBinomio.get(p.id) || 0) >= necesarias) completos.add(p.id);
        }
        puntuadosPorPrueba.set(prueba.id, completos);
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
        num_puntuaciones: puntuadosPorPrueba.get(prueba.id)?.size || 0,
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
        {esAdmin && (
          <p className="mt-2 text-sm text-gray-600">Eres admin: ves todas las pruebas y puedes puntuar cualquiera eligiendo con qué juez.</p>
        )}
      </div>

      <div className="card p-4 mb-6 bg-[#112d24] text-white">
        <div className="flex items-center justify-between">
          <div>
            <p className="text-sm opacity-75">{esAdmin ? 'Pruebas' : 'Pruebas asignadas'}</p>
            <p className="text-3xl font-bold">{pruebas.length}</p>
          </div>
          <div className="text-right">
            <p className="text-sm opacity-75">Binomios puntuados</p>
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