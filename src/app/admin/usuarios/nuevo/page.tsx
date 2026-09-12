'use client';

import { useState, Suspense } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

function NuevoUsuarioForm() {
  const router = useRouter();
  const searchParams = useSearchParams();

  const rolInicial = searchParams.get('rol') === 'admin' ? 'admin' : 'juez';

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [exito, setExito] = useState(false);

  const [formData, setFormData] = useState({
    email: '',
    nombre: '',
    password: '',
    role: rolInicial,
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');
    setExito(false);

    try {
      const { data: { session } } = await supabase.auth.getSession();

      if (!session?.access_token) {
        throw new Error('No hay una sesion de administrador activa.');
      }

      const response = await fetch('/api/admin/usuarios', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.access_token}`,
        },
        body: JSON.stringify({
          email: formData.email,
          password: formData.password,
          nombre: formData.nombre,
          role: formData.role,
        }),
      });

      const result = await response.json();

      if (!response.ok) {
        throw new Error(result.error || 'No se pudo crear el usuario.');
      }

      setExito(true);

      setTimeout(() => {
        router.push('/admin/usuarios');
        router.refresh();
      }, 1500);
    } catch (err: any) {
      setError(err.message || 'Error al crear usuario.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container py-8">
      <div className="max-w-2xl mx-auto">
        <Link
          href="/admin/usuarios"
          className="text-primary hover:underline mb-4 inline-block"
        >
          Volver a Usuarios
        </Link>

        <div className="card p-8">
          <h1 className="text-2xl font-bold mb-2">
            Crear Nuevo Usuario de Acceso
          </h1>
          <p className="text-gray-600 mb-6 text-sm">
            Cree una cuenta para permitir el inicio de sesion en la plataforma.
          </p>

          {error && (
            <div className="mb-6 p-4 bg-red-100 border border-red-300 text-red-700 rounded">
              {error}
            </div>
          )}

          {exito && (
            <div className="mb-6 p-4 bg-green-100 border border-green-300 text-green-800 rounded flex items-center gap-3">
              <span className="text-2xl">✓</span>
              <div>
                <strong className="block">Usuario creado exitosamente</strong>
                <span className="text-sm">Redirigiendo al listado...</span>
              </div>
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-sm font-medium mb-1">
                Nombre Completo
              </label>
              <input
                type="text"
                required
                className="w-full p-2 border rounded"
                placeholder="Ej. Juan Perez"
                value={formData.nombre}
                onChange={(e) =>
                  setFormData({ ...formData, nombre: e.target.value })
                }
              />
            </div>

            <div>
              <label className="block text-sm font-medium mb-1">Email</label>
              <input
                type="email"
                required
                className="w-full p-2 border rounded"
                placeholder="email@ejemplo.com"
                value={formData.email}
                onChange={(e) =>
                  setFormData({ ...formData, email: e.target.value })
                }
              />
            </div>

            <div>
              <label className="block text-sm font-medium mb-1">
                Contrasena
              </label>
              <input
                type="password"
                required
                minLength={6}
                className="w-full p-2 border rounded"
                placeholder="Minimo 6 caracteres"
                value={formData.password}
                onChange={(e) =>
                  setFormData({ ...formData, password: e.target.value })
                }
              />
              <p className="text-xs text-gray-500 mt-1">
                El usuario utilizara esta contrasena para iniciar sesion.
              </p>
            </div>

            <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
              <label className="block text-sm font-bold mb-2">
                Rol de Permisos del Sistema
              </label>

              <div className="flex flex-col gap-3">
                <label className="flex items-center gap-2 cursor-pointer">
                  <input
                    type="radio"
                    name="role"
                    value="juez"
                    checked={formData.role === 'juez'}
                    onChange={(e) =>
                      setFormData({ ...formData, role: e.target.value })
                    }
                    className="w-4 h-4"
                  />
                  <span className="text-sm">
                    Juez (Acceso completo excepto gestion de usuarios)
                  </span>
                </label>

                <label className="flex items-center gap-2 cursor-pointer">
                  <input
                    type="radio"
                    name="role"
                    value="admin"
                    checked={formData.role === 'admin'}
                    onChange={(e) =>
                      setFormData({ ...formData, role: e.target.value })
                    }
                    className="w-4 h-4"
                  />
                  <span className="text-sm">
                    Administrador (Acceso total)
                  </span>
                </label>
              </div>
            </div>

            <div className="flex justify-end gap-3 pt-6">
              <button
                type="button"
                onClick={() => router.back()}
                className="btn btn-outline"
                disabled={loading}
              >
                Cancelar
              </button>

              <button
                type="submit"
                disabled={loading || exito}
                className="btn btn-primary"
              >
                {exito
                  ? 'Creado ✓'
                  : loading
                  ? 'Creando...'
                  : 'Crear Cuenta de Usuario'}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}

export default function NuevoUsuarioPage() {
  return (
    <Suspense fallback={<div className="container py-8 text-center">Cargando...</div>}>
      <NuevoUsuarioForm />
    </Suspense>
  );
}
