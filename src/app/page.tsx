'use client';

import Link from 'next/link';
import { useEffect, useState } from 'react';
import { Trophy, Gavel, Settings, ArrowRight, BarChart3 } from 'lucide-react';
import { Concurso } from '@/types';
import { concursoService } from '@/lib/services';
import { ConcursoCard } from '@/components/ConcursoCard';
import { HeroIllustration } from '@/components/HeroIllustration';

const panels = [
  {
    mark: '01',
    title: 'Resultados',
    description: 'Consulta clasificaciones, notas y la evolución de cada prueba.',
    href: '/resultados',
    action: 'Ver resultados',
    Icon: Trophy,
  },
  {
    mark: '02',
    title: 'Jueces',
    description: 'Registra valoraciones con el protocolo y criterios FEI.',
    href: '/juez',
    action: 'Acceder al panel',
    Icon: Gavel,
  },
  {
    mark: '03',
    title: 'Administración',
    description: 'Organiza concursos, jornadas, binomios y equipos de jueces.',
    href: '/admin/concursos',
    action: 'Gestionar concursos',
    Icon: Settings,
  },
  {
    mark: '04',
    title: 'Estadísticas',
    description: 'Medias por juez, movimientos más exigentes y curiosidades de la temporada.',
    href: '/estadisticas',
    action: 'Ver estadísticas',
    Icon: BarChart3,
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
      <section className="relative overflow-hidden rounded-[2rem] border border-[#ddd3c0] bg-[#173b2f] px-6 py-11 text-white shadow-soft sm:px-12 sm:py-16 lg:py-20">
        <div className="absolute -right-24 -top-32 size-80 rounded-full border border-[#e8c98d]/20" />
        <div className="absolute -bottom-40 right-20 size-96 rounded-full bg-[#b88746]/10 blur-3xl" />
        <div className="relative flex flex-col gap-10 lg:grid lg:grid-cols-[1.05fr_0.95fr] lg:items-center lg:gap-12">
          <div className="mx-auto max-w-2xl text-center lg:mx-0 lg:text-left">
            <p className="mb-4 flex items-center justify-center gap-3 text-xs font-bold uppercase tracking-[0.28em] text-[#e8c98d] lg:justify-start">
              <span aria-hidden="true">—</span>
              Concursos FEI de doma
              <span aria-hidden="true">—</span>
            </p>
            <h1 className="text-3xl font-semibold leading-tight sm:text-5xl lg:text-6xl">
              La doma se vive,
              <span className="mt-1 block font-serif italic text-[#e8c98d]">
                se juzga y se comparte.
              </span>
            </h1>
            <p className="mx-auto mt-4 max-w-xl text-sm leading-6 text-white/75 sm:text-lg sm:leading-7 lg:mx-0">
              Organización, jurado y público en una misma arena digital: resultados en tiempo real
              para cada prueba.
            </p>
            <div className="mt-7 flex flex-wrap justify-center gap-3 lg:justify-start">
              <Link href="/resultados" className="btn btn-secondary">
                <Trophy className="mr-2 size-4" aria-hidden="true" />
                Ver resultados
              </Link>
              <Link href="/login" className="btn border border-white/30 text-white hover:border-[#e8c98d] hover:bg-white/10">
                Acceso profesional
              </Link>
            </div>
          </div>

          <div className="hidden lg:flex lg:items-center lg:justify-center">
            <HeroIllustration />
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
              <div className="flex items-center gap-4">
                <span className="flex size-12 items-center justify-center rounded-full border border-[#e4dfd4] bg-[#f5f1e7] text-[#b88746] transition group-hover:border-[#c8b087] group-hover:bg-[#173b2f] group-hover:text-[#e8c98d]">
                  <panel.Icon className="size-6" aria-hidden="true" />
                </span>
                <span className="text-sm font-bold tracking-widest text-[#b88746]">{panel.mark}</span>
              </div>
              <h3 className="mt-7 text-2xl font-semibold text-[#173b2f]">{panel.title}</h3>
              <p className="mt-3 min-h-12 text-sm leading-6 text-[#607168]">{panel.description}</p>
              <Link href={panel.href} className="mt-7 inline-flex items-center gap-2 text-sm font-bold text-primary transition group-hover:gap-3">
                {panel.action} <ArrowRight className="size-4" aria-hidden="true" />
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
            <Link href="/resultados" className="inline-flex items-center gap-1.5 text-sm font-bold text-primary hover:text-dark">
              Ver todos los resultados <ArrowRight className="size-4" aria-hidden="true" />
            </Link>
          )}
        </div>

        {loading ? (
          <div className="card py-12 text-center text-sm text-[#607168]">Cargando concursos…</div>
        ) : concursos.length > 0 ? (
<div className="grid gap-5 md:grid-cols-2 lg:grid-cols-4">
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