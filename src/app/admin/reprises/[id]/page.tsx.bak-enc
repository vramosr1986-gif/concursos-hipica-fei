'use client';

import { useEffect, useState } from 'react';
import { useParams } from 'next/navigation';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

type Reprise = {
  id: string;
  codigo: string;
  nombre: string;
  categoria: string;
  nivel: string | null;
  tipo: string | null;
  anio: number | null;
  tiempo_orientativo: string | null;
  edad_minima_caballo: number | null;
  total_maximo: number | null;
  reprise_oficial: string | null;
  descripcion: string | null;
};

type Ejercicio = {
  id: string;
  numero_orden: number;
  letra: string | null;
  descripcion: string;
  coeficiente: number;
  puntuacion_max: number;
  tipo: string;
};

export default function DetalleReprisePage() {
  const params = useParams();
  const repriseId = params.id as string;

  const [reprise, setReprise] = useState<Reprise | null>(null);
  const [ejercicios, setEjercicios] = useState<Ejercicio[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    const cargarDatos = async () => {
      try {
        const { data: repriseData, error: repriseError } = await supabase
          .from('reprises')
          .select('*')
          .eq('id', repriseId)
          .single();

        if (repriseError) throw repriseError;
        setReprise(repriseData);

        const { data: ejerciciosData, error: ejerciciosError } = await supabase
          .from('ejercicios_reprise')
          .select('*')
          .eq('reprise_id', repriseId)
          .order('numero_orden', { ascending: true });

        if (ejerciciosError) throw ejerciciosError;
        setEjercicios(ejerciciosData || []);
      } catch (err: any) {
        setError(err.message || 'Error al cargar la reprise');
      } finally {
        setLoading(false);
      }
    };

    if (repriseId) cargarDatos();
  }, [repriseId]);

  if (loading) {
    return <div className="container py-8 text-center">Cargando...</div>;
  }

  if (error || !reprise) {
    return (
      <div className="container py-8">
        <div className="card p-8 text-center">
          <p className="text-danger font-bold">
            {error || 'Reprise no encontrada'}
          </p>
          <Link href="/admin/reprises" className="btn btn-primary mt-4">
            Volver al listado
          </Link>
        </div>
      </div>
    );
  }

  const movimientos = ejercicios.filter((e) => e.tipo === 'movimiento');
  const notasConjunto = ejercicios.filter((e) => e.tipo === 'nota_conjunto');
  const notasArtisticas = ejercicios.filter((e) => e.tipo === 'nota_artistica');

  return (
    <div className="container max-w-7xl py-8">
      <Link
        href="/admin/reprises"
        className="text-primary mb-4 inline-block hover:underline"
      >
        Ã¢â€ Â Volver al listado
      </Link>

      {/* Cabecera */}
      <div className="card p-6 mb-6">
        <div className="flex items-start justify-between gap-6">
          <div>
            <h1 className="text-3xl font-bold mb-2">{reprise.nombre}</h1>
            <p className="text-sm font-mono text-gray-500 mb-4">
              {reprise.codigo}
            </p>

            <div className="grid md:grid-cols-2 gap-x-8 gap-y-2 text-sm">
              <div>
                <strong>CategorÃƒÂ­a:</strong>{' '}
                <span className="text-gray-700">{reprise.categoria}</span>
              </div>
              {reprise.nivel && (
                <div>
                  <strong>Nivel:</strong>{' '}
                  <span className="text-gray-700">{reprise.nivel}</span>
                </div>
              )}
              {reprise.tipo && (
                <div>
                  <strong>Tipo:</strong>{' '}
                  <span className="text-gray-700">{reprise.tipo}</span>
                </div>
              )}
              {reprise.anio && (
                <div>
                  <strong>AÃƒÂ±o:</strong>{' '}
                  <span className="text-gray-700">{reprise.anio}</span>
                </div>
              )}
              {reprise.tiempo_orientativo && (
                <div>
                  <strong>Tiempo orientativo:</strong>{' '}
                  <span className="text-gray-700">
                    {reprise.tiempo_orientativo}
                  </span>
                </div>
              )}
              {reprise.edad_minima_caballo && (
                <div>
                  <strong>Edad mÃƒÂ­nima caballo:</strong>{' '}
                  <span className="text-gray-700">
                    {reprise.edad_minima_caballo} aÃƒÂ±os
                  </span>
                </div>
              )}
              {reprise.total_maximo && (
                <div>
                  <strong>Puntos mÃƒÂ¡ximos:</strong>{' '}
                  <span className="text-gray-700">{reprise.total_maximo}</span>
                </div>
              )}
            </div>

            {reprise.descripcion && (
              <p className="text-gray-600 mt-4 italic">
                {reprise.descripcion}
              </p>
            )}
          </div>

          <div className="text-right">
            <p className="text-sm text-gray-500">Ejercicios</p>
            <p className="text-4xl font-bold">{ejercicios.length}</p>
          </div>
        </div>
      </div>

      {/* Movimientos */}
      {movimientos.length > 0 && (
        <div className="card overflow-hidden mb-6">
          <div className="p-4 border-b bg-gray-50">
            <h2 className="text-xl font-bold">
              Movimientos ({movimientos.length})
            </h2>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b bg-gray-50">
                  <th className="text-center p-3 w-16">NÃ‚Âº</th>
                  <th className="text-left p-3 w-32">Letra</th>
                  <th className="text-left p-3">DescripciÃƒÂ³n</th>
                  <th className="text-center p-3 w-20">Coef.</th>
                  <th className="text-center p-3 w-20">Punt. Max</th>
                </tr>
              </thead>
              <tbody>
                {movimientos.map((e) => (
                  <tr key={e.id} className="border-b hover:bg-gray-50">
                    <td className="p-3 text-center font-bold text-gray-700">
                      {e.numero_orden}
                    </td>
                    <td className="p-3 font-mono text-sm text-blue-700">
                      {e.letra || '-'}
                    </td>
                    <td className="p-3">{e.descripcion}</td>
                    <td className="p-3 text-center">
                      {e.coeficiente > 1 ? (
                        <span className="px-2 py-1 rounded text-xs font-bold bg-amber-100 text-amber-800">
                          x{e.coeficiente}
                        </span>
                      ) : (
                        <span className="text-gray-400">1</span>
                      )}
                    </td>
                    <td className="p-3 text-center text-gray-600">
                      {e.puntuacion_max}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Notas de conjunto */}
      {notasConjunto.length > 0 && (
        <div className="card overflow-hidden mb-6">
          <div className="p-4 border-b bg-gray-50">
            <h2 className="text-xl font-bold">
              Notas de conjunto ({notasConjunto.length})
            </h2>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b bg-gray-50">
                  <th className="text-center p-3 w-16">NÃ‚Âº</th>
                  <th className="text-left p-3 w-32">CÃƒÂ³digo</th>
                  <th className="text-left p-3">DescripciÃƒÂ³n</th>
                  <th className="text-center p-3 w-20">Coef.</th>
                </tr>
              </thead>
              <tbody>
                {notasConjunto.map((e) => (
                  <tr key={e.id} className="border-b hover:bg-gray-50">
                    <td className="p-3 text-center font-bold text-gray-700">
                      {e.numero_orden}
                    </td>
                    <td className="p-3 font-mono text-sm text-blue-700">
                      {e.letra || '-'}
                    </td>
                    <td className="p-3">{e.descripcion}</td>
                    <td className="p-3 text-center">
                      {e.coeficiente > 1 ? (
                        <span className="px-2 py-1 rounded text-xs font-bold bg-amber-100 text-amber-800">
                          x{e.coeficiente}
                        </span>
                      ) : (
                        <span className="text-gray-400">1</span>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {/* Notas artÃƒÂ­sticas */}
      {notasArtisticas.length > 0 && (
        <div className="card overflow-hidden mb-6">
          <div className="p-4 border-b bg-purple-50">
            <h2 className="text-xl font-bold text-purple-900">
              Notas artÃƒÂ­sticas (KÃƒÂ¼r) ({notasArtisticas.length})
            </h2>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b bg-purple-50">
                  <th className="text-center p-3 w-16">NÃ‚Âº</th>
                  <th className="text-left p-3 w-32">CÃƒÂ³digo</th>
                  <th className="text-left p-3">DescripciÃƒÂ³n</th>
                  <th className="text-center p-3 w-20">Coef.</th>
                </tr>
              </thead>
              <tbody>
                {notasArtisticas.map((e) => (
                  <tr key={e.id} className="border-b hover:bg-purple-50">
                    <td className="p-3 text-center font-bold text-gray-700">
                      {e.numero_orden}
                    </td>
                    <td className="p-3 font-mono text-sm text-purple-700">
                      {e.letra || '-'}
                    </td>
                    <td className="p-3">{e.descripcion}</td>
                    <td className="p-3 text-center">
                      <span className="px-2 py-1 rounded text-xs font-bold bg-purple-100 text-purple-800">
                        x{e.coeficiente}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {ejercicios.length === 0 && (
        <div className="card p-8 text-center text-gray-600">
          Esta reprise no tiene ejercicios registrados.
        </div>
      )}
    </div>
  );
}