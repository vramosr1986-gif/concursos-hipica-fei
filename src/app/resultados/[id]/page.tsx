'use client';

import { useParams } from 'next/navigation';
import Link from 'next/link';
import { useEffect, useState } from 'react';
import { Binomio } from '@/types';
import { binomioService } from '@/lib/services';

export default function VerNotasPage() {
  const params = useParams();
  const binomioId = params.id as string;
  const [binomio, setBinomio] = useState<Binomio | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      const { data } = await binomioService.getById(binomioId);
      if (data) {
        setBinomio(data);
      }
      setLoading(false);
    };
    fetchData();
  }, [binomioId]);

  if (loading) return <div className="container py-8">Cargando...</div>;
  if (!binomio) return <div className="container py-8">Binomio no encontrado</div>;

  return (
    <div className="container">
      <Link href="/resultados" className="text-primary mb-4 inline-block">← Volver</Link>
      <h1 className="text-3xl font-bold mb-6">Notas de {binomio.nombre_jinete}</h1>
      <div className="card p-6 mb-6">
        <div className="grid grid-cols-2 gap-4">
          <div>
            <p className="text-sm text-gray-600">Jinete</p>
            <p className="font-bold">{binomio.nombre_jinete}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Caballo</p>
            <p className="font-bold">{binomio.nombre_caballo}</p>
          </div>
          <div>
            <p className="text-sm text-gray-600">Dorsal</p>
            <p className="font-bold">{binomio.dorsal}</p>
          </div>
          <div>
          </div>
        </div>
      </div>
      
      <div className="card p-6">
        <h2 className="text-xl font-bold mb-4">Puntuaciones por Juez</h2>
        <p className="text-gray-600">Las puntuaciones se mostrarán aquí cuando los jueces completen la puntuación</p>
      </div>
    </div>
  );
}