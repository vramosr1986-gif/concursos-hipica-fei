'use client';

import Link from 'next/link';
import { Concurso } from '@/types';

interface ConcursoCardProps {
  concurso: Concurso;
}

export function ConcursoCard({ concurso }: ConcursoCardProps) {
  const fechaInicio = new Date(concurso.fecha_inicio);
  const fechaFin = new Date(concurso.fecha_fin);

  return (
    <article className="card group flex h-full flex-col overflow-hidden p-0 hover:-translate-y-1 hover:border-[#c8b087] hover:shadow-soft">
      <div className="border-b border-[#ebe5d9] bg-[#f5f1e7] px-6 py-4">
        <p className="text-xs font-bold uppercase tracking-[0.18em] text-[#9c6c31]">Concurso FEI</p>
      </div>
      <div className="flex flex-1 flex-col p-6">
        <h3 className="font-serif text-2xl font-semibold leading-tight text-[#173b2f]">{concurso.nombre}</h3>

        <div className="mt-5 space-y-2.5 text-sm leading-5 text-[#607168]">
          <p className="flex gap-2"><span className="text-[#b88746]">◷</span><span>{fechaInicio.toLocaleDateString('es-ES')} — {fechaFin.toLocaleDateString('es-ES')}</span></p>
          <p className="flex gap-2"><span className="text-[#b88746]">⌖</span><span>{concurso.ubicacion || 'Ubicación por confirmar'}</span></p>
          <p className="flex gap-2"><span className="text-[#b88746]">◇</span><span>{concurso.organizador || 'Organización por confirmar'}</span></p>
        </div>

        <Link
          href={`/resultados?concurso=${concurso.id}`}
          className="mt-7 inline-flex items-center gap-2 text-sm font-bold text-primary transition hover:gap-3 hover:text-dark"
        >
          Ver detalles <span aria-hidden="true">→</span>
        </Link>
      </div>
    </article>
  );
}
