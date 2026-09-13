'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

type Manual = {
  id: string;
  titulo: string;
  descripcion: string;
  emoji: string;
  color: string;
  roles: ('admin' | 'juez' | 'publico')[];
  ruta: string;
};

export default function AyudaPage() {
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

  const manuales: Manual[] = [
    {
      id: 'usuario',
      titulo: 'Manual de Usuario',
      descripcion: 'Guía general: cómo crear concursos, pruebas, inscribir binomios y ver resultados.',
      emoji: '📘',
      color: 'blue',
      roles: ['admin', 'juez', 'publico'],
      ruta: '/ayuda/usuario',
    },
    {
      id: 'juez',
      titulo: 'Manual del Juez',
      descripcion: 'Cómo ver tus pruebas, puntuar ejercicios, puntuar equipos y editar notas.',
      emoji: '⚖️',
      color: 'amber',
      roles: ['admin', 'juez'],
      ruta: '/ayuda/juez',
    },
    {
      id: 'admin',
      titulo: 'Manual del Administrador',
      descripcion: 'Gestión completa: concursos, jornadas, pruebas, equipos, usuarios y backups.',
      emoji: '🔐',
      color: 'emerald',
      roles: ['admin'],
      ruta: '/ayuda/admin',
    },
  ];

  const visibles = manuales.filter((m) =>
    m.roles.includes(rol as 'admin' | 'juez' | 'publico')
  );

  const colorClasses = (color: string) => {
    const map: Record<string, string> = {
      blue: 'border-blue-200 bg-blue-50 hover:bg-blue-100',
      amber: 'border-amber-200 bg-amber-50 hover:bg-amber-100',
      emerald: 'border-emerald-200 bg-emerald-50 hover:bg-emerald-100',
    };
    return map[color] || 'border-gray-200 bg-gray-50';
  };

  if (cargando) {
    return <div className="container max-w-5xl py-8 text-center">Cargando...</div>;
  }

  return (
    <div className="container max-w-5xl py-8">
      <div className="mb-8">
        <Link href="/" className="text-primary hover:underline text-sm mb-2 inline-block">
          ← Volver al inicio
        </Link>
        <h1 className="text-4xl font-bold mb-2">📚 Ayuda</h1>
        <p className="text-gray-600">
          Selecciona un manual para consultarlo online o descargarlo.
        </p>
      </div>

      <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
        {visibles.map((m) => (
          <Link
            key={m.id}
            href={m.ruta}
            className={`card p-6 border-2 transition-all cursor-pointer ${colorClasses(m.color)}`}
          >
            <div className="text-5xl mb-4">{m.emoji}</div>
            <h2 className="text-xl font-bold mb-2">{m.titulo}</h2>
            <p className="text-sm text-gray-700 mb-4">{m.descripcion}</p>
            <div className="text-sm font-bold text-[#112d24] flex items-center gap-2">
              Ver manual →
            </div>
          </Link>
        ))}
      </div>

      {visibles.length === 0 && (
        <div className="card p-8 text-center text-gray-600">
          No hay manuales disponibles.
        </div>
      )}
    </div>
  );
}