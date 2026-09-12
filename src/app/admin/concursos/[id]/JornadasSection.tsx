'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

type Jornada = {
  id: string;
  concurso_id: string;
  fecha: string;
  numero: number;
  pista: string;
  hora_inicio: string;
  hora_fin: string | null;
  num_reprises?: number;
};

type NuevaJornadaForm = {
  fecha: string;
  pista: string;
  hora_inicio: string;
  hora_fin: string;
};

interface Props {
  concursoId: string;
  fechaInicio: string;
  fechaFin: string;
}

export function JornadasSection({ concursoId, fechaInicio, fechaFin }: Props) {
  const [jornadas, setJornadas] = useState<Jornada[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [guardando, setGuardando] = useState(false);
  const [modalAbierto, setModalAbierto] = useState(false);

  const [nuevaJornada, setNuevaJornada] = useState<NuevaJornadaForm>({
    fecha: fechaInicio || '',
    pista: '',
    hora_inicio: '09:00',
    hora_fin: '',
  });

  const cargarJornadas = async () => {
    setLoading(true);
    setError('');

    try {
      const { data, error: dbError } = await supabase
        .from('jornadas')
        .select('*')
        .eq('concurso_id', concursoId)
        .order('numero', { ascending: true });

      if (dbError) throw dbError;

      // Contar reprises por jornada
      const jornadasConContador = [];
      for (const j of data || []) {
        const { count } = await supabase
          .from('jornada_reprises')
          .select('id', { count: 'exact', head: true })
          .eq('jornada_id', j.id);

        jornadasConContador.push({ ...j, num_reprises: count || 0 });
      }

      setJornadas(jornadasConContador);
    } catch (err: any) {
      setError(err.message || 'Error al cargar las jornadas');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    cargarJornadas();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [concursoId]);

  const handleAddJornada = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    // Validar fecha dentro del rango
    if (nuevaJornada.fecha < fechaInicio || nuevaJornada.fecha > fechaFin) {
      setError(
        `La fecha debe estar entre ${fechaInicio} y ${fechaFin}`
      );
      return;
    }

    if (!nuevaJornada.pista.trim()) {
      setError('La pista es obligatoria');
      return;
    }

    setGuardando(true);
    try {
      const nuevoNumero =
        jornadas.length > 0
          ? Math.max(...jornadas.map((j) => j.numero)) + 1
          : 1;

      const { data, error: dbError } = await supabase
        .from('jornadas')
        .insert({
          concurso_id: concursoId,
          fecha: nuevaJornada.fecha,
          numero: nuevoNumero,
          pista: nuevaJornada.pista.trim(),
          hora_inicio: nuevaJornada.hora_inicio,
          hora_fin: nuevaJornada.hora_fin || null,
        })
        .select()
        .single();

      if (dbError) throw dbError;

      setJornadas([...jornadas, { ...data, num_reprises: 0 }]);
      setModalAbierto(false);
      setNuevaJornada({
        fecha: fechaInicio || '',
        pista: '',
        hora_inicio: '09:00',
        hora_fin: '',
      });
    } catch (err: any) {
      setError(err.message || 'Error al crear la jornada');
    } finally {
      setGuardando(false);
    }
  };

  const eliminarJornada = async (id: string, numero: number) => {
    if (
      !confirm(
        `¿Eliminar la jornada ${numero}? Se eliminarán también sus reprises y competencias.`
      )
    )
      return;

    try {
      const { error: dbError } = await supabase
        .from('jornadas')
        .delete()
        .eq('id', id);

      if (dbError) throw dbError;

      setJornadas((actuales) => actuales.filter((j) => j.id !== id));
    } catch (err: any) {
      alert(err.message || 'Error al eliminar la jornada');
    }
  };

  const formatearFecha = (fecha: string) => {
    if (!fecha) return '-';
    const [y, m, d] = fecha.split('-');
    return `${d}/${m}/${y}`;
  };

  return (
    <div className="card p-6 max-w-2xl mb-8">
      <div className="flex items-center justify-between mb-4">
        <h2 className="text-xl font-bold">Jornadas del Concurso</h2>
        <button
          onClick={() => setModalAbierto(!modalAbierto)}
          className="btn btn-primary text-sm"
        >
          + Añadir Jornada
        </button>
      </div>

      {error && (
        <div className="mb-4 p-3 bg-danger text-white rounded text-sm">
          {error}
        </div>
      )}

      {/* Formulario nueva jornada */}
      {modalAbierto && (
        <div className="mb-6 p-4 border border-primary rounded bg-blue-50">
          <h3 className="font-bold mb-3">Nueva Jornada</h3>
          <form onSubmit={handleAddJornada} className="space-y-3">
            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className="block text-xs font-bold mb-1">Fecha *</label>
                <input
                  type="date"
                  value={nuevaJornada.fecha}
                  onChange={(e) =>
                    setNuevaJornada({ ...nuevaJornada, fecha: e.target.value })
                  }
                  min={fechaInicio}
                  max={fechaFin}
                  className="input w-full"
                  required
                />
                <p className="text-xs text-gray-500 mt-1">
                  Entre {formatearFecha(fechaInicio)} y {formatearFecha(fechaFin)}
                </p>
              </div>

              <div>
                <label className="block text-xs font-bold mb-1">Pista *</label>
                <input
                  type="text"
                  value={nuevaJornada.pista}
                  onChange={(e) =>
                    setNuevaJornada({ ...nuevaJornada, pista: e.target.value })
                  }
                  placeholder="Ej. Pista A"
                  className="input w-full"
                  required
                />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className="block text-xs font-bold mb-1">
                  Hora Inicio *
                </label>
                <input
                  type="time"
                  value={nuevaJornada.hora_inicio}
                  onChange={(e) =>
                    setNuevaJornada({
                      ...nuevaJornada,
                      hora_inicio: e.target.value,
                    })
                  }
                  className="input w-full"
                  required
                />
              </div>

              <div>
                <label className="block text-xs font-bold mb-1">
                  Hora Fin
                </label>
                <input
                  type="time"
                  value={nuevaJornada.hora_fin}
                  onChange={(e) =>
                    setNuevaJornada({
                      ...nuevaJornada,
                      hora_fin: e.target.value,
                    })
                  }
                  className="input w-full"
                />
              </div>
            </div>

            <div className="flex justify-end gap-2 pt-2">
              <button
                type="button"
                onClick={() => setModalAbierto(false)}
                className="btn btn-outline text-sm"
                disabled={guardando}
              >
                Cancelar
              </button>
              <button
                type="submit"
                className="btn btn-primary text-sm"
                disabled={guardando}
              >
                {guardando ? 'Guardando...' : 'Guardar Jornada'}
              </button>
            </div>
          </form>
        </div>
      )}

      {/* Listado de jornadas */}
      {loading ? (
        <p className="text-center text-gray-600 py-4">Cargando jornadas...</p>
      ) : jornadas.length === 0 ? (
        <p className="text-gray-600">
          No hay jornadas creadas. Pulsa "+ Añadir Jornada" para empezar.
        </p>
      ) : (
        <div className="table-responsive">
          <table className="table">
            <thead>
              <tr>
                <th>Nº</th>
                <th>Fecha</th>
                <th>Pista</th>
                <th>Horario</th>
                <th className="text-center">Reprises</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {jornadas.map((j) => (
                <tr key={j.id}>
                  <td className="font-bold">{j.numero}</td>
                  <td>{formatearFecha(j.fecha)}</td>
                  <td>{j.pista}</td>
                  <td className="text-sm text-gray-600">
                    {j.hora_inicio.substring(0, 5)}
                    {j.hora_fin ? ` - ${j.hora_fin.substring(0, 5)}` : ''}
                  </td>
                  <td className="text-center">
                    <span className="px-2 py-1 rounded text-xs bg-blue-100 text-blue-800 font-medium">
                      {j.num_reprises || 0}
                    </span>
                  </td>
                  <td className="text-right">
                    <div className="flex gap-2 justify-end">
                      <Link
                        href={`/admin/concursos/${concursoId}/jornadas/${j.id}`}
                        className="text-primary hover:underline text-sm font-medium"
                      >
                        Gestionar →
                      </Link>
                      <button
                        onClick={() => eliminarJornada(j.id, j.numero)}
                        className="text-danger hover:underline text-sm"
                      >
                        Eliminar
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}