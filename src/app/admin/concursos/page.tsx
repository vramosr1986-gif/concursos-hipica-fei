'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { Concurso } from '@/types';
import { concursoService } from '@/lib/services';

export default function AdminConcursosPage() {
  const [concursos, setConcursos] = useState<Concurso[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchConcursos = async () => {
      const { data, error } = await concursoService.getAll();
      if (!error && data) {
        setConcursos(data);
      }
      setLoading(false);
    };

    fetchConcursos();
  }, []);

  const handleDelete = async (id: string) => {
    if (confirm('¿Estás seguro de que deseas eliminar este concurso?')) {
      await concursoService.delete(id);
      setConcursos(concursos.filter((c) => c.id !== id));
    }
  };

  return (
    <div className="container">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-3xl font-bold">⚙️ Gestión de Concursos</h1>
        <Link href="/admin/concursos/nuevo" className="btn btn-primary">
          + Nuevo Concurso
        </Link>
      </div>

      {loading ? (
        <div className="text-center py-8">Cargando concursos...</div>
      ) : concursos.length > 0 ? (
        <div className="grid md:grid-cols-3 gap-6">
          {concursos.map((concurso) => (
            <div key={concurso.id} className="card p-6">
              <h3 className="text-xl font-bold mb-2">{concurso.nombre}</h3>
              <p className="text-gray-600 text-sm mb-4">
                {concurso.ubicacion}
              </p>
              <div className="flex gap-2">
                <Link
                  href={`/admin/concursos/${concurso.id}`}
                  className="flex-1 btn btn-secondary text-center"
                >
                  Editar
                </Link>
                <button
                  onClick={() => handleDelete(concurso.id)}
                  className="btn btn-danger px-4"
                >
                  Eliminar
                </button>
              </div>
            </div>
          ))}
        </div>
      ) : (
        <div className="card p-8 text-center">
          <p className="text-gray-600 mb-4">No hay concursos creados</p>
          <Link href="/admin/concursos/nuevo" className="btn btn-primary">
            Crear Primer Concurso
          </Link>
        </div>
      )}
    </div>
  );
}
