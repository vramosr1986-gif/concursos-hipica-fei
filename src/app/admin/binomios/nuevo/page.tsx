'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { SelectorFederacion } from '@/components/BanderaFH';
import { fetchConSesion } from '@/lib/juez-actual';

export default function NuevoBinomioPage() {
  const router = useRouter();

  const [formData, setFormData] = useState({
    nombre_jinete: '',
    nombre_caballo: '',
    anio_nacimiento_caballo: '',
    fecha_nacimiento_jinete: '',
    licencia_federativa: '',
    ldn_jinete: '',
    lac_caballo: '',
    fh_jinete: '',
    fh_caballo: '',
  });

  const [error, setError] = useState('');
  const [guardando, setGuardando] = useState(false);

  const buscarJineteRfhe = () => {
    const nombre = formData.nombre_jinete.trim();
    if (!nombre) {
      setError('Escribe el nombre del jinete antes de buscarlo en RFHE');
      return;
    }

    const apellidos = nombre.includes(',')
      ? nombre.split(',')[0].trim()
      : nombre.split(/\s+/).slice(-1)[0];
    const target = `rfhe-jinete-${Date.now()}`;
    window.open('', target);

    const form = document.createElement('form');
    form.method = 'POST';
    form.action = 'https://www.cbservicios.net/Magic94Scripts/mgrqispi94.dll?';
    form.target = target;

    const campos = {
      APPNAME: 'CBRFHE',
      PRGNAME: 'RFHEBUSJIN02',
      ARGUMENTS: 'APE,FIN',
      FIN: 'FIN',
      APE: apellidos,
    };

    Object.entries(campos).forEach(([key, value]) => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = key;
      input.value = value;
      form.appendChild(input);
    });

    document.body.appendChild(form);
    form.submit();
    form.remove();
  };

  const abrirBusquedaCaballoRfhe = () => {
    window.open(
      'https://www.cbservicios.net/Magic94Scripts/Mgrqispi94.dll?APPNAME=CBRFHE&PRGNAME=RFHEBUSCAB',
      '_blank',
      'noopener,noreferrer'
    );
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    if (!formData.nombre_jinete.trim() || !formData.nombre_caballo.trim()) {
      setError('Jinete y caballo son obligatorios');
      return;
    }

    setGuardando(true);
    try {
      const res = await fetchConSesion('/api/binomios', {
        method: 'POST',
        body: JSON.stringify({
          nombre_jinete: formData.nombre_jinete.trim(),
          nombre_caballo: formData.nombre_caballo.trim(),
          anio_nacimiento_caballo: formData.anio_nacimiento_caballo.trim()
            ? parseInt(formData.anio_nacimiento_caballo, 10)
            : null,
          fecha_nacimiento_jinete: formData.fecha_nacimiento_jinete || null,
          licencia_federativa: formData.licencia_federativa.trim() || null,
          ldn_jinete: formData.ldn_jinete.trim() || null,
          lac_caballo: formData.lac_caballo.trim() || null,
          fh_jinete: formData.fh_jinete || null,
          fh_caballo: formData.fh_caballo || null,
        }),
      });

      if (!res.ok) {
        const body = await res.json().catch(() => ({}));
        setError(body.error || 'No se pudo guardar el binomio');
        return;
      }

      router.push('/admin/binomios');
      router.refresh();
    } catch (err: unknown) {
      setError(err instanceof Error ? err.message : 'Error al guardar el binomio');
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

          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <div>
              <div className="mb-2 flex items-center justify-between gap-2">
                <label className="text-sm font-bold" htmlFor="ldn_jinete">
                  LDN del jinete
                </label>
                <button type="button" onClick={buscarJineteRfhe} className="btn btn-sm btn-outline">
                  Buscar RFHE
                </button>
              </div>
              <input id="ldn_jinete" type="text" placeholder="Ej. 283953" value={formData.ldn_jinete}
                onChange={(e) => setFormData({ ...formData, ldn_jinete: e.target.value })}
                className="input w-full" />
              <p className="mt-1 text-xs text-gray-500">Busca usando los apellidos y copia la LDN del resultado correcto.</p>
            </div>

            <div>
              <div className="mb-2 flex items-center justify-between gap-2">
                <label className="text-sm font-bold" htmlFor="lac_caballo">
                  LAC del caballo
                </label>
                <button type="button" onClick={abrirBusquedaCaballoRfhe} className="btn btn-sm btn-outline">
                  Buscar RFHE
                </button>
              </div>
              <input id="lac_caballo" type="text" placeholder="Ej. 080640" value={formData.lac_caballo}
                onChange={(e) => setFormData({ ...formData, lac_caballo: e.target.value })}
                className="input w-full" />
              <p className="mt-1 text-xs text-gray-500">En RFHE busca por una palabra del nombre y copia el LAC.</p>
            </div>
          </div>

          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <SelectorFederacion id="fh_jinete" etiqueta="Federación (comunidad) del jinete" valor={formData.fh_jinete}
              onChange={(fh_jinete) => setFormData({ ...formData, fh_jinete })} />
            <SelectorFederacion id="fh_caballo" etiqueta="Federación (comunidad) del caballo" valor={formData.fh_caballo}
              onChange={(fh_caballo) => setFormData({ ...formData, fh_caballo })} />
          </div>

          <div>
            <label className="block text-sm font-bold mb-2" htmlFor="licencia_federativa">
              Licencia federativa
            </label>
            <input id="licencia_federativa" type="text" placeholder="Ej. 1478"
              value={formData.licencia_federativa}
              onChange={(e) => setFormData({ ...formData, licencia_federativa: e.target.value })}
              className="input w-full" />
          </div>

          <div className="rounded border border-gray-200 bg-gray-50 p-3 text-sm text-gray-700">
            Los datos se utilizarán para gestionar el binomio, sus categorías e inscripciones.
            Consulta la{' '}
            <Link href="/privacidad" className="text-primary underline">
              política de privacidad
            </Link>
            .
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