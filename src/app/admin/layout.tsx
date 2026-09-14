'use client';

import { useEffect, useState } from 'react';
import { useRouter, usePathname } from 'next/navigation';
import Link from 'next/link';
import { ArrowLeft, LayoutDashboard, Loader2 } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import './admin-modern.css';

const SECCIONES: Record<string, string> = {
  '/admin': 'Resumen',
  '/admin/concursos': 'Gestión de Concursos',
  '/admin/concursos/nuevo': 'Nuevo Concurso',
  '/admin/jueces': 'Jueces',
  '/admin/jueces/nuevo': 'Nuevo Juez',
  '/admin/binomios': 'Binomios',
  '/admin/binomios/nuevo': 'Nuevo Binomio',
  '/admin/reprises': 'Reprises',
  '/admin/usuarios': 'Usuarios',
  '/admin/usuarios/nuevo': 'Nuevo Usuario',
};

function tituloSeccion(pathname: string): string {
  if (pathname.startsWith('/admin/concursos/')) return 'Gestión del Concurso';
  if (pathname.startsWith('/admin/binomios/')) return 'Detalle del Binomio';
  if (pathname.startsWith('/admin/reprises/')) return 'Detalle de la Reprise';
  if (pathname.startsWith('/admin/jueces/')) return 'Detalle del Juez';
  return SECCIONES[pathname] || 'Administración';
}

export default function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const router = useRouter();
  const pathname = usePathname();
  const [estado, setEstado] = useState<'cargando' | 'ok' | 'denegado'>('cargando');

  useEffect(() => {
    const verificar = async () => {
      const {
        data: { user },
      } = await supabase.auth.getUser();

      if (!user) {
        router.replace('/login');
        return;
      }

      const { data: perfil } = await supabase
        .from('profiles')
        .select('rol')
        .eq('id', user.id)
        .single();

      const rol = perfil?.rol || null;

      if (rol === 'juez') {
        router.replace('/juez');
        return;
      }

      if (rol !== 'admin') {
        setEstado('denegado');
        return;
      }

      setEstado('ok');
    };

    verificar();
  }, [router]);

  if (estado === 'cargando') {
    return (
      <div className="flex min-h-[70vh] items-center justify-center">
        <div className="flex flex-col items-center gap-3 text-[#466257]">
          <Loader2 className="size-8 animate-spin text-[#b88746]" />
          <p className="text-sm font-medium">Comprobando acceso...</p>
        </div>
      </div>
    );
  }

  if (estado === 'denegado') {
    return (
      <div className="flex min-h-[70vh] items-center justify-center px-6">
        <div className="card w-full max-w-md border-[#e4dfd4] p-10 text-center">
          <span className="mx-auto flex size-14 items-center justify-center rounded-full border border-[#e8d4a8] bg-[#f7f1e3] text-2xl">
            🔒
          </span>
          <h1 className="mt-5 font-serif text-2xl font-semibold text-[#173b2f]">
            Acceso restringido
          </h1>
          <p className="mt-2 text-sm leading-6 text-[#607168]">
            Este panel está reservado a usuarios administradores.
          </p>
          <Link href="/" className="btn btn-primary mt-7">
            Volver al inicio
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="admin-page-container">
      <div className="mx-auto max-w-7xl" style={{ fontFamily: 'inherit' }}>
        <div className="mb-8">
          <Link
            href="/"
            className="inline-flex items-center gap-1.5 text-xs font-semibold text-[#607168] transition hover:text-[#173b2f]"
          >
            <ArrowLeft className="size-3.5" aria-hidden="true" />
            Volver a la web
          </Link>

          <div className="mt-3 flex items-center gap-4">
            <span className="flex size-12 shrink-0 items-center justify-center rounded-2xl border border-[#e4dfd4] bg-[#fffdfa] text-[#b88746] shadow-card">
              <LayoutDashboard className="size-5" aria-hidden="true" />
            </span>
            <div>
              <p className="text-[10px] font-bold uppercase tracking-[0.22em] text-[#b88746]">
                Panel de administración
              </p>
              <h1 className="mt-0.5 font-serif text-2xl font-semibold leading-tight text-[#173b2f] sm:text-3xl">
                {tituloSeccion(pathname)}
              </h1>
            </div>
          </div>
        </div>

        {children}
      </div>
    </div>
  );
}