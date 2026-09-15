import type { Metadata } from 'next';
import { BarChart3, Medal, Trophy } from 'lucide-react';
import Link from 'next/link';
import { Navbar } from '@/components/Navbar';
import './globals.css';

export const metadata: Metadata = {
  title: 'Concursos de Doma Clásica FEI',
  description: 'Plataforma de gestión de concursos de doma clásica',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="es">
      <body>
        <Navbar />
        <main className="min-h-screen">{children}</main>
        <footer className="mt-12 border-t border-[#dcd4c4] bg-[#112d24] px-6 py-10 text-sm text-white/70">
          <div className="mx-auto flex max-w-7xl flex-col items-center gap-6 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <p className="flex items-center gap-2 font-serif text-lg text-[#e8c98d]">
                <Trophy className="size-5 text-[#e8c98d]" aria-hidden="true" />
                Plataforma FEI
              </p>
              <p className="mt-1.5 text-white/60">Gestión de concursos de doma clásica</p>
              <p className="mt-3 text-xs text-white/40">&copy; {new Date().getFullYear()} · Todos los derechos reservados.</p>
            </div>
            <nav className="flex flex-wrap items-center gap-4 text-xs font-semibold text-white/55">
              <Link href="/resultados" className="inline-flex items-center gap-1.5 transition hover:text-[#e8c98d]">
                <Trophy className="size-3.5" aria-hidden="true" /> Resultados
              </Link>
              <Link href="/estadisticas" className="inline-flex items-center gap-1.5 transition hover:text-[#e8c98d]">
                <BarChart3 className="size-3.5" aria-hidden="true" /> Estadisticas
              </Link>
              <Link href="/login" className="transition hover:text-[#e8c98d]">Acceso</Link>
              <Link href="/ayuda" className="inline-flex items-center gap-1.5 transition hover:text-[#e8c98d]">
                <Medal className="size-3.5" aria-hidden="true" /> Ayuda
              </Link>
            </nav>
          </div>
        </footer>
      </body>
    </html>
  );
}
