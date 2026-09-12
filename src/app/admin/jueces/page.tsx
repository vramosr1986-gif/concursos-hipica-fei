'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase';

type Juez = {
  id: string;
  nombre: string | null;
  email: string;
  created_at: string;
};

export default function JuecesPage() {
  const router = useRouter();

  const [jueces, setJueces] = useState<Juez[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const cargarJueces = async () => {
    setLoading(true);
    setError('');

    try {
      const { data, error: dbError } = await supabase
        .from('profiles')
        .select('id, nombre, email, created_at')
        .eq('rol', 'juez')
        .order('nombre');

      if (dbError) {
        throw dbError;
      }

      setJueces(data || []);
    } catch (err: any) {
      setError(err.message || 'Error al cargar los jueces');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    cargarJueces();
  }, []);

  return (
    <div className="container max-w-6xl py-8">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-3xl font-bold">Jueces</h1>
          <p className="text-gray-600 mt-1">
            Catalogo de jueces profesionales
          </p>
        </div>

        <button
          onClick={() => router.push('/admin/usuarios/nuevo?rol=juez')}
          className="btn btn-primary"
        >
          + Nuevo Juez
        </button>
      </div>

      {error && (
        <div className="mb-4 p-4 bg-red-100 border border-red-300 text-red-700 rounded">
          {error}
        </div>
      )}

      {loading ? (
        <div className="card p-6 text-center">Cargando jueces...</div>
      ) : jueces.length === 0 ? (
        <div className="card p-8 text-center">
          <h2 className="text-xl font-semibold mb-2">
            No hay jueces registrados
          </h2>
          <p className="text-gray-600 mb-4">
            Anade el primer juez al catalogo.
          </p>

          <button
            onClick={() => router.push('/admin/usuarios/nuevo?rol=juez')}
            className="btn btn-primary"
          >
            + Registrar primer juez
          </button>
        </div>
      ) : (
        <div className="card overflow-hidden">
          <div className="p-4 border-b bg-gray-50">
            <strong>{jueces.length}</strong>{' '}
            {jueces.length === 1 ? 'juez registrado' : 'jueces registrados'}
          </div>

          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b">
                  <th className="text-left p-4">Nombre</th>
                  <th className="text-left p-4">Email</th>
                  <th className="text-right p-4">Acciones</th>
                </tr>
              </thead>

              <tbody>
                {jueces.map((juez) => (
                  <tr key={juez.id} className="border-b hover:bg-gray-50">
                    <td className="p-4 font-medium">
                      {juez.nombre || '-'}
                    </td>
                    <td className="p-4">{juez.email}</td>
                    <td className="p-4 text-right">
                      <button
                        onClick={() => router.push('/admin/usuarios')}
                        className="btn btn-outline"
                      >
                        Gestionar
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}
