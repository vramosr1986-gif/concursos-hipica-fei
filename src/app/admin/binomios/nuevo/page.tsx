'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';

export default function NuevoBinomioPage() {
  const router = useRouter();

  const [formData, setFormData] = useState({
    nombre_jinete: '',
    nombre_caballo: '',
    anio_nacimiento_caballo: '',
    fecha_nacimiento_jinete: '',
    licencia_federativa: '',
  });

  const [error, setError] = useState('');
  const [guardando, setGuardando] = useState(false);

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
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
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

  return (
    <div className="container max-w-2xl py-8">
      <Link href="/admin/binomios" className="text-primary mb-4 inline-block">
        Volver al listado
      </Link>

      <h1 className="text-3xl font-bold mb-6">Nuevo Binomio</h1>

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
              placeholder="Ej. Juan Perez"
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
              Necesario para calcular la categoria del jinete (Alevin, Infantil, Juvenil, Joven Jinete, Adulto)
            </p>
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">
              Nombre del caballo *
            </label>
            <input
              type="text"
              required
              placeholder="Ej. Babieca"
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
              Necesario para calcular la categoria del caballo (CJ4, CJ5, CJ6, CJ7, CJ8_10)
            </p>
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">
              Licencia federativa
            </label>
            <input
              type="text"
              placeholder="Ej. 1478"
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
              {guardando ? 'Guardando...' : 'Guardar Binomio'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}