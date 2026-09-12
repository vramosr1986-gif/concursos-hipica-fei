import type { Metadata } from 'next';
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
        <footer className="mt-12 border-t border-[#dcd4c4] bg-[#112d24] px-6 py-8 text-center text-sm text-white/70">
          <p className="font-serif text-lg text-[#e8c98d]">Plataforma FEI</p>
          <p className="mt-1">Gestión de concursos de doma clásica</p>
          <p className="mt-3 text-xs text-white/45">&copy; 2025 · Todos los derechos reservados.</p>
        </footer>
      </body>
    </html>
  );
}
