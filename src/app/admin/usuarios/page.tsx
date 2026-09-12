'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

type Usuario = {
  id: string;
  email: string;
  nombre: string | null;
  rol: 'admin' | 'juez';
  created_at: string;
};

export default function UsuariosPage() {
  const router = useRouter();

  const [usuarios, setUsuarios] = useState<Usuario[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [miId, setMiId] = useState<string | null>(null);

  const cargarUsuarios = async () => {
    setLoading(true);
    setError('');

    try {
      const { data: { session } } = await supabase.auth.getSession();

      if (!session?.access_token) {
        router.push('/login');
        return;
      }

      setMiId(session.user.id);

      const response = await fetch('/api/admin/usuarios', {
        headers: {
          Authorization: `Bearer ${session.access_token}`,
        },
      });

      const result = await response.json();

      if (!response.ok) {
        throw new Error(result.error || 'Error al cargar usuarios.');
      }

      setUsuarios(result.usuarios || []);
    } catch (err: any) {
      setError(err.message || 'Error al cargar usuarios.');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    cargarUsuarios();
  }, []);

  const eliminarUsuario = async (id: string, email: string) => {
    const confirmar = window.confirm(
      `Seguro que quieres eliminar a ${email}? Esta accion no se puede deshacer.`
    );

    if (!confirmar) return;

    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session?.access_token) throw new Error('Sesion no valida.');

      const response = await fetch(`/api/admin/usuarios/${id}`, {
        method: 'DELETE',
        headers: {
          Authorization: `Bearer ${session.access_token}`,
        },
      });

      const result = await response.json();

      if (!response.ok) {
        throw new Error(result.error || 'Error al eliminar.');
      }

      setUsuarios((actuales) => actuales.filter((u) => u.id !== id));
    } catch (err: any) {
      alert(err.message || 'Error al eliminar el usuario.');
    }
  };

  const cambiarRol = async (id: string, nuevoRol: 'admin' | 'juez') => {
    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session?.access_token) throw new Error('Sesion no valida.');

      const response = await fetch(`/api/admin/usuarios/${id}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.access_token}`,
        },
        body: JSON.stringify({ rol: nuevoRol }),
      });

      const result = await response.json();

      if (!response.ok) {
        throw new Error(result.error || 'Error al cambiar rol.');
      }

      setUsuarios((actuales) =>
        actuales.map((u) => (u.id === id ? { ...u, rol: nuevoRol } : u))
      );
    } catch (err: any) {
      alert(err.message || 'Error al cambiar el rol.');
    }
  };

  return (
    <div className="container max-w-6xl py-8">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-3xl font-bold">Usuarios</h1>
          <p className="text-gray-600 mt-1">
            Gestion de accesos a la plataforma
          </p>
        </div>

        <Link href="/admin/usuarios/nuevo" className="btn btn-primary">
          + Nuevo Usuario
        </Link>
      </div>

      {error && (
        <div className="mb-4 p-4 bg-red-100 border border-red-300 text-red-700 rounded">
          {error}
        </div>
      )}

      {loading ? (
        <div className="card p-6 text-center">Cargando usuarios...</div>
      ) : usuarios.length === 0 ? (
        <div className="card p-8 text-center">
          <h2 className="text-xl font-semibold mb-2">
            No hay usuarios registrados
          </h2>
          <Link href="/admin/usuarios/nuevo" className="btn btn-primary mt-4">
            + Crear primer usuario
          </Link>
        </div>
      ) : (
        <div className="card overflow-hidden">
          <div className="p-4 border-b bg-gray-50">
            <strong>{usuarios.length}</strong>{' '}
            {usuarios.length === 1 ? 'usuario' : 'usuarios'}
          </div>

          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b">
                  <th className="text-left p-4">Nombre</th>
                  <th className="text-left p-4">Email</th>
                  <th className="text-center p-4">Rol</th>
                  <th className="text-right p-4">Acciones</th>
                </tr>
              </thead>

              <tbody>
                {usuarios.map((usuario) => {
                  const esYoMismo = usuario.id === miId;

                  return (
                    <tr
                      key={usuario.id}
                      className="border-b hover:bg-gray-50"
                    >
                      <td className="p-4 font-medium">
                        {usuario.nombre || '-'}
                        {esYoMismo && (
                          <span className="ml-2 text-xs text-blue-600">
                            (tu)
                          </span>
                        )}
                      </td>

                      <td className="p-4">{usuario.email}</td>

                      <td className="p-4 text-center">
                        <select
                          value={usuario.rol}
                          onChange={(e) =>
                            cambiarRol(
                              usuario.id,
                              e.target.value as 'admin' | 'juez'
                            )
                          }
                          disabled={esYoMismo}
                          className="border rounded px-2 py-1 text-sm"
                        >
                          <option value="juez">Juez</option>
                          <option value="admin">Admin</option>
                        </select>
                      </td>

                      <td className="p-4 text-right">
                        <button
                          onClick={() => eliminarUsuario(usuario.id, usuario.email)}
                          disabled={esYoMismo}
                          className="btn btn-outline text-danger disabled:opacity-50 disabled:cursor-not-allowed"
                          title={
                            esYoMismo
                              ? 'No puedes eliminarte a ti mismo'
                              : 'Eliminar usuario'
                          }
                        >
                          Eliminar
                        </button>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}
