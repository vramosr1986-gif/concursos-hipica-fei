'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { Loader2 } from 'lucide-react';
import { supabase } from '@/lib/supabase';

export default function JuezLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const router = useRouter();
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

      if (rol === 'admin') {
        setEstado('ok');
        return;
      }

      if (rol !== 'juez') {
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
        <div className="card w-full max-w-md p-10 text-center">
          <span className="mx-auto flex size-14 items-center justify-center rounded-full border border-[#e8d4a8] bg-[#f7f1e3] text-2xl">
            🔒
          </span>
          <h1 className="mt-5 font-serif text-2xl font-semibold text-[#173b2f]">
            Acceso restringido
          </h1>
          <p className="mt-2 text-sm leading-6 text-[#607168]">
            Este panel está reservado a jueces y administradores.
          </p>
        </div>
      </div>
    );
  }

  return <>{children}</>;
}