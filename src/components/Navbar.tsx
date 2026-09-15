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
  BarChart3,
  Menu,
  X,
} from 'lucide-react';
import { supabase } from '@/lib/supabase';
import { HorseIcon } from './icons';

export function Navbar() {
  const [user, setUser] = useState<any>(null);
  const [role, setRole] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [menuOpen, setMenuOpen] = useState(false);

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

  const mobileLink =
    'flex items-center gap-2.5 rounded-lg px-3 py-2.5 text-sm font-medium text-white/85 transition hover:bg-white/10 hover:text-white';

  const esAdmin = role === 'admin';
  const esJuez = role === 'juez';

  const cerrarMenu = () => setMenuOpen(false);

  const enlacesSesion = esAdmin
    ? [
        { href: '/admin', label: 'Panel', Icon: LayoutDashboard },
        { href: '/admin/concursos', label: 'Concursos', Icon: CalendarDays },
        { href: '/admin/jueces', label: 'Jueces', Icon: Gavel },
        { href: '/admin/binomios', label: 'Binomios', Icon: HorseIcon },
        { href: '/admin/reprises', label: 'Reprises', Icon: ListChecks },
        { href: '/admin/usuarios', label: 'Usuarios', Icon: Users },
      ]
    : esJuez
      ? [{ href: '/juez', label: 'Mi Panel', Icon: LayoutDashboard }]
      : [];

  return (
    <nav className="sticky top-0 z-20 border-b border-white/10 bg-[#112d24]/95 text-white shadow-lg backdrop-blur">
      <div className="mx-auto flex min-h-[4.5rem] max-w-7xl items-center justify-between gap-5 px-5 sm:px-8 lg:px-10">
        <Link href="/" className="group flex items-center gap-3" onClick={cerrarMenu}>
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

        {/* Enlaces de escritorio */}
        <div className="hidden items-center gap-1 sm:gap-2 lg:flex">
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

              <Link href="/estadisticas" className={navLink}>
                <BarChart3 className="size-4" aria-hidden="true" /> Estadisticas
              </Link>

              <Link href="/ayuda" className={navLink}>
                <HelpCircle className="size-4" aria-hidden="true" /> Ayuda
              </Link>
              <button
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
                className="inline-flex items-center gap-1.5 rounded-full px-3 py-2 text-sm font-medium text-white/75 transition hover:bg-white/10 hover:text-white"
              >
                <Trophy className="size-4" aria-hidden="true" /> Resultados
              </Link>
              <Link
                href="/estadisticas"
                className="inline-flex items-center gap-1.5 rounded-full px-3 py-2 text-sm font-medium text-white/75 transition hover:bg-white/10 hover:text-white"
              >
                <BarChart3 className="size-4" aria-hidden="true" /> Estadisticas
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

        {/* Botón menú móvil */}
        <button
          type="button"
          onClick={() => setMenuOpen((v) => !v)}
          aria-label={menuOpen ? 'Cerrar menú' : 'Abrir menú'}
          aria-expanded={menuOpen}
          className="inline-flex items-center justify-center rounded-full p-2 text-white/85 transition hover:bg-white/10 hover:text-white lg:hidden"
        >
          {menuOpen ? <X className="size-7" /> : <Menu className="size-7" />}
        </button>
      </div>

      {/* Menú móvil */}
      {menuOpen && !loading && (
        <div className="border-t border-white/10 bg-[#0c201a]/95 px-4 py-4 shadow-inner lg:hidden">
          <div className="mx-auto flex max-w-7xl flex-col gap-1">
            {user && (
              <div className="mb-2 px-3 text-xs text-white/65">
                <span className="block truncate">{user.email}</span>
                <span className="mt-1 inline-block rounded-full bg-[#b88746]/20 px-2 py-0.5 capitalize text-[#f3d9aa]">
                  {role}
                </span>
              </div>
            )}

            {enlacesSesion.map(({ href, label, Icon }) => (
              <Link key={href} href={href} onClick={cerrarMenu} className={mobileLink}>
                <Icon size={16} className="shrink-0 text-[#e8c98d]" />
                {label}
              </Link>
            ))}

            <Link href="/resultados" onClick={cerrarMenu} className={mobileLink}>
              <Trophy size={16} className="shrink-0 text-[#e8c98d]" aria-hidden="true" /> Resultados
            </Link>
            <Link href="/estadisticas" onClick={cerrarMenu} className={mobileLink}>
              <BarChart3 size={16} className="shrink-0 text-[#e8c98d]" aria-hidden="true" /> Estadisticas
            </Link>
            <Link href="/ayuda" onClick={cerrarMenu} className={mobileLink}>
              <HelpCircle size={16} className="shrink-0 text-[#e8c98d]" aria-hidden="true" /> Ayuda
            </Link>

            {user ? (
              <button onClick={handleLogout} className={`${mobileLink} text-left`}>
                <LogOut size={16} className="shrink-0 text-[#e8c98d]" aria-hidden="true" /> Salir
              </button>
            ) : (
              <Link
                href="/login"
                onClick={cerrarMenu}
                className="mt-2 inline-flex items-center justify-center gap-2 rounded-lg bg-[#b88746] px-3 py-2.5 text-sm font-semibold text-white"
              >
                <LogIn className="size-4" aria-hidden="true" /> Acceder
              </Link>
            )}
          </div>
        </div>
      )}
    </nav>
  );
}