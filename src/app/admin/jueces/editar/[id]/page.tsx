'use client';

import { useEffect, useState } from 'react';
import { useRouter, useParams } from 'next/navigation';
import { supabase } from '@/lib/supabase';

type Concurso = {
  id: string;
  nombre: string;
};

type JuezForm = {
  concurso_id: string;
  nombre: string;
  letra_oficial: string;
  experiencia: string;
};

export default function EditarJuezPage() {
  const router = useRouter();
  const params = useParams();

  const juezId = Array.isArray(params.id) ? params.id[0] : params.id;

  const [concursos, setConcursos] = useState<Concurso[]>([]);
  const [loading, setLoading] = useState(true);
  const [loadingConcursos, setLoadingConcursos] = useState(true);
  const [error, setError] = useState('');

  const [formData, setFormData] = useState<JuezForm>({
    concurso_id: '',
    nombre: '',
    letra_oficial: '',
    experiencia: '',
  });

  useEffect(() => {
    const cargarDatos = async () => {
      try {
        setError('');

        const [juezResult, concursosResult] = await Promise.all([
          supabase
            .from('jueces')
            .select(
              'id, concurso_id, nombre, letra_oficial, experiencia'
            )
            .eq('id', juezId)
            .single(),

          supabase
            .from('concursos')
            .select('id, nombre')
            .order('fecha_inicio', { ascending: false }),
        ]);

        if (juezResult.error) {
          throw juezResult.error;
        }

        if (concursosResult.error) {
          throw concursosResult.error;
        }

        if (juezResult.data) {
          setFormData({
            concurso_id: juezResult.data.concurso_id || '',
            nombre: juezResult.data.nombre || '',
            letra_oficial: juezResult.data.letra_oficial || '',
            experiencia: juezResult.data.experiencia || '',
          });
        }

        setConcursos(concursosResult.data || []);
      } catch (err: any) {
        setError(
          err.message || 'Error al cargar los datos del juez'
        );
      } finally {
        setLoading(false);
        setLoadingConcursos(false);
      }
    };

    if (juezId) {
      cargarDatos();
    }
  }, [juezId]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    setLoading(true);
    setError('');

    try {
      if (!formData.concurso_id) {
        throw new Error('Debes seleccionar un concurso');
      }

      if (!formData.nombre.trim()) {
        throw new Error('El nombre del juez es obligatorio');
      }

      if (!formData.letra_oficial.trim()) {
        throw new Error('La letra oficial es obligatoria');
      }

      const { error: dbError } = await supabase
        .from('jueces')
        .update({
          concurso_id: formData.concurso_id,
          nombre: formData.nombre.trim(),
          letra_oficial: formData.letra_oficial
            .trim()
            .toUpperCase(),
          experiencia: formData.experiencia.trim() || null,
        })
        .eq('id', juezId);

      if (dbError) {
        throw dbError;
      }

      router.push('/admin/jueces');
      router.refresh();
    } catch (err: any) {
      setError(
        err.message || 'Error al actualizar el juez'
      );
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <div className="container py-8 text-center">
        Cargando...
      </div>
    );
  }

  return (
    <div className="container max-w-2xl">
      <h1 className="text-3xl font-bold mb-6">
        Editar Juez
      </h1>

      {error && (
        <div className="mb-4 p-4 bg-danger text-white rounded">
          {error}
        </div>
      )}

      <form
        onSubmit={handleSubmit}
        className="card p-6 space-y-4"
      >

        {/* CONCURSO */}
        <div>
          <label className="block font-medium mb-1">
            Concurso *
          </label>

          {loadingConcursos ? (
            <div className="input w-full">
              Cargando concursos...
            </div>
          ) : (
            <select
              required
              className="input w-full"
              value={formData.concurso_id}
              onChange={(e) =>
                setFormData({
                  ...formData,
                  concurso_id: e.target.value,
                })
              }
            >
              <option value="">
                Selecciona un concurso
              </option>

              {concursos.map((concurso) => (
                <option
                  key={concurso.id}
                  value={concurso.id}
                >
                  {concurso.nombre}
                </option>
              ))}
            </select>
          )}
        </div>

        {/* NOMBRE */}
        <div>
          <label className="block font-medium mb-1">
            Nombre completo *
          </label>

          <input
            required
            className="input w-full"
            value={formData.nombre}
            onChange={(e) =>
              setFormData({
                ...formData,
                nombre: e.target.value,
              })
            }
          />
        </div>

        {/* LETRA OFICIAL */}
        <div>
          <label className="block font-medium mb-1">
            Letra oficial *
          </label>

          <input
            required
            maxLength={5}
            className="input w-full"
            value={formData.letra_oficial}
            onChange={(e) =>
              setFormData({
                ...formData,
                letra_oficial: e.target.value,
              })
            }
          />

          <p className="text-sm text-gray-500 mt-1">
            Letra oficial del juez dentro del concurso.
          </p>
        </div>

        {/* EXPERIENCIA */}
        <div>
          <label className="block font-medium mb-1">
            Experiencia
          </label>

          <textarea
            className="input w-full"
            rows={4}
            value={formData.experiencia}
            onChange={(e) =>
              setFormData({
                ...formData,
                experiencia: e.target.value,
              })
            }
            placeholder="Experiencia profesional del juez..."
          />
        </div>

        {/* BOTONES */}
        <div className="flex justify-end gap-3 pt-6">
          <button
            type="button"
            onClick={() => router.back()}
            className="btn btn-outline"
          >
            Cancelar
          </button>

          <button
            type="submit"
            disabled={loading || loadingConcursos}
            className="btn btn-primary"
          >
            {loading ? 'Guardando...' : 'Guardar Cambios'}
          </button>
        </div>

      </form>
    </div>
  );
}
