'use client';

import Link from 'next/link';
import { useEffect, useState } from 'react';
import { Concurso } from '@/types';
import { concursoService } from '@/lib/services';
import { ConcursoCard } from '@/components/ConcursoCard';

const panels = [
  {
    mark: '01',
    title: 'Resultados',
    description: 'Consulta clasificaciones, notas y la evolución de cada prueba.',
    href: '/resultados',
    action: 'Ver resultados',
  },
  {
    mark: '02',
    title: 'Jueces',
    description: 'Registra valoraciones con el protocolo y criterios FEI.',
    href: '/juez',
    action: 'Acceder al panel',
  },
  {
    mark: '03',
    title: 'Administración',
    description: 'Organiza concursos, jornadas, binomios y equipos de jueces.',
    href: '/admin/concursos',
    action: 'Gestionar concursos',
  },
];

export default function Home() {
  const [concursos, setConcursos] = useState<Concurso[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchConcursos = async () => {
      const { data, error } = await concursoService.getAll();
      if (!error && data) {
        setConcursos(data);
      }
      setLoading(false);
    };

    fetchConcursos();
  }, []);

  return (
    <div className="container">
      <section className="relative overflow-hidden rounded-[2rem] border border-[#ddd3c0] bg-[#173b2f] px-6 py-14 text-white shadow-soft sm:px-10 sm:py-20 lg:px-16">
        <div className="absolute -right-24 -top-32 size-80 rounded-full border border-[#e8c98d]/20" />
        <div className="absolute -bottom-40 right-20 size-96 rounded-full bg-[#b88746]/10 blur-3xl" />
        <div className="relative max-w-3xl">
          <p className="mb-5 text-xs font-bold uppercase tracking-[0.28em] text-[#e8c98d]">
            Plataforma de competición
          </p>
          <h1 className="max-w-2xl text-4xl font-semibold leading-tight sm:text-5xl lg:text-6xl">
            La precisión de la doma, en una gestión impecable.
          </h1>
          <p className="mt-6 max-w-xl text-base leading-7 text-white/75 sm:text-lg">
            Centraliza concursos, binomios y resultados en un espacio pensado para
            cada persona que hace posible la competición.
          </p>
          <div className="mt-8 flex flex-wrap gap-3">
            <Link href="/resultados" className="btn btn-secondary">
              Consultar resultados
            </Link>
            <Link href="/login" className="btn border border-white/30 text-white hover:border-[#e8c98d] hover:bg-white/10">
              Acceso profesional
            </Link>
          </div>
        </div>
      </section>



      <section className="mt-16">
        <div className="mb-7 flex flex-col justify-between gap-3 sm:flex-row sm:items-end">
          <div>
            <p className="text-xs font-bold uppercase tracking-[0.22em] text-[#b88746]">Áreas de trabajo</p>
            <h2 className="mt-2 text-3xl font-semibold text-[#173b2f]">Todo en su sitio.</h2>
          </div>
          <p className="max-w-sm text-sm leading-6 text-[#607168]">
            Accesos claros para la organización, el jurado y el seguimiento público.
          </p>
        </div>

        <div className="grid gap-5 md:grid-cols-3">
          {panels.map((panel) => (
            <article key={panel.title} className="card group p-7 hover:-translate-y-1 hover:border-[#c8b087] hover:shadow-soft">
              <span className="text-sm font-bold tracking-widest text-[#b88746]">{panel.mark}</span>
              <h3 className="mt-7 text-2xl font-semibold text-[#173b2f]">{panel.title}</h3>
              <p className="mt-3 min-h-12 text-sm leading-6 text-[#607168]">{panel.description}</p>
              <Link href={panel.href} className="mt-7 inline-flex items-center gap-2 text-sm font-bold text-primary transition group-hover:gap-3">
                {panel.action} <span aria-hidden="true">→</span>
              </Link>
            </article>
          ))}
        </div>
      </section>

      <section className="mt-20">
        <div className="mb-7 flex flex-col justify-between gap-4 sm:flex-row sm:items-end">
          <div>
            <p className="text-xs font-bold uppercase tracking-[0.22em] text-[#b88746]">Calendario</p>
            <h2 className="mt-2 text-3xl font-semibold text-[#173b2f]">Próximos concursos</h2>
          </div>
          {concursos.length > 0 && (
            <Link href="/resultados" className="text-sm font-bold text-primary hover:text-dark">
              Ver todos los resultados →
            </Link>
          )}
        </div>

        {loading ? (
          <div className="card py-12 text-center text-sm text-[#607168]">Cargando concursos…</div>
        ) : concursos.length > 0 ? (
          <div className="grid gap-5 md:grid-cols-3">
            {concursos.map((concurso) => (
              <ConcursoCard key={concurso.id} concurso={concurso} />
            ))}
          </div>
        ) : (
          <div className="card border-dashed p-10 text-center">
            <p className="font-serif text-2xl font-semibold text-[#173b2f]">Aún no hay concursos publicados</p>
            <p className="mx-auto mt-2 max-w-md text-sm leading-6 text-[#607168]">
              Cuando se programe el próximo evento, aparecerá aquí con toda su información.
            </p>
            <Link href="/admin/concursos/nuevo" className="btn btn-primary mt-6">
              Crear concurso
            </Link>
          </div>
        )}
      </section>
    </div>
  );
}
