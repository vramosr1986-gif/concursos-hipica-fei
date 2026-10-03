'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { concursoService } from '@/lib/services';
import { supabase } from '@/lib/supabase';
import {
  CAMPOS_CONCURSO, ConcursoCampos, DatosConcurso, concursoVacio, datosParaGuardar, validarConcurso,
} from '@/components/ConcursoCampos';

interface JuezRow {
  key: string;
  user_id: string;
  nombre: string;
  letra: string;
}

interface UserOption {
  id: string;
  nombre_completo: string;
}

function nuevaFilaJuez(): JuezRow {
  return {
    key: crypto.randomUUID(),
    user_id: '',
    nombre: '',
    letra: '',
  };
}

export default function NuevoConcursoPage() {
  const router = useRouter();
  const [formData, setFormData] = useState<DatosConcurso>(concursoVacio());
  const [desdeRfhe, setDesdeRfhe] = useState(false);
  const [jueces, setJueces] = useState<JuezRow[]>([nuevaFilaJuez()]);
  const [juecesDisponibles, setJuecesDisponibles] = useState<UserOption[]>([]);
  const [juecesError, setJuecesError] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  // Precarga desde "Crear concurso" del calendario RFHE (?nombre=...&fecha_inicio=...).
  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const precarga = Object.fromEntries(
      CAMPOS_CONCURSO.filter((c) => params.get(c)).map((c) => [c, params.get(c) as string])
    );
    if (Object.keys(precarga).length > 0) {
      setFormData((actual) => ({ ...actual, ...precarga }));
      setDesdeRfhe(true);
    }
  }, []);

  useEffect(() => {
    const cargarJueces = async () => {
      setJuecesError('');
      try {
        const { data, error: dbError } = await supabase
          .from('profiles')
          .select('id, nombre, email')
          .eq('rol', 'juez')
          .order('nombre');

        if (dbError) throw new Error(dbError.message);

        setJuecesDisponibles(
          (data || []).map((u) => ({
            id: u.id,
            nombre_completo: u.nombre || u.email,
          }))
        );
      } catch (err) {
        setJuecesError(
          err instanceof Error ? err.message : 'No se pudo cargar el catálogo de jueces'
        );
      }
    };
    cargarJueces();
  }, []);

  const handleJuezChange = (
    key: string,
    campo: keyof Omit<JuezRow, 'key'>,
    valor: string
  ) => {
    setJueces((prev) =>
      prev.map((j) => (j.key === key ? { ...j, [campo]: valor } : j))
    );
  };

  const handleJuezUserSelect = (key: string, userId: string) => {
    const user = juecesDisponibles.find((u) => u.id === userId);
    setJueces((prev) =>
      prev.map((j) =>
        j.key === key
          ? { ...j, user_id: userId, nombre: user?.nombre_completo || '' }
          : j
      )
    );
  };

  const handleAddJuez = () => {
    setJueces((prev) => [...prev, nuevaFilaJuez()]);
  };

  const handleRemoveJuez = (key: string) => {
    setJueces((prev) => prev.filter((j) => j.key !== key));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    const invalido = validarConcurso(formData);
    if (invalido) {
      setError(invalido);
      return;
    }
    setLoading(true);

    try {
      const {
        data: { user },
      } = await supabase.auth.getUser();

      if (!user) {
        setError('Debes iniciar sesión para crear un concurso');
        setLoading(false);
        return;
      }

      // 1. Crear el concurso
      const { data: concurso, error: concursoError } = await concursoService.create({
        ...datosParaGuardar(formData),
        created_by: user.id,
      } as Parameters<typeof concursoService.create>[0]);

      if (concursoError || !concurso) {
        setError(concursoError?.message || 'No se pudo crear el concurso');
        setLoading(false);
        return;
      }

      // 2. Crear los jueces
      const juecesValidos = jueces.filter((j) => j.user_id && j.letra.trim());
      for (const j of juecesValidos) {
        await fetch('/api/jueces', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            concurso_id: concurso.id,
            user_id: j.user_id,
            nombre: j.nombre,
            letra_oficial: j.letra.trim().toUpperCase(),
          }),
        });
      }

      router.push(`/admin/concursos/${concurso.id}`);
    } catch (err: any) {
      setError(err.message || 'Error inesperado al guardar');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="container">
      <div className="max-w-4xl mx-auto">
        <div className="mb-6">
          <h1 className="text-3xl font-bold">Nuevo Concurso</h1>
          {desdeRfhe && (
            <p className="mt-2 text-sm text-gray-600">Datos precargados desde el calendario RFHE. Revísalos antes de guardar.</p>
          )}
        </div>

        {error && <div className="p-4 mb-6 bg-danger text-white rounded">{error}</div>}

        <form onSubmit={handleSubmit} className="card p-6 space-y-8">
          <ConcursoCampos datos={formData} onChange={setFormData} />

          <hr />

          <div className="space-y-4">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-bold">Jueces</h2>
              <button type="button" onClick={handleAddJuez} className="btn btn-secondary text-sm">+ Añadir Juez</button>
            </div>
            {juecesError && <p className="text-sm text-danger">{juecesError}</p>}
            <p className="text-sm text-gray-600">
              Los binomios se inscriben después de crear el concurso.
            </p>
            <div className="space-y-4">
              {jueces.map((j) => (
                <div key={j.key} className="border rounded p-4 grid grid-cols-1 md:grid-cols-3 gap-3 relative">
                  <div className="flex flex-col">
                    <label className="text-xs font-bold mb-1">Seleccionar Juez</label>
                    <select
                      value={j.user_id}
                      onChange={(e) => handleJuezUserSelect(j.key, e.target.value)}
                      className="input"
                    >
                      <option value="">-- Elegir Juez --</option>
                      {juecesDisponibles.map((u) => (
                        <option key={u.id} value={u.id}>{u.nombre_completo}</option>
                      ))}
                    </select>
                  </div>
                  <div className="flex flex-col">
                    <label className="text-xs font-bold mb-1">Nombre (en acta)</label>
                    <input
                      type="text"
                      value={j.nombre}
                      onChange={(e) => handleJuezChange(j.key, 'nombre', e.target.value)}
                      className="input"
                    />
                  </div>
                  <div className="flex flex-col">
                    <label className="text-xs font-bold mb-1">Letra Oficial</label>
                    <input
                      type="text"
                      placeholder="Ej: C"
                      value={j.letra}
                      onChange={(e) => handleJuezChange(j.key, 'letra', e.target.value)}
                      className="input"
                    />
                  </div>
                  {jueces.length > 1 && (
                    <button type="button" onClick={() => handleRemoveJuez(j.key)} className="text-danger text-sm absolute -top-2 -right-2">✕</button>
                  )}
                </div>
              ))}
            </div>
          </div>

          <button type="submit" disabled={loading} className="w-full btn btn-primary disabled:opacity-50">
            {loading ? 'Guardando...' : 'Guardar Concurso'}
          </button>
        </form>
      </div>
    </div>
  );
}