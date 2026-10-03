'use client';

import { useParams, useRouter } from 'next/navigation';
import Link from 'next/link';
import { useEffect, useState } from 'react';
import { Concurso } from '@/types';
import { concursoService } from '@/lib/services';
import { supabase } from '@/lib/supabase';
import { PruebasSection } from './PruebasSection';
import { ImportarRfhe } from '@/components/ImportarRfhe';
import { InscripcionesSection } from './InscripcionesSection';
import {
  ConcursoCampos, DatosConcurso, concursoVacio, datosParaGuardar, validarConcurso,
} from '@/components/ConcursoCampos';

// ============================================================
// TIPOS
// ============================================================

interface JuezResumen {
  juez_id: string;
  nombre: string;
  email: string;
  num_pruebas: number;
  letras: string;
  pruebas: string;
}

// ============================================================
// COMPONENTE PRINCIPAL
// ============================================================

export default function EditarConcursoPage() {
  const params = useParams();
  const router = useRouter();
  const concursoId = params.id as string;

  const [concurso, setConcurso] = useState<Concurso | null>(null);
  const [formData, setFormData] = useState<DatosConcurso>(concursoVacio());
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState('');
  const [recarga, setRecarga] = useState(0);

  const [juecesResumen, setJuecesResumen] = useState<JuezResumen[]>([]);

  // ============================================================
  // CARGA DE DATOS
  // ============================================================

  const cargarJuecesResumen = async () => {
    const { data: pruebas } = await supabase
      .from('pruebas')
      .select('id, nombre')
      .eq('concurso_id', concursoId);

    if (!pruebas || pruebas.length === 0) {
      setJuecesResumen([]);
      return;
    }

    const pruebaIds = pruebas.map((p: any) => p.id);

    const { data: asignaciones } = await supabase
      .from('prueba_jueces')
      .select('juez_id, letra, prueba_id, juez:juez_id(nombre, email)')
      .in('prueba_id', pruebaIds);

    if (!asignaciones || asignaciones.length === 0) {
      setJuecesResumen([]);
      return;
    }

    const mapaJueces: Record<string, JuezResumen> = {};

    for (const a of asignaciones as any[]) {
      const juezId = a.juez_id;
      const prueba = pruebas.find((p: any) => p.id === a.prueba_id);

      if (!mapaJueces[juezId]) {
        mapaJueces[juezId] = {
          juez_id: juezId,
          nombre: a.juez?.nombre || 'Sin nombre',
          email: a.juez?.email || '',
          num_pruebas: 0,
          letras: '',
          pruebas: '',
        };
      }

      mapaJueces[juezId].num_pruebas += 1;

      if (!mapaJueces[juezId].letras.includes(a.letra)) {
        mapaJueces[juezId].letras = mapaJueces[juezId].letras
          ? mapaJueces[juezId].letras + ', ' + a.letra
          : a.letra;
      }

      if (prueba && !mapaJueces[juezId].pruebas.includes(prueba.nombre)) {
        mapaJueces[juezId].pruebas = mapaJueces[juezId].pruebas
          ? mapaJueces[juezId].pruebas + ', ' + prueba.nombre
          : prueba.nombre;
      }
    }

    setJuecesResumen(Object.values(mapaJueces));
  };

  useEffect(() => {
    const fetchConcurso = async () => {
      const { data } = await concursoService.getById(concursoId);
      if (data) {
        setConcurso(data);
        setFormData({
          nombre: data.nombre,
          tipo: data.tipo || '',
          fecha_inicio: data.fecha_inicio,
          fecha_fin: data.fecha_fin,
          provincia: data.provincia || '',
          ubicacion: data.ubicacion || '',
          organizador: data.organizador || '',
          federacion: data.federacion || '',
        });
      }
      await cargarJuecesResumen();
      setLoading(false);
    };
    fetchConcurso();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [concursoId]);

  // ============================================================
  // GUARDAR
  // ============================================================

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSaveError('');
    const invalido = validarConcurso(formData);
    if (invalido) {
      setSaveError(invalido);
      return;
    }
    setSaving(true);
    const { error } = await concursoService.update(concursoId, datosParaGuardar(formData) as Partial<Concurso>);
    setSaving(false);
    if (error) {
      setSaveError(error.message);
      return;
    }
    router.push('/admin/concursos');
  };

  if (loading) return <div className="container py-8">Cargando...</div>;
  if (!concurso) return <div className="container py-8">Concurso no encontrado</div>;

  return (
    <div className="container">
      <Link href="/admin/concursos" className="text-primary mb-4 inline-block">
        Volver
      </Link>
      <h1 className="text-3xl font-bold mb-6">Editar Concurso</h1>

      {/* DATOS DEL CONCURSO */}
      <div className="card p-6 max-w-4xl mb-8">
        <form onSubmit={handleSubmit} className="space-y-4">
          {saveError && <div className="p-3 bg-danger text-white rounded text-sm">{saveError}</div>}
          <ConcursoCampos datos={formData} onChange={setFormData} />
          <button type="submit" className="btn btn-primary" disabled={saving}>
            {saving ? 'Guardando...' : 'Guardar Cambios'}
          </button>
        </form>
      </div>

      {/* PARTICIPANTES DE LA RFHE (actualizar o importar por primera vez) */}
      <ImportarRfhe
        concursoId={concursoId}
        urlGuardada={concurso.rfhe_url}
        onImportado={() => {
          concursoService.getById(concursoId).then(({ data }) => data && setConcurso(data));
          cargarJuecesResumen();
          setRecarga((n) => n + 1);
        }}
      />

      {/* INSCRIPCIONES */}
      <InscripcionesSection key={`insc-${recarga}`} concursoId={concursoId} esRfhe={Boolean(concurso.rfhe_url)} />

      {/* RESUMEN DE JUECES */}
      <div className="card p-6 max-w-4xl mb-8">
        <div className="flex items-center justify-between mb-4">
          <div>
            <h2 className="text-xl font-bold">Jueces asignados en este concurso</h2>
            <p className="text-sm text-gray-600 mt-1">
              Resumen de todos los jueces asignados a las pruebas del concurso
            </p>
          </div>
          <div className="text-right">
            <p className="text-xs text-gray-500">Total jueces</p>
            <p className="text-2xl font-bold">{juecesResumen.length}</p>
          </div>
        </div>

        {juecesResumen.length === 0 ? (
          <div className="text-center py-8 text-gray-600">
            <p>No hay jueces asignados a ninguna prueba todavia.</p>
            <p className="text-sm mt-2">Asigna jueces desde el detalle de cada prueba.</p>
          </div>
        ) : (
          <div className="table-responsive">
            <table className="table">
              <thead>
                <tr>
                  <th>Juez</th>
                  <th>Email</th>
                  <th className="text-center">Pruebas</th>
                  <th>Letras</th>
                  <th>Asignado en</th>
                </tr>
              </thead>
              <tbody>
                {juecesResumen.map((j) => (
                  <tr key={j.juez_id}>
                    <td className="font-medium">{j.nombre}</td>
                    <td className="text-sm text-gray-600">{j.email}</td>
                    <td className="text-center">
                      <span className="px-2 py-1 rounded text-xs bg-blue-100 text-blue-800 font-medium">
                        {j.num_pruebas}
                      </span>
                    </td>
                    <td>
                      <span className="font-mono text-sm">{j.letras}</span>
                    </td>
                    <td className="text-sm text-gray-600">{j.pruebas}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* PRUEBAS */}
      <PruebasSection key={`pruebas-${recarga}`} concursoId={concursoId} esRfhe={Boolean(concurso.rfhe_url)} fechaInicio={concurso.fecha_inicio} fechaFin={concurso.fecha_fin} />

    </div>
  );
}