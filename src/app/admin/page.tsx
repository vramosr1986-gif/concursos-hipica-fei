'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

export default function AdminIndexPage() {
  const router = useRouter();
  const [autorizado, setAutorizado] = useState<boolean | null>(null);

  useEffect(() => {
    const verificarAcceso = async () => {
      const {
        data: { user },
      } = await supabase.auth.getUser();

      if (!user) {
        router.push('/login');
        return;
      }

      const { data: perfil } = await supabase
        .from('profiles')
        .select('rol')
        .eq('id', user.id)
        .single();

      const r = perfil?.rol || null;

      // Si es juez, redirigir a su panel
      if (r === 'juez') {
        router.push('/juez');
        return;
      }

      // Solo admin puede entrar aquí
      setAutorizado(r === 'admin');
    };

    verificarAcceso();
  }, [router]);

  if (autorizado === null) {
    return <div className="container py-8 text-center">Cargando...</div>;
  }

  if (!autorizado) {
    return (
      <div className="container py-8">
        <div className="card p-8 text-center">
          <p className="text-danger font-bold">
            Acceso restringido a administradores.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="container py-8">
      <h1 className="text-3xl font-bold mb-6">Panel de Administracion</h1>

      <div className="grid md:grid-cols-3 gap-6">
        <Link
          href="/admin/concursos"
          className="card p-8 hover:shadow-lg transition"
        >
          <h2 className="text-xl font-bold mb-2">Concursos</h2>
          <p className="text-gray-600">
            Crear, editar y gestionar concursos, pruebas y binomios.
          </p>
        </Link>

        <Link
          href="/admin/jueces"
          className="card p-8 hover:shadow-lg transition"
        >
          <h2 className="text-xl font-bold mb-2">Jueces</h2>
          <p className="text-gray-600">
            Catalogo de jueces profesionales.
          </p>
        </Link>

        <Link
          href="/admin/binomios"
          className="card p-8 hover:shadow-lg transition"
        >
          <h2 className="text-xl font-bold mb-2">Binomios</h2>
          <p className="text-gray-600">
            Catalogo de jinetes y caballos.
          </p>
        </Link>

        <Link
          href="/admin/reprises"
          className="card p-8 hover:shadow-lg transition"
        >
          <h2 className="text-xl font-bold mb-2">Reprises</h2>
          <p className="text-gray-600">
            Catalogo de reprises FEI y sus ejercicios.
          </p>
        </Link>

        <Link
          href="/admin/usuarios"
          className="card p-8 hover:shadow-lg transition"
        >
          <h2 className="text-xl font-bold mb-2">Usuarios</h2>
          <p className="text-gray-600">
            Crear y gestionar cuentas de jueces y administradores.
          </p>
        </Link>
      </div>
    </div>
  );
}