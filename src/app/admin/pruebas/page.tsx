'use client';

import { useCallback, useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase';
import { FilaPrueba, TablaPruebas } from '@/components/TablaPruebas';

type OpcionJuez = { id: string; nombre: string };

export default function PruebasAdminPage() {
  const [pruebas, setPruebas] = useState<FilaPrueba[]>([]);
  const [jueces, setJueces] = useState<OpcionJuez[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const cargar = useCallback(async () => {
    setError('');
    const [pruebasRes, juecesRes] = await Promise.all([
      supabase
        .from('pruebas')
        .select(`
          id, concurso_id, nombre, categoria, fecha, hora_inicio, pista, estado,
          concurso:concurso_id(nombre),
          reprise:reprise_id(nombre, codigo),
          prueba_jueces(id, juez_id, letra, juez:juez_id(nombre, email)),
          participaciones(count)
        `)
        .order('fecha', { ascending: true })
        .order('hora_inicio', { ascending: true }),
      supabase.from('profiles').select('id, nombre, email').eq('rol', 'juez').order('nombre'),
    ]);

    if (pruebasRes.error) {
      setError(pruebasRes.error.message);
    } else {
      setPruebas((pruebasRes.data || []).map((p: any) => ({
        id: p.id,
        concurso_id: p.concurso_id,
        concurso_nombre: p.concurso?.nombre || '—',
        nombre: p.nombre,
        fecha: p.fecha,
        hora_inicio: p.hora_inicio,
        pista: p.pista,
        categoria: p.categoria,
        estado: p.estado,
        reprise_nombre: p.reprise?.nombre || null,
        reprise_codigo: p.reprise?.codigo || null,
        jueces: (p.prueba_jueces || []).map((j: any) => ({
          id: j.id,
          juez_id: j.juez_id,
          letra: j.letra,
          nombre: j.juez?.nombre || j.juez?.email || 'Sin nombre',
        })),
        num_binomios: p.participaciones?.[0]?.count ?? 0,
      })));
    }
    if (juecesRes.data) {
      setJueces(juecesRes.data.map((u) => ({ id: u.id, nombre: u.nombre || u.email })));
    }
    setLoading(false);
  }, []);

  useEffect(() => {
    cargar();
  }, [cargar]);

  const cambiarPista = async (pruebaIds: string[], pista: string) => {
    const { error: dbError } = await supabase.from('pruebas').update({ pista: pista || null }).in('id', pruebaIds);
    if (dbError) throw new Error(dbError.message);
    setPruebas((actuales) => actuales.map((p) => (pruebaIds.includes(p.id) ? { ...p, pista: pista || null } : p)));
  };

  const asignarJuez = async (pruebaIds: string[], juezId: string, letra: string) => {
    const fallos: string[] = [];
    let asignadas = 0;
    for (const pruebaId of pruebaIds) {
      const prueba = pruebas.find((p) => p.id === pruebaId);
      if (prueba?.jueces.some((j) => j.juez_id === juezId)) continue;
      const { error: dbError } = await supabase.from('prueba_jueces').insert({ prueba_id: pruebaId, juez_id: juezId, letra });
      if (dbError) {
        fallos.push(`${prueba?.nombre || pruebaId}${dbError.code === '23505' ? ` (la letra ${letra} ya está ocupada)` : `: ${dbError.message}`}`);
      } else {
        asignadas++;
      }
    }
    await cargar();
    if (fallos.length > 0) {
      throw new Error(`Asignado en ${asignadas} pruebas. No se pudo en: ${fallos.join('; ')}`);
    }
  };

  const quitarJuez = async (asignacionId: string) => {
    const { error: dbError } = await supabase.from('prueba_jueces').delete().eq('id', asignacionId);
    if (dbError) throw new Error(dbError.message);
    setPruebas((actuales) => actuales.map((p) => ({ ...p, jueces: p.jueces.filter((j) => j.id !== asignacionId) })));
  };

  return (
    <div className="container max-w-7xl py-8">
      <div className="mb-6">
        <h1 className="text-3xl font-bold">Pruebas</h1>
        <p className="mt-1 text-gray-600">
          Todas las pruebas de todos los concursos. Asigna la pista y los jueces aquí, de una en una o seleccionando varias.
        </p>
      </div>
      {error && <p role="alert" className="mb-4 rounded border border-red-200 bg-red-50 p-3 text-sm text-red-700">{error}</p>}
      {loading ? (
        <div className="card p-6 text-center">Cargando pruebas…</div>
      ) : (
        <TablaPruebas
          modo="admin"
          pruebas={pruebas}
          juecesDisponibles={jueces}
          onCambiarPista={cambiarPista}
          onAsignarJuez={asignarJuez}
          onQuitarJuez={quitarJuez}
        />
      )}
    </div>
  );
}
