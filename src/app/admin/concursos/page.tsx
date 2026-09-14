'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import {
  CalendarDays,
  MapPin,
  Building2,
  Plus,
  Pencil,
  Trash2,
  Trophy,
} from 'lucide-react';
import { Concurso } from '@/types';
import { concursoService } from '@/lib/services';

export default function AdminConcursosPage() {
  const [concursos, setConcursos] = useState<Concurso[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const fetchConcursos = async () => {
    const { data, error } = await concursoService.getAll();
    if (error) {
      setError(error.message);
    } else if (data) {
      setConcursos(data);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchConcursos();
  }, []);

  const handleDelete = async (id: string, nombre: string) => {
    if (
      window.confirm(
        `¿Eliminar el concurso "${nombre}"? Esta acción no se puede deshacer.`
      )
    ) {
      setLoading(true);
      const { error } = await concursoService.delete(id);
      if (error) {
        setError(error.message);
        setLoading(false);
      } else {
        await fetchConcursos();
      }
    }
  };

  const formatearFechas = (inicio: string, fin: string) => {
    const fi = new Date(inicio);
    const ff = new Date(fin);
    const f = (d: Date) => d.toLocaleDateString('es-ES');
    return inicio === fin ? f(fi) : `${f(fi)} — ${f(ff)}`;
  };

  return (
    <div className="space-y-8">
      {/* Cabecera */}
      <div className="flex flex-wrap items-center justify-between gap-4">
        <div>
          <p className="text-xs font-bold uppercase tracking-[0.22em] text-[#b88746]">
            Calendario FEI
          </p>
          <h2 className="mt-1 text-2xl font-semibold text-[#173b2f]">
            Tus concursos ({concursos.length})
          </h2>
        </div>

        <Link href="/admin/concursos/nuevo" className="btn btn-primary">
          <Plus className="size-4" aria-hidden="true" />
          Nuevo Concurso
        </Link>
      </div>

      {error && (
        <div className="rounded-2xl border border-red-200 bg-red-50 p-4 text-sm font-medium text-red-700">
          {error}
        </div>
      )}

      {loading ? (
        <div className="card p-12 text-center text-sm text-[#607168]">
          Cargando concursos…
        </div>
      ) : concursos.length > 0 ? (
        <div className="grid gap-5 md:grid-cols-2 xl:grid-cols-3">
          {concursos.map((concurso) => (
            <article
              key={concurso.id}
              className="card group flex h-full flex-col overflow-hidden p-0 transition-all duration-300 hover:-translate-y-1 hover:border-[#c8b087] hover:shadow-[0_16px_45px_rgba(25,55,43,0.12)]"
            >
              <div className="h-1.5 bg-gradient-to-r from-[#173b2f] via-[#b88746] to-[#e8c98d]" />

              <div className="flex flex-1 flex-col p-6">
                <div className="flex items-start justify-between gap-3">
                  <span className="inline-flex items-center gap-1.5 rounded-full bg-[#f4f0e6] px-3 py-1 text-[10px] font-bold uppercase tracking-[0.14em] text-[#9c6c31]">
                    <Trophy className="size-3" aria-hidden="true" />
                    Concurso FEI
                  </span>
                </div>

                <h3 className="mt-4 font-serif text-xl font-semibold leading-snug text-[#173b2f]">
                  {concurso.nombre}
                </h3>

                <div className="mt-5 space-y-2.5 text-sm leading-5 text-[#607168]">
                  <p className="flex gap-2">
                    <CalendarDays className="mt-0.5 size-4 shrink-0 text-[#b88746]" aria-hidden="true" />
                    <span>{formatearFechas(concurso.fecha_inicio, concurso.fecha_fin)}</span>
                  </p>
                  <p className="flex gap-2">
                    <MapPin className="mt-0.5 size-4 shrink-0 text-[#b88746]" aria-hidden="true" />
                    <span>{concurso.ubicacion || 'Ubicación por confirmar'}</span>
                  </p>
                  <p className="flex gap-2">
                    <Building2 className="mt-0.5 size-4 shrink-0 text-[#b88746]" aria-hidden="true" />
                    <span>{concurso.organizador || 'Organización sin definir'}</span>
                  </p>
                </div>

                <div className="mt-auto flex gap-2 pt-7">
                  <Link
                    href={`/admin/concursos/${concurso.id}`}
                    className="flex-1 btn btn-primary justify-center"
                  >
                    <Pencil className="size-4" aria-hidden="true" />
                    Gestionar
                  </Link>
                  <button
                    onClick={() => handleDelete(concurso.id, concurso.nombre)}
                    className="btn bg-[#b42318] text-white hover:bg-red-800 focus:ring-danger"
                    aria-label={`Eliminar ${concurso.nombre}`}
                  >
                    <Trash2 className="size-4" aria-hidden="true" />
                  </button>
                </div>
              </div>
            </article>
          ))}
        </div>
      ) : (
        <div className="card border-dashed p-12 text-center">
          <span className="mx-auto flex size-14 items-center justify-center rounded-full bg-[#f4f0e6] text-[#b88746]">
            <Trophy className="size-6" aria-hidden="true" />
          </span>
          <h3 className="mt-5 font-serif text-2xl font-semibold text-[#173b2f]">
            Aún no hay concursos
          </h3>
          <p className="mx-auto mt-2 max-w-md text-sm leading-6 text-[#607168]">
            Crea tu primer concurso para empezar a gestionar jornadas, pruebas y binomios.
          </p>
          <Link href="/admin/concursos/nuevo" className="btn btn-primary mt-7">
            <Plus className="size-4" aria-hidden="true" />
            Crear Primer Concurso
          </Link>
        </div>
      )}
    </div>
  );
}