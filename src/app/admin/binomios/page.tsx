'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

type BinomioConCategoria = {
  binomio_id: string;
  nombre_jinete: string;
  nombre_caballo: string;
  fecha_nacimiento_jinete: string | null;
  anio_nacimiento_caballo: number | null;
  edad_jinete: number | null;
  edad_caballo: number | null;
  categoria_jinete: string | null;
  categoria_caballo: string | null;
  categoria_principal: string | null;
  licencia_federativa: string | null;
};

const COLOR_CATEGORIA: Record<string, string> = {
  ALEVIN: 'bg-pink-100 text-pink-800',
  INFANTIL: 'bg-orange-100 text-orange-800',
  JUVENIL: 'bg-green-100 text-green-800',
  JOVEN_JINETE: 'bg-teal-100 text-teal-800',
  ADULTO: 'bg-blue-100 text-blue-800',
  CJ4: 'bg-purple-100 text-purple-800',
  CJ5: 'bg-purple-100 text-purple-800',
  CJ6: 'bg-purple-100 text-purple-800',
  CJ7: 'bg-purple-100 text-purple-800',
  CJ8_10: 'bg-amber-100 text-amber-800',
  CABALLO_ADULTO: 'bg-slate-100 text-slate-700',
};

const NOMBRE_CATEGORIA: Record<string, string> = {
  ALEVIN: 'Alevin',
  INFANTIL: 'Infantil',
  JUVENIL: 'Juvenil',
  JOVEN_JINETE: 'Joven Jinete',
  ADULTO: 'Adulto',
  CJ4: 'CJ 4 anos',
  CJ5: 'CJ 5 anos',
  CJ6: 'CJ 6 anos',
  CJ7: 'CJ 7 anos',
  CJ8_10: 'CJ 8-10 anos',
  CABALLO_ADULTO: 'Caballo adulto',
};

export default function AdminBinomiosPage() {
  const router = useRouter();

  const [binomios, setBinomios] = useState<BinomioConCategoria[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const cargarBinomios = async () => {
    setLoading(true);
    setError('');

    try {
      const { data, error: dbError } = await supabase
        .from('v_binomios_categorias')
        .select('binomio_id, nombre_jinete, nombre_caballo, fecha_nacimiento_jinete, anio_nacimiento_caballo, edad_jinete, edad_caballo, categoria_jinete, categoria_caballo, categoria_principal')
        .order('nombre_jinete', { ascending: true });

      if (dbError) throw dbError;

      // Enriquecer con licencia_federativa desde la tabla original
      const ids = (data || []).map((b: any) => b.binomio_id);
      let licencias: Record<string, string | null> = {};

      if (ids.length > 0) {
        const { data: binomiosData } = await supabase
          .from('binomios')
          .select('id, licencia_federativa')
          .in('id', ids);

        (binomiosData || []).forEach((b: any) => {
          licencias[b.id] = b.licencia_federativa;
        });
      }

      const enriquecidos: BinomioConCategoria[] = (data || []).map((b: any) => ({
        ...b,
        licencia_federativa: licencias[b.binomio_id] || null,
      }));

      setBinomios(enriquecidos);
    } catch (err: any) {
      setError(err.message || 'Error al cargar los binomios');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    cargarBinomios();
  }, []);

  const eliminarBinomio = async (id: string, jinete: string, caballo: string) => {
    const confirmar = window.confirm(
      'Eliminar el binomio ' + jinete + ' / ' + caballo + '? Se eliminaran tambien sus inscripciones en todos los concursos.'
    );
    if (!confirmar) return;

    try {
      const { error: dbError } = await supabase
        .from('binomios')
        .delete()
        .eq('id', id);

      if (dbError) throw dbError;

      setBinomios((actuales) => actuales.filter((b) => b.binomio_id !== id));
    } catch (err: any) {
      alert(err.message || 'Error al eliminar el binomio');
    }
  };

  const chipCategoria = (cat: string | null) => {
    if (!cat) return <span className="text-gray-400 text-xs">-</span>;
    const color = COLOR_CATEGORIA[cat] || 'bg-gray-100 text-gray-800';
    const nombre = NOMBRE_CATEGORIA[cat] || cat;
    return (
      <span className={'px-2 py-0.5 rounded text-xs font-medium ' + color}>
        {nombre}
      </span>
    );
  };

  return (
    <div className="container max-w-7xl py-8">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-3xl font-bold">Binomios</h1>
          <p className="text-gray-600 mt-1">
            Catalogo de jinetes y caballos con su categoria oficial calculada
          </p>
        </div>

        <button
          onClick={() => router.push('/admin/binomios/nuevo')}
          className="btn btn-primary"
        >
          + Nuevo Binomio
        </button>
      </div>

      {error && (
        <div className="mb-4 p-4 bg-red-100 border border-red-300 text-red-700 rounded">
          {error}
        </div>
      )}

      {loading ? (
        <div className="card p-6 text-center">Cargando binomios...</div>
      ) : binomios.length === 0 ? (
        <div className="card p-8 text-center">
          <h2 className="text-xl font-semibold mb-2">No hay binomios registrados</h2>
          <p className="text-gray-600 mb-4">Anade el primer binomio al catalogo.</p>
          <button
            onClick={() => router.push('/admin/binomios/nuevo')}
            className="btn btn-primary"
          >
            + Registrar primer binomio
          </button>
        </div>
      ) : (
        <div className="card overflow-hidden">
          <div className="p-4 border-b bg-gray-50">
            <strong>{binomios.length}</strong>{' '}
            {binomios.length === 1 ? 'binomio registrado' : 'binomios registrados'}
          </div>

          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b bg-gray-50">
                  <th className="text-left p-3">Jinete</th>
                  <th className="text-left p-3">Caballo</th>
                  <th className="text-center p-3">Edad jinete</th>
                  <th className="text-center p-3">Cat. jinete</th>
                  <th className="text-center p-3">Edad caballo</th>
                  <th className="text-center p-3">Cat. caballo</th>
                  <th className="text-center p-3">Categoria principal</th>
                  <th className="text-left p-3">Licencia</th>
                  <th className="text-right p-3">Acciones</th>
                </tr>
              </thead>

              <tbody>
                {binomios.map((b) => (
                  <tr key={b.binomio_id} className="border-b hover:bg-gray-50">
                    <td className="p-3 font-medium">{b.nombre_jinete}</td>
                    <td className="p-3">{b.nombre_caballo}</td>
                    <td className="p-3 text-center text-sm text-gray-600">
                      {b.edad_jinete !== null ? b.edad_jinete + ' anos' : '-'}
                    </td>
                    <td className="p-3 text-center">{chipCategoria(b.categoria_jinete)}</td>
                    <td className="p-3 text-center text-sm text-gray-600">
                      {b.edad_caballo !== null ? b.edad_caballo + ' anos' : '-'}
                    </td>
                    <td className="p-3 text-center">{chipCategoria(b.categoria_caballo)}</td>
                    <td className="p-3 text-center">
                      <span className="font-medium">{chipCategoria(b.categoria_principal)}</span>
                    </td>
                    <td className="p-3 text-sm text-gray-600">
                      {b.licencia_federativa || '-'}
                    </td>
                    <td className="p-3 text-right">
                      <div className="flex gap-2 justify-end">
                        <Link
                          href={'/admin/binomios/' + b.binomio_id}
                          className="btn btn-outline text-sm"
                        >
                          Editar
                        </Link>
                        <button
                          onClick={() =>
                            eliminarBinomio(b.binomio_id, b.nombre_jinete, b.nombre_caballo)
                          }
                          className="btn btn-outline text-danger text-sm"
                        >
                          Eliminar
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}