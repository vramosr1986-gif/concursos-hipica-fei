'use client';

import Link from 'next/link';
import { useEffect, useState } from 'react';
import {
  LayoutDashboard,
  CalendarDays,
  Gavel,
  ListChecks,
  Users,
  LogIn,
  LogOut,
  HelpCircle,
  Trophy,
} from 'lucide-react';
import { supabase } from '@/lib/supabase';
import { HorseIcon } from './icons';

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

    // Listener para cambios en la sesión
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
    'inline-flex items-center gap-1.5 rounded-full px-3 py-2 text-sm font-medium text-white/75 transition hover:bg-white/10 hover:text-white';

  const esAdmin = role === 'admin';
  const esJuez = role === 'juez';

  return (
    <nav className="sticky top-0 z-20 border-b border-white/10 bg-[#112d24]/95 text-white shadow-lg backdrop-blur">
      <div className="mx-auto flex min-h-[4.5rem] max-w-7xl items-center justify-between gap-5 px-5 sm:px-8 lg:px-10">
        <Link href="/" className="group flex items-center gap-3">
          <span className="flex size-9 items-center justify-center rounded-full border border-[#e8c98d]/60 bg-white/5 text-[#e8c98d] transition group-hover:bg-white/10">
            <HorseIcon size={20} />
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
                    <LayoutDashboard className="size-4" aria-hidden="true" /> Panel
                  </Link>
                  <Link href="/admin/concursos" className={navLink}>
                    <CalendarDays className="size-4" aria-hidden="true" /> Concursos
                  </Link>
                  <Link href="/admin/jueces" className={navLink}>
                    <Gavel className="size-4" aria-hidden="true" /> Jueces
                  </Link>
                  <Link href="/admin/binomios" className={navLink}>
                    <HorseIcon size={15} className="shrink-0" /> Binomios
                  </Link>
                  <Link href="/admin/reprises" className={navLink}>
                    <ListChecks className="size-4" aria-hidden="true" /> Reprises
                  </Link>
                  <Link href="/admin/usuarios" className={navLink}>
                    <Users className="size-4" aria-hidden="true" /> Usuarios
                  </Link>
                </>
              )}

              {/* JUEZ: solo su panel */}
              {esJuez && (
                <>
                  <Link href="/juez" className={navLink}>
                    <LayoutDashboard className="size-4" aria-hidden="true" /> Mi Panel
                  </Link>
                </>
              )}

              <Link href="/resultados" className={navLink}>
                <Trophy className="size-4" aria-hidden="true" /> Resultados
              </Link>

              <Link href="/ayuda" className={navLink}>
                <HelpCircle className="size-4" aria-hidden="true" /> Ayuda
              </Link><button
                onClick={handleLogout}
                className="ml-1 inline-flex items-center gap-1.5 rounded-full border border-white/20 px-3 py-2 text-sm font-semibold text-white transition hover:border-[#e8c98d] hover:bg-white/10"
              >
                <LogOut className="size-4" aria-hidden="true" /> Salir
              </button>
            </>
          ) : !loading ? (
            <>
              <Link
                href="/resultados"
                className="hidden items-center gap-1.5 rounded-full px-3 py-2 text-sm font-medium text-white/75 transition hover:bg-white/10 hover:text-white sm:inline-flex"
              >
                <Trophy className="size-4" aria-hidden="true" /> Resultados
              </Link>
              <Link
                href="/login"
                className="inline-flex items-center gap-1.5 rounded-full bg-[#b88746] px-4 py-2 text-sm font-semibold text-white shadow-sm transition hover:-translate-y-0.5 hover:bg-[#d09d54]"
              >
                <LogIn className="size-4" aria-hidden="true" /> Acceder
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