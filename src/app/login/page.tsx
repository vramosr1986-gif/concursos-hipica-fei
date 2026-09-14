'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { Mail, Lock, LogIn } from 'lucide-react';
import { authService } from '@/lib/auth';

export default function LoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      const { error } = await authService.signin(email, password);
      if (error) {
        setError(error.message);
      } else {
        router.push('/');
      }
    } catch (err: any) {
      setError(err.message || 'Error al iniciar sesión');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container flex justify-center items-center min-h-[calc(100vh-8rem)]">
      <div className="card p-8 w-full max-w-md">
        <h1 className="text-3xl font-bold mb-6 text-center">Iniciar Sesión</h1>

        {error && (
          <div className="mb-4 p-4 bg-danger text-white rounded">{error}</div>
        )}

        <form onSubmit={handleLogin} className="space-y-4">
          <div>
            <label className="block text-sm font-bold mb-2">Email</label>
            <div className="relative">
              <Mail className="pointer-events-none absolute left-3.5 top-1/2 size-4 -translate-y-1/2 text-[#b88746]" aria-hidden="true" />
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="input pl-10"
                required
              />
            </div>
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">Contraseña</label>
            <div className="relative">
              <Lock className="pointer-events-none absolute left-3.5 top-1/2 size-4 -translate-y-1/2 text-[#b88746]" aria-hidden="true" />
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="input pl-10"
                required
              />
            </div>
          </div>

          <button
            type="submit"
            disabled={loading}
            className="w-full btn btn-primary disabled:opacity-50"
          >
            <LogIn className="mr-2 size-4" aria-hidden="true" />
            {loading ? 'Cargando...' : 'Iniciar Sesión'}
          </button>
        </form>

        <p className="text-center mt-4 text-sm text-gray-600">
          ¿No tienes cuenta? Contacta a un administrador para que te la cree.
        </p>
      </div>
    </div>
  );
}
