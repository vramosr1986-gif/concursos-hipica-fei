'use client';

import Link from 'next/link';
import { CalendarDays, Gavel, Users, ArrowRight, Plus, ListChecks } from 'lucide-react';
import { HorseIcon } from '@/components/icons';

const modulos = [
  {
    href: '/admin/concursos',
    titulo: 'Concursos',
    descripcion: 'Crear, editar y gestionar concursos, pruebas y binomios.',
    Icon: CalendarDays,
    color: 'bg-[#173b2f]/10 text-[#173b2f] group-hover:bg-[#173b2f] group-hover:text-[#e8c98d]',
  },
  {
    href: '/admin/jueces',
    titulo: 'Jueces',
    descripcion: 'Catálogo de jueces profesionales y su asignación.',
    Icon: Gavel,
    color: 'bg-[#b88746]/15 text-[#b88746] group-hover:bg-[#b88746] group-hover:text-white',
  },
  {
    href: '/admin/binomios',
    titulo: 'Binomios',
    descripcion: 'Catálogo de jinetes y caballos con su licencia.',
    Icon: HorseIcon,
    color: 'bg-[#b88746]/15 text-[#b88746] group-hover:bg-[#b88746] group-hover:text-white',
  },
  {
    href: '/admin/reprises',
    titulo: 'Reprises',
    descripcion: 'Catálogo de reprises FEI y detalle de sus ejercicios.',
    Icon: ListChecks,
    color: 'bg-[#173b2f]/10 text-[#173b2f] group-hover:bg-[#173b2f] group-hover:text-[#e8c98d]',
  },
  {
    href: '/admin/usuarios',
    titulo: 'Usuarios',
    descripcion: 'Crear y gestionar cuentas de jueces y administradores.',
    Icon: Users,
    color: 'bg-[#b88746]/15 text-[#b88746] group-hover:bg-[#b88746] group-hover:text-white',
  },
];

export default function AdminIndexPage() {
  return (
    <div className="space-y-8">
      {/* Banner de bienvenida */}
      <section className="relative overflow-hidden rounded-3xl border border-[#ddd3c0] bg-[#173b2f] px-6 py-10 text-white shadow-[0_16px_45px_rgba(25,55,43,0.18)] sm:px-10">
        <div className="absolute -right-20 -top-24 size-64 rounded-full border border-[#e8c98d]/15" />
        <div className="absolute -bottom-24 right-24 size-72 rounded-full bg-[#b88746]/10 blur-3xl" />

        <div className="relative flex flex-wrap items-end justify-between gap-6">
          <div className="max-w-xl">
            <p className="mb-3 text-xs font-bold uppercase tracking-[0.26em] text-[#e8c98d]">
              Gestión centralizada
            </p>
            <h2 className="text-3xl font-semibold leading-tight sm:text-4xl">
              Organiza tus concursos desde un único panel.
            </h2>
            <p className="mt-3 text-sm leading-6 text-white/70">
              Pruebas, jornadas, binomios, jueces y resultados: todo el ciclo de la
              competición FEI bien estructurado.
            </p>
          </div>

          <Link
            href="/admin/concursos/nuevo"
            className="btn border border-white/30 text-white transition hover:border-[#e8c98d] hover:bg-white/10"
          >
            <Plus className="size-4" aria-hidden="true" />
            Nuevo concurso
          </Link>
        </div>
      </section>

      {/* Módulos */}
      <section>
        <div className="mb-5 flex items-end justify-between gap-3">
          <div>
            <p className="text-xs font-bold uppercase tracking-[0.22em] text-[#b88746]">
              Áreas de trabajo
            </p>
            <h2 className="mt-1 text-2xl font-semibold text-[#173b2f]">Selecciona una sección</h2>
          </div>
        </div>

        <div className="grid gap-5 md:grid-cols-2 xl:grid-cols-3">
          {modulos.map((modulo) => (
            <Link
              key={modulo.href}
              href={modulo.href}
              className="group card p-7 transition-all duration-300 hover:-translate-y-1 hover:border-[#c8b087] hover:shadow-[0_16px_45px_rgba(25,55,43,0.12)]"
            >
              <span
                className={`inline-flex size-12 items-center justify-center rounded-2xl transition-colors duration-300 ${modulo.color}`}
              >
                <modulo.Icon size={22} />
              </span>
              <h3 className="mt-6 text-xl font-semibold text-[#173b2f]">{modulo.titulo}</h3>
              <p className="mt-2 min-h-10 text-sm leading-6 text-[#607168]">{modulo.descripcion}</p>
              <span className="mt-5 inline-flex items-center gap-2 text-sm font-bold text-primary transition group-hover:gap-3">
                Entrar <ArrowRight className="size-4" aria-hidden="true" />
              </span>
            </Link>
          ))}
        </div>
      </section>
    </div>
  );
}