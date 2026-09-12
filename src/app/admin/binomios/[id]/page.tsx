'use client';

import { useEffect, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

type Binomio = {
  id: string;
  nombre_jinete: string;
  nombre_caballo: string;
  anio_nacimiento_caballo: number | null;
  fecha_nacimiento_jinete: string | null;
  licencia_federativa: string | null;
};

export default function EditarBinomioPage() {
  const params = useParams();
  const router = useRouter();
  const binomioId = params.id as string;

  const [binomio, setBinomio] = useState<Binomio | null>(null);
  const [formData, setFormData] = useState({
    nombre_jinete: '',
    nombre_caballo: '',
    anio_nacimiento_caballo: '',
    fecha_nacimiento_jinete: '',
    licencia_federativa: '',
  });
  const [loading, setLoading] = useState(true);
  const [guardando, setGuardando] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    const cargar = async () => {
      try {
        const { data, error: dbErr } = await supabase
          .from('binomios')
          .select('id, nombre_jinete, nombre_caballo, anio_nacimiento_caballo, fecha_nacimiento_jinete, licencia_federativa')
          .eq('id', binomioId)
          .single();

        if (dbErr) throw dbErr;

        setBinomio(data);
        setFormData({
          nombre_jinete: data.nombre_jinete || '',
          nombre_caballo: data.nombre_caballo || '',
          anio_nacimiento_caballo: data.anio_nacimiento_caballo ? String(data.anio_nacimiento_caballo) : '',
          fecha_nacimiento_jinete: data.fecha_nacimiento_jinete || '',
          licencia_federativa: data.licencia_federativa || '',
        });
      } catch (err: any) {
        setError(err.message || 'Error al cargar el binomio');
      } finally {
        setLoading(false);
      }
    };

    if (binomioId) cargar();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [binomioId]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    if (!formData.nombre_jinete.trim() || !formData.nombre_caballo.trim()) {
      setError('Jinete y caballo son obligatorios');
      return;
    }

    setGuardando(true);
    try {
      const res = await fetch('/api/binomios', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          id: binomioId,
          nombre_jinete: formData.nombre_jinete.trim(),
          nombre_caballo: formData.nombre_caballo.trim(),
          anio_nacimiento_caballo: formData.anio_nacimiento_caballo.trim()
            ? parseInt(formData.anio_nacimiento_caballo, 10)
            : null,
          fecha_nacimiento_jinete: formData.fecha_nacimiento_jinete || null,
          licencia_federativa: formData.licencia_federativa.trim() || null,
        }),
      });

      if (!res.ok) {
        const body = await res.json().catch(() => ({}));
        setError(body.error || 'No se pudo guardar el binomio');
        return;
      }

      router.push('/admin/binomios');
      router.refresh();
    } finally {
      setGuardando(false);
    }
  };

  if (loading) return <div className="container py-8 text-center">Cargando...</div>;
  if (!binomio) return <div className="container py-8 text-center">Binomio no encontrado</div>;

  return (
    <div className="container max-w-2xl py-8">
      <Link href="/admin/binomios" className="text-primary mb-4 inline-block">
        Volver al listado
      </Link>

      <h1 className="text-3xl font-bold mb-6">Editar Binomio</h1>

      <div className="card p-6">
        {error && (
          <div className="mb-4 p-3 bg-danger text-white rounded text-sm">{error}</div>
        )}

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-bold mb-2">
              Nombre del jinete *
            </label>
            <input
              type="text"
              required
              value={formData.nombre_jinete}
              onChange={(e) =>
                setFormData({ ...formData, nombre_jinete: e.target.value })
              }
              className="input w-full"
            />
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">
              Fecha de nacimiento del jinete
            </label>
            <input
              type="date"
              value={formData.fecha_nacimiento_jinete}
              onChange={(e) =>
                setFormData({
                  ...formData,
                  fecha_nacimiento_jinete: e.target.value,
                })
              }
              className="input w-full"
            />
            <p className="text-xs text-gray-500 mt-1">
              Necesario para calcular la categoria del jinete
            </p>
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">
              Nombre del caballo *
            </label>
            <input
              type="text"
              required
              value={formData.nombre_caballo}
              onChange={(e) =>
                setFormData({ ...formData, nombre_caballo: e.target.value })
              }
              className="input w-full"
            />
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">
              Año de nacimiento del caballo
            </label>
            <input
              type="number"
              placeholder="Ej. 2018"
              min="1990"
              max="2030"
              value={formData.anio_nacimiento_caballo}
              onChange={(e) =>
                setFormData({
                  ...formData,
                  anio_nacimiento_caballo: e.target.value,
                })
              }
              className="input w-full"
            />
            <p className="text-xs text-gray-500 mt-1">
              Necesario para calcular la categoria del caballo (CJ4-CJ8_10)
            </p>
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">
              Licencia federativa
            </label>
            <input
              type="text"
              value={formData.licencia_federativa}
              onChange={(e) =>
                setFormData({ ...formData, licencia_federativa: e.target.value })
              }
              className="input w-full"
            />
          </div>

          <div className="flex justify-end gap-3 pt-6">
            <Link href="/admin/binomios" className="btn btn-outline">
              Cancelar
            </Link>

            <button
              type="submit"
              disabled={guardando}
              className="btn btn-primary disabled:opacity-50"
            >
              {guardando ? 'Guardando...' : 'Guardar Cambios'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}