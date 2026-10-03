'use client';

import { useEffect, useState } from 'react';
import { useParams, useRouter } from 'next/navigation';
import Link from 'next/link';
import { SelectorFederacion } from '@/components/BanderaFH';
import { fetchConSesion } from '@/lib/juez-actual';
import { supabase } from '@/lib/supabase';
import { ConsultaRfhe } from '@/components/ConsultaRfhe';

type Binomio = {
  id: string;
  nombre_jinete: string;
  nombre_caballo: string;
  licencia_federativa: string | null;
  ldn_jinete: string | null;
  lac_caballo: string | null;
};

export default function EditarBinomioPage() {
  const params = useParams();
  const router = useRouter();
  const binomioId = params.id as string;

  const [binomio, setBinomio] = useState<Binomio | null>(null);
  const [formData, setFormData] = useState({
    nombre_jinete: '',
    nombre_caballo: '',
    licencia_federativa: '',
    ldn_jinete: '',
    lac_caballo: '',
    fh_jinete: '',
    fh_caballo: '',
  });
  const [loading, setLoading] = useState(true);
  const [guardando, setGuardando] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    const cargar = async () => {
      try {
        const { data, error: dbErr } = await supabase
          .from('binomios')
          .select('id, nombre_jinete, nombre_caballo, licencia_federativa, ldn_jinete, lac_caballo, fh_jinete, fh_caballo')
          .eq('id', binomioId)
          .single();

        if (dbErr) throw dbErr;

        setBinomio(data);
        setFormData({
          nombre_jinete: data.nombre_jinete || '',
          nombre_caballo: data.nombre_caballo || '',
          licencia_federativa: data.licencia_federativa || '',
          ldn_jinete: data.ldn_jinete || '',
          lac_caballo: data.lac_caballo || '',
          fh_jinete: data.fh_jinete || '',
          fh_caballo: data.fh_caballo || '',
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
      const res = await fetchConSesion('/api/binomios', {
        method: 'PUT',
        body: JSON.stringify({
          id: binomioId,
          nombre_jinete: formData.nombre_jinete.trim(),
          nombre_caballo: formData.nombre_caballo.trim(),
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

          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-bold mb-2">
                LDN del jinete
              </label>
              <input
                type="text"
                placeholder="Ej. 12345678"
                value={formData.ldn_jinete}
                onChange={(e) =>
                  setFormData({ ...formData, ldn_jinete: e.target.value })
                }
                className="input w-full"
              />
              <p className="text-xs text-gray-500 mt-1">
                Número de licencia de RFHE
              </p>
            </div>

            <div>
              <label className="block text-sm font-bold mb-2">
                LAC del caballo
              </label>
              <input
                type="text"
                placeholder="Ej. 87654321"
                value={formData.lac_caballo}
                onChange={(e) =>
                  setFormData({ ...formData, lac_caballo: e.target.value })
                }
                className="input w-full"
              />
              <p className="text-xs text-gray-500 mt-1">
                Número de registro de RFHE
              </p>
            </div>
          </div>

          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <SelectorFederacion id="fh_jinete" etiqueta="Federación (comunidad) del jinete" valor={formData.fh_jinete}
              onChange={(fh_jinete) => setFormData({ ...formData, fh_jinete })} />
            <SelectorFederacion id="fh_caballo" etiqueta="Federación (comunidad) del caballo" valor={formData.fh_caballo}
              onChange={(fh_caballo) => setFormData({ ...formData, fh_caballo })} />
          </div>

          <div>
            <div className="flex items-center justify-between mb-2">
              <label className="text-sm font-bold">RFHE</label>
              <button
                type="button"
                onClick={() => window.open('https://www.cbservicios.net/Magic94Scripts/Mgrqispi94.dll?APPNAME=CBRFHE&PRGNAME=RFHEBUSJIN', '_blank')}
                className="btn btn-sm btn-outline text-xs"
              >
                🔍 Buscar LDN
              </button>
            </div>
            <div className="flex items-center justify-between">
              <div></div>
              <button
                type="button"
                onClick={() => window.open('https://www.cbservicios.net/Magic94Scripts/Mgrqispi94.dll?APPNAME=CBRFHE&PRGNAME=RFHEBUSCAB', '_blank')}
                className="btn btn-sm btn-outline text-xs"
              >
                🔍 Buscar LAC
              </button>
            </div>
            <ConsultaRfhe />
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