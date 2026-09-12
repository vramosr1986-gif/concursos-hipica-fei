'use client';

import Link from 'next/link';
import { useEffect, useState } from 'react';
import { supabase } from '@/lib/supabase';

export function Navbar() {
  const [user, setUser] = useState<any>(null);
  const [role, setRole] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const getUser = async () => {
      const {
        data: { user },
      } = await supabase.auth.getUser();
      setUser(user);

      if (user) {
        const { data } = await supabase
          .from('profiles')
          .select('rol')
          .eq('id', user.id)
          .single();
        setRole(data?.rol || 'public');
      }
      setLoading(false);
    };

    getUser();

    // Listener para cambios en la sesiÃ³n
    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange(async (_event, session) => {
      if (session?.user) {
        setUser(session.user);
        const { data } = await supabase
          .from('profiles')
          .select('rol')
          .eq('id', session.user.id)
          .single();
        setRole(data?.rol || 'public');
      } else {
        setUser(null);
        setRole(null);
      }
    });

    return () => {
      subscription.unsubscribe();
    };
  }, []);

  const handleLogout = async () => {
    await supabase.auth.signOut();
    setUser(null);
    setRole(null);
    window.location.href = '/';
  };

  const navLink =
    'rounded-full px-3 py-2 text-sm font-medium text-white/75 transition hover:bg-white/10 hover:text-white';

  const esAdmin = role === 'admin';
  const esJuez = role === 'juez';

  return (
    <nav className="sticky top-0 z-20 border-b border-white/10 bg-[#112d24]/95 text-white shadow-lg backdrop-blur">
      <div className="mx-auto flex min-h-[4.5rem] max-w-7xl items-center justify-between gap-5 px-5 sm:px-8 lg:px-10">
        <Link href="/" className="group flex items-center gap-3">
          <span className="flex size-9 items-center justify-center rounded-full border border-[#e8c98d]/60 bg-white/5 text-lg transition group-hover:bg-white/10">
            C
          </span>
          <span>
            <span className="block font-serif text-lg leading-none tracking-tight text-white">
              Concursos FEI
            </span>
            <span className="mt-1 block text-[10px] font-semibold uppercase tracking-[0.18em] text-[#e8c98d]">
              Doma clasica
            </span>
          </span>
        </Link>

        <div className="flex items-center gap-1 sm:gap-2">
          {!loading && user ? (
            <>
              <span className="hidden text-right text-xs text-white/65 md:block">
                <span className="block max-w-40 truncate">{user.email}</span>
                <span className="inline-block rounded-full bg-[#b88746]/20 px-2 py-0.5 capitalize text-[#f3d9aa]">
                  {role}
                </span>
              </span>

              {/* ADMIN: todos los enlaces */}
              {esAdmin && (
                <>
                  <Link href="/admin" className={navLink}>
                    Panel
                  </Link>
                  <Link href="/admin/concursos" className={navLink}>
                    Concursos
                  </Link>
                  <Link href="/admin/jueces" className={navLink}>
                    Jueces
                  </Link>
                  <Link href="/admin/binomios" className={navLink}>
                    Binomios
                  </Link>
                  <Link href="/admin/reprises" className={navLink}>
                    Reprises
                  </Link>
                  <Link href="/admin/usuarios" className={navLink}>
                    Usuarios
                  </Link>
                </>
              )}

              {/* JUEZ: solo su panel */}
              {esJuez && (
                <>
                  <Link href="/juez" className={navLink}>
                    Mi Panel
                  </Link>
                </>
              )}

              <Link href="/resultados" className={navLink}>
                Resultados
              </Link>

              <button
                onClick={handleLogout}
                className="ml-1 rounded-full border border-white/20 px-3 py-2 text-sm font-semibold text-white transition hover:border-[#e8c98d] hover:bg-white/10"
              >
                Salir
              </button>
            </>
          ) : !loading ? (
            <>
              <Link
                href="/resultados"
                className="hidden rounded-full px-3 py-2 text-sm font-medium text-white/75 transition hover:bg-white/10 hover:text-white sm:inline-flex"
              >
                Resultados
              </Link>
              <Link
                href="/login"
                className="rounded-full bg-[#b88746] px-4 py-2 text-sm font-semibold text-white shadow-sm transition hover:-translate-y-0.5 hover:bg-[#d09d54]"
              >
                Acceder
              </Link>
            </>
          ) : (
            <span className="text-xs text-white/55">Cargando...</span>
          )}
        </div>
      </div>
    </nav>
  );
}