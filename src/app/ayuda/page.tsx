'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

type Archivo = {
  id: string;
  nombre: string;
  descripcion: string;
  emoji: string;
  url: string;
  tipo: string;
  roles: ('admin' | 'juez' | 'publico')[];
};

export default function DescargasPage() {
  const [rol, setRol] = useState<string>('publico');
  const [cargando, setCargando] = useState(true);

  useEffect(() => {
    const cargarRol = async () => {
      try {
        const { data: { user } } = await supabase.auth.getUser();

        if (!user) {
          setRol('publico');
          setCargando(false);
          return;
        }

        const { data: perfil } = await supabase
          .from('profiles')
          .select('rol')
          .eq('id', user.id)
          .single();

        setRol(perfil?.rol || 'publico');
      } catch {
        setRol('publico');
      } finally {
        setCargando(false);
      }
    };

    cargarRol();
  }, []);

  const todosLosArchivos: Archivo[] = [
    {
      id: 'usuario',
      nombre: 'Manual de Usuario',
      descripcion:
        'Guía general de la plataforma: crear concursos, pruebas, inscribir binomios, puntuar y ver resultados.',
      emoji: '📘',
      url: '/descargas/MANUAL_USUARIO.md',
      tipo: 'Markdown (.md)',
      roles: ['admin', 'juez', 'publico'],
    },
    {
      id: 'juez',
      nombre: 'Manual del Juez',
      descripcion:
        'Guía específica para jueces: cómo ver tus pruebas, puntuar ejercicios, puntuar equipos y editar notas.',
      emoji: '⚖️',
      url: '/descargas/MANUAL_JUEZ.md',
      tipo: 'Markdown (.md)',
      roles: ['admin', 'juez'],
    },
    {
      id: 'admin',
      nombre: 'Manual del Administrador',
      descripcion:
        'Guía completa para administradores: crear concursos, jornadas, pruebas, binomios, equipos, usuarios y backups.',
      emoji: '🔐',
      url: '/descargas/MANUAL_ADMIN.md',
      tipo: 'Markdown (.md)',
      roles: ['admin'],
    },
  ];

  const archivosVisibles = todosLosArchivos.filter((a) =>
    a.roles.includes(rol as 'admin' | 'juez' | 'publico')
  );

  const descargar = (url: string, nombre: string) => {
    const link = document.createElement('a');
    link.href = url;
    link.download = nombre;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  if (cargando) {
    return (
      <div className="container max-w-4xl py-8 text-center">
        Cargando...
      </div>
    );
  }

  return (
    <div className="container max-w-4xl py-8">
      <div className="mb-6">
        <Link href="/ayuda" className="text-primary hover:underline text-sm mb-2 inline-block">
          ← Volver a Ayuda
        </Link>
        <h1 className="text-3xl font-bold">📥 Descargas</h1>
        <p className="text-gray-600 mt-1">
          Documentos descargables para consultar offline.
        </p>
        {rol !== 'publico' && (
          <p className="text-sm text-blue-700 mt-2">
            Mostrando manuales disponibles para tu rol: <strong>{rol}</strong>
          </p>
        )}
      </div>

      {archivosVisibles.length === 0 ? (
        <div className="card p-8 text-center text-gray-600">
          No hay documentos disponibles para tu rol.
        </div>
      ) : (
        <div className="space-y-4">
          {archivosVisibles.map((a) => (
            <div key={a.id} className="card p-6">
              <div className="flex items-start gap-4">
                <div className="text-5xl">{a.emoji}</div>
                <div className="flex-1">
                  <h2 className="text-xl font-bold mb-1">{a.nombre}</h2>
                  <p className="text-xs text-gray-500 mb-2">{a.tipo}</p>
                  <p className="text-sm text-gray-700 mb-4">{a.descripcion}</p>
                  <div className="flex gap-2 flex-wrap">
                    <button
                      onClick={() => descargar(a.url, a.nombre + '.md')}
                      className="btn btn-primary text-sm"
                    >
                      📥 Descargar
                    </button>
                    <button
                      onClick={() => window.open(a.url, '_blank')}
                      className="btn btn-outline text-sm"
                    >
                      👁 Ver online
                    </button>
                    <button
                      onClick={() => {
                        navigator.clipboard.writeText(window.location.origin + a.url);
                        alert('URL copiada al portapapeles');
                      }}
                      className="btn btn-outline text-sm"
                    >
                      🔗 Copiar URL
                    </button>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}




    </div>
  );
}