'use client';

import Link from 'next/link';

type Props = {
  titulo: string;
  emoji: string;
  color: string;
  archivoMd: string;
  children: React.ReactNode;
};

export default function ManualLayout({ titulo, emoji, color, archivoMd, children }: Props) {
  const colorBg = {
    blue: 'from-blue-600 to-blue-800',
    amber: 'from-amber-600 to-amber-800',
    emerald: 'from-emerald-600 to-emerald-800',
  }[color] || 'from-gray-600 to-gray-800';

  return (
    <div className="container max-w-4xl py-8">
      <div className="mb-6">
        <Link href="/ayuda" className="text-primary hover:underline text-sm mb-2 inline-block">
          ← Volver a Ayuda
        </Link>

        {/* Cabecera con gradiente */}
        <div className={`bg-gradient-to-r ${colorBg} rounded-lg p-8 text-white shadow-lg`}>
          <div className="flex items-center gap-4">
            <div className="text-6xl">{emoji}</div>
            <div>
              <h1 className="text-3xl font-bold">{titulo}</h1>
              <p className="text-sm opacity-90 mt-1">Documento oficial de la plataforma</p>
            </div>
          </div>

          <div className="mt-6 flex gap-3 flex-wrap">
            <a
              href={`/descargas/${archivoMd}`}
              download
              className="px-4 py-2 bg-white text-gray-900 rounded font-bold hover:bg-gray-100 transition text-sm"
            >
              📥 Descargar .md
            </a>
            <a
              href={`/descargas/${archivoMd}`}
              target="_blank"
              className="px-4 py-2 bg-white/20 rounded font-bold hover:bg-white/30 transition text-sm"
            >
              🔗 Abrir en nueva pestaña
            </a>
          </div>
        </div>
      </div>

      {/* Contenido del manual */}
      <div className="card p-8 space-y-4">{children}</div>

      <div className="text-center mt-8 text-sm text-gray-500">
        Última actualización: Septiembre 2026
      </div>
    </div>
  );
}