'use client';

import { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase';

type Equipo = {
  id: string;
  concurso_id: string;
  nombre: string;
  club: string | null;
  categoria_edad_id: string | null;
  num_miembros: number;
};

type Miembro = {
  id: string;
  equipo_id: string;
  inscripcion_id: string;
  dorsal: number;
  jinete: string;
  caballo: string;
  categoria: string | null;
};

type InscripcionDisponible = {
  id: string;
  dorsal: number;
  jinete: string;
  caballo: string;
  categoria: string | null;
};

type CategoriaEdad = {
  id: string;
  codigo: string;
  nombre: string;
};

type NuevoEquipoForm = {
  nombre: string;
  club: string;
  categoria_edad_id: string;
};

interface Props {
  concursoId: string;
}

function nuevoEquipoVacio(): NuevoEquipoForm {
  return { nombre: '', club: '', categoria_edad_id: '' };
}

export function EquiposSection({ concursoId }: Props) {
  const [equipos, setEquipos] = useState<Equipo[]>([]);
  const [miembrosPorEquipo, setMiembrosPorEquipo] = useState<Record<string, Miembro[]>>({});
  const [categorias, setCategorias] = useState<CategoriaEdad[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const [modalEquipoAbierto, setModalEquipoAbierto] = useState(false);
  const [nuevoEquipo, setNuevoEquipo] = useState<NuevoEquipoForm>(nuevoEquipoVacio());
  const [guardandoEquipo, setGuardandoEquipo] = useState(false);

  const [modalMiembroAbierto, setModalMiembroAbierto] = useState<string | null>(null);
  const [inscripcionesDisponibles, setInscripcionesDisponibles] = useState<InscripcionDisponible[]>([]);
  const [inscripcionSeleccionada, setInscripcionSeleccionada] = useState('');
  const [guardandoMiembro, setGuardandoMiembro] = useState(false);

  const cargarTodo = async () => {
    setLoading(true);
    setError('');
    try {
      const { data: equiposData, error: equiposErr } = await supabase
        .from('equipos')
        .select('id, concurso_id, nombre, club, categoria_edad_id')
        .eq('concurso_id', concursoId)
        .order('nombre');

      if (equiposErr) throw equiposErr;

      const equiposConMiembros: Equipo[] = [];
      const mapaMiembros: Record<string, Miembro[]> = {};

      for (const eq of equiposData || []) {
        const { data: mData, error: mErr } = await supabase
          .from('equipo_miembros')
          .select(`
            id, equipo_id, inscripcion_id,
            inscripcion:inscripcion_id(
              dorsal, categoria,
              binomio:binomio_id(nombre_jinete, nombre_caballo)
            )
          `)
          .eq('equipo_id', eq.id)
          .order('orden');

        if (mErr) throw mErr;

        const miembros: Miembro[] = (mData || []).map((m: any) => ({
          id: m.id,
          equipo_id: m.equipo_id,
          inscripcion_id: m.inscripcion_id,
          dorsal: m.inscripcion?.dorsal || 0,
          jinete: m.inscripcion?.binomio?.nombre_jinete || '-',
          caballo: m.inscripcion?.binomio?.nombre_caballo || '-',
          categoria: m.inscripcion?.categoria || null,
        }));

        mapaMiembros[eq.id] = miembros;
        equiposConMiembros.push({ ...eq, num_miembros: miembros.length });
      }

      setEquipos(equiposConMiembros);
      setMiembrosPorEquipo(mapaMiembros);
    } catch (err: any) {
      setError(err.message || 'Error al cargar equipos');
    } finally {
      setLoading(false);
    }
  };

  const cargarCategorias = async () => {
    const { data } = await supabase
      .from('categorias_edad')
      .select('id, codigo, nombre')
      .order('orden');
    if (data) setCategorias(data);
  };

  useEffect(() => {
    cargarTodo();
    cargarCategorias();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [concursoId]);

  const handleCrearEquipo = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!nuevoEquipo.nombre.trim()) {
      setError('El nombre del equipo es obligatorio');
      return;
    }
    setGuardandoEquipo(true);
    setError('');
    try {
      const { error: dbErr } = await supabase.from('equipos').insert({
        concurso_id: concursoId,
        nombre: nuevoEquipo.nombre.trim(),
        club: nuevoEquipo.club.trim() || null,
        categoria_edad_id: nuevoEquipo.categoria_edad_id || null,
      });
      if (dbErr) {
        if ((dbErr as any).code === '23505') {
          throw new Error('Ya existe un equipo con ese nombre en este concurso');
        }
        throw dbErr;
      }
      setNuevoEquipo(nuevoEquipoVacio());
      setModalEquipoAbierto(false);
      await cargarTodo();
    } catch (err: any) {
      setError(err.message);
    } finally {
      setGuardandoEquipo(false);
    }
  };

  const eliminarEquipo = async (equipoId: string, nombre: string) => {
    if (!confirm(`Eliminar el equipo "${nombre}"? Se quitaran sus miembros.`)) return;
    try {
      const { error: dbErr } = await supabase.from('equipos').delete().eq('id', equipoId);
      if (dbErr) throw dbErr;
      await cargarTodo();
    } catch (err: any) {
      setError(err.message);
    }
  };

  const abrirModalMiembro = async (equipoId: string) => {
    // Cargar inscripciones que NO estan en ningun equipo de este concurso
    try {
      const { data: yaEnEquipos } = await supabase
        .from('equipo_miembros')
        .select('inscripcion_id, equipo:equipo_id(concurso_id)')
        .eq('equipo.concurso_id', concursoId);

      const idsOcupados = new Set(
        (yaEnEquipos || []).map((m: any) => m.inscripcion_id)
      );

      const { data: inscripciones, error: insErr } = await supabase
        .from('inscripciones')
        .select('id, dorsal, categoria, binomio:binomio_id(nombre_jinete, nombre_caballo)')
        .eq('concurso_id', concursoId)
        .order('dorsal');

      if (insErr) throw insErr;

      const disponibles: InscripcionDisponible[] = (inscripciones || [])
        .filter((i: any) => !idsOcupados.has(i.id))
        .map((i: any) => ({
          id: i.id,
          dorsal: i.dorsal,
          jinete: i.binomio?.nombre_jinete || '-',
          caballo: i.binomio?.nombre_caballo || '-',
          categoria: i.categoria || null,
        }));

      setInscripcionesDisponibles(disponibles);
      setInscripcionSeleccionada('');
      setModalMiembroAbierto(equipoId);
    } catch (err: any) {
      setError(err.message);
    }
  };

  const handleAñadirMiembro = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!modalMiembroAbierto || !inscripcionSeleccionada) {
      setError('Selecciona una inscripcion');
      return;
    }
    setGuardandoMiembro(true);
    setError('');
    try {
      const { error: dbErr } = await supabase.from('equipo_miembros').insert({
        equipo_id: modalMiembroAbierto,
        inscripcion_id: inscripcionSeleccionada,
        orden: (miembrosPorEquipo[modalMiembroAbierto]?.length || 0) + 1,
      });
      if (dbErr) throw dbErr;

      setModalMiembroAbierto(null);
      setInscripcionSeleccionada('');
      await cargarTodo();
    } catch (err: any) {
      setError(err.message);
    } finally {
      setGuardandoMiembro(false);
    }
  };

  const quitarMiembro = async (miembroId: string) => {
    if (!confirm('Quitar este miembro del equipo?')) return;
    try {
      const { error: dbErr } = await supabase.from('equipo_miembros').delete().eq('id', miembroId);
      if (dbErr) throw dbErr;
      await cargarTodo();
    } catch (err: any) {
      setError(err.message);
    }
  };

  const categoriaNombre = (catId: string | null) => {
    if (!catId) return '-';
    const cat = categorias.find((c) => c.id === catId);
    return cat?.nombre || '-';
  };

  return (
    <div className="card p-6 max-w-4xl mb-8">
      <div className="flex items-center justify-between mb-4">
        <div>
          <h2 className="text-xl font-bold">Equipos del Concurso</h2>
          <p className="text-sm text-gray-600 mt-1">
            Crea equipos y asignales binomios. Se usaran para la clasificacion por equipos en pruebas tipo Equipos.
          </p>
        </div>
        <button
          onClick={() => setModalEquipoAbierto(!modalEquipoAbierto)}
          className="btn btn-primary text-sm"
        >
          + Nuevo Equipo
        </button>
      </div>

      {error && <div className="mb-4 p-3 bg-danger text-white rounded text-sm">{error}</div>}

      {modalEquipoAbierto && (
        <div className="mb-6 p-4 border border-primary rounded bg-blue-50">
          <h3 className="font-bold mb-3">Nuevo Equipo</h3>
          <form onSubmit={handleCrearEquipo} className="space-y-3">
            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className="block text-xs font-bold mb-1">Nombre *</label>
                <input
                  type="text"
                  value={nuevoEquipo.nombre}
                  onChange={(e) => setNuevoEquipo({ ...nuevoEquipo, nombre: e.target.value })}
                  placeholder="Ej. Andalucia"
                  className="input w-full"
                  required
                />
              </div>
              <div>
                <label className="block text-xs font-bold mb-1">Club (opcional)</label>
                <input
                  type="text"
                  value={nuevoEquipo.club}
                  onChange={(e) => setNuevoEquipo({ ...nuevoEquipo, club: e.target.value })}
                  placeholder="Ej. RFHE Andalucia"
                  className="input w-full"
                />
              </div>
            </div>
            <div>
              <label className="block text-xs font-bold mb-1">Categoria edad (opcional)</label>
              <select
                value={nuevoEquipo.categoria_edad_id}
                onChange={(e) => setNuevoEquipo({ ...nuevoEquipo, categoria_edad_id: e.target.value })}
                className="input w-full"
              >
                <option value="">-- (opcional) --</option>
                {categorias.map((c) => (
                  <option key={c.id} value={c.id}>{c.nombre}</option>
                ))}
              </select>
            </div>
            <div className="flex justify-end gap-2 pt-2">
              <button
                type="button"
                onClick={() => setModalEquipoAbierto(false)}
                className="btn btn-outline text-sm"
                disabled={guardandoEquipo}
              >
                Cancelar
              </button>
              <button type="submit" className="btn btn-primary text-sm" disabled={guardandoEquipo}>
                {guardandoEquipo ? 'Guardando...' : 'Crear Equipo'}
              </button>
            </div>
          </form>
        </div>
      )}

      {loading ? (
        <p className="text-center text-gray-600 py-4">Cargando equipos...</p>
      ) : equipos.length === 0 ? (
        <p className="text-gray-600">
          No hay equipos creados. Pulsa "+ Nuevo Equipo" para empezar.
        </p>
      ) : (
        <div className="space-y-4">
          {equipos.map((eq) => (
            <div key={eq.id} className="border rounded p-4">
              <div className="flex items-start justify-between mb-3">
                <div>
                  <h3 className="text-lg font-bold">{eq.nombre}</h3>
                  <p className="text-sm text-gray-600">
                    {eq.club || 'Sin club'} · {categoriaNombre(eq.categoria_edad_id)} · {eq.num_miembros} miembros
                  </p>
                </div>
                <div className="flex gap-2">
                  <button
                    onClick={() => abrirModalMiembro(eq.id)}
                    className="btn btn-outline text-sm"
                  >
                    + Anadir miembro
                  </button>
                  <button
                    onClick={() => eliminarEquipo(eq.id, eq.nombre)}
                    className="text-danger text-sm hover:underline px-2"
                  >
                    Eliminar
                  </button>
                </div>
              </div>

              {miembrosPorEquipo[eq.id]?.length > 0 ? (
                <table className="table text-sm">
                  <thead>
                    <tr>
                      <th className="text-center w-16">Dorsal</th>
                      <th>Jinete</th>
                      <th>Caballo</th>
                      <th>Categoria</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    {miembrosPorEquipo[eq.id].map((m) => (
                      <tr key={m.id}>
                        <td className="text-center font-bold">{m.dorsal}</td>
                        <td>{m.jinete}</td>
                        <td>{m.caballo}</td>
                        <td className="text-sm text-gray-600">{m.categoria || '-'}</td>
                        <td className="text-right">
                          <button
                            onClick={() => quitarMiembro(m.id)}
                            className="text-danger text-sm hover:underline"
                          >
                            Quitar
                          </button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              ) : (
                <p className="text-sm text-gray-500">Sin miembros todavia.</p>
              )}

              {modalMiembroAbierto === eq.id && (
                <div className="mt-3 p-3 bg-blue-50 border border-primary rounded">
                  <h4 className="font-bold text-sm mb-2">Anadir miembro a {eq.nombre}</h4>
                  {inscripcionesDisponibles.length === 0 ? (
                    <p className="text-sm text-gray-600">
                      No hay inscripciones disponibles (o todas ya estan en algun equipo).
                    </p>
                  ) : (
                    <form onSubmit={handleAñadirMiembro} className="flex gap-2">
                      <select
                        value={inscripcionSeleccionada}
                        onChange={(e) => setInscripcionSeleccionada(e.target.value)}
                        className="input flex-1"
                        required
                      >
                        <option value="">-- Elegir inscripcion --</option>
                        {inscripcionesDisponibles.map((i) => (
                          <option key={i.id} value={i.id}>
                            #{i.dorsal} - {i.jinete} / {i.caballo} {i.categoria ? `(${i.categoria})` : ''}
                          </option>
                        ))}
                      </select>
                      <button
                        type="submit"
                        className="btn btn-primary text-sm"
                        disabled={guardandoMiembro || !inscripcionSeleccionada}
                      >
                        {guardandoMiembro ? 'Anadiendo...' : 'Anadir'}
                      </button>
                      <button
                        type="button"
                        onClick={() => setModalMiembroAbierto(null)}
                        className="btn btn-outline text-sm"
                      >
                        Cancelar
                      </button>
                    </form>
                  )}
                </div>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  );
}