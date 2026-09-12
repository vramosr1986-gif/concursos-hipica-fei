'use client';

import { useParams, useRouter } from 'next/navigation';
import Link from 'next/link';
import { useEffect, useState } from 'react';
import { Concurso } from '@/types';
import { concursoService } from '@/lib/services';
import { supabase } from '@/lib/supabase';
import { PruebasSection } from './PruebasSection';
import { EquiposSection } from './EquiposSection';

// ============================================================
// TIPOS
// ============================================================

interface Inscripcion {
  id: string;
  binomio_id: string;
  concurso_id: string;
  dorsal: number;
  categoria: string | null;
  categoria_edad_id: string | null;
  orden_salida: number | null;
  binomio: {
    id: string;
    nombre_jinete: string;
    nombre_caballo: string;
    anio: number | null;
    licencia_federativa: string | null;
  };
}

interface BinomioCatalogo {
  id: string;
  nombre_jinete: string;
  nombre_caballo: string;
  categoria_principal: string | null;
  edad_jinete: number | null;
  edad_caballo: number | null;
  categoria_jinete: string | null;
  categoria_caballo: string | null;
}

interface CategoriaEdad {
  id: string;
  codigo: string;
  nombre: string;
  orden: number | null;
}

interface NuevaInscripcionForm {
  binomio_id: string;
  dorsal: string;
  categoria_edad_id: string;
}

interface JuezResumen {
  juez_id: string;
  nombre: string;
  email: string;
  num_pruebas: number;
  letras: string;
  pruebas: string;
}

function inscripcionVacia(): NuevaInscripcionForm {
  return { binomio_id: '', dorsal: '', categoria_edad_id: '' };
}

// ============================================================
// COMPONENTE PRINCIPAL
// ============================================================

export default function EditarConcursoPage() {
  const params = useParams();
  const router = useRouter();
  const concursoId = params.id as string;

  const [concurso, setConcurso] = useState<Concurso | null>(null);
  const [formData, setFormData] = useState({
    nombre: '',
    fecha_inicio: '',
    fecha_fin: '',
    ubicacion: '',
    organizador: '',
  });
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);

  const [inscripciones, setInscripciones] = useState<Inscripcion[]>([]);
  const [nuevaInscripcion, setNuevaInscripcion] = useState<NuevaInscripcionForm>(inscripcionVacia());
  const [inscripcionError, setInscripcionError] = useState('');
  const [guardandoInscripcion, setGuardandoInscripcion] = useState(false);

  const [binomiosCatalogo, setBinomiosCatalogo] = useState<BinomioCatalogo[]>([]);
  const [categorias, setCategorias] = useState<CategoriaEdad[]>([]);
  const [categoriaSugerida, setCategoriaSugerida] = useState<string | null>(null);
  const [juecesResumen, setJuecesResumen] = useState<JuezResumen[]>([]);

  const [modalCoherencia, setModalCoherencia] = useState<{
    abierto: boolean;
    sugeridaId: string;
    sugeridaNombre: string;
    elegidaId: string;
    elegidaNombre: string;
  }>({ abierto: false, sugeridaId: '', sugeridaNombre: '', elegidaId: '', elegidaNombre: '' });

  // ============================================================
  // CARGA DE DATOS
  // ============================================================

  const cargarInscripciones = async () => {
    const res = await fetch('/api/inscripciones?concursoId=' + concursoId);
    if (res.ok) {
      const data = await res.json();
      setInscripciones(data || []);
    }
  };

  const cargarBinomiosCatalogo = async () => {
    const { data } = await supabase
      .from('v_binomios_categorias')
      .select('binomio_id, nombre_jinete, nombre_caballo, categoria_principal, edad_jinete, edad_caballo, categoria_jinete, categoria_caballo')
      .order('nombre_jinete');
    if (data) {
      setBinomiosCatalogo(
        data.map((b: any) => ({
          id: b.binomio_id,
          nombre_jinete: b.nombre_jinete,
          nombre_caballo: b.nombre_caballo,
          categoria_principal: b.categoria_principal,
          edad_jinete: b.edad_jinete,
          edad_caballo: b.edad_caballo,
          categoria_jinete: b.categoria_jinete,
          categoria_caballo: b.categoria_caballo,
        }))
      );
    }
  };

  const cargarCategorias = async () => {
    const { data } = await supabase
      .from('categorias_edad')
      .select('id, codigo, nombre, orden')
      .order('orden');
    if (data) setCategorias(data);
  };

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
          fecha_inicio: data.fecha_inicio,
          fecha_fin: data.fecha_fin,
          ubicacion: data.ubicacion || '',
          organizador: data.organizador || '',
        });
      }
      await Promise.all([
        cargarInscripciones(),
        cargarBinomiosCatalogo(),
        cargarCategorias(),
        cargarJuecesResumen(),
      ]);
      setLoading(false);
    };
    fetchConcurso();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [concursoId]);

  // ============================================================
  // LOGICA: al elegir binomio, preseleccionar categoria sugerida
  // ============================================================

  const handleSeleccionarBinomio = (binomioId: string) => {
    const binomio = binomiosCatalogo.find((b) => b.id === binomioId);
    const sugeridaCodigo = binomio?.categoria_principal || null;
    const sugeridaObj = sugeridaCodigo
      ? categorias.find((c) => c.codigo === sugeridaCodigo)
      : null;

    setCategoriaSugerida(sugeridaCodigo);
    setNuevaInscripcion({
      ...nuevaInscripcion,
      binomio_id: binomioId,
      categoria_edad_id: sugeridaObj?.id || '',
    });
  };

  const handleCambiarCategoria = (categoriaId: string) => {
    setNuevaInscripcion({ ...nuevaInscripcion, categoria_edad_id: categoriaId });

    // Si el admin cambia la categoria y NO coincide con la sugerida, avisar
    if (categoriaSugerida && categoriaId) {
      const sugeridaObj = categorias.find((c) => c.codigo === categoriaSugerida);
      const elegidaObj = categorias.find((c) => c.id === categoriaId);

      if (sugeridaObj && elegidaObj && sugeridaObj.id !== elegidaObj.id) {
        setModalCoherencia({
          abierto: true,
          sugeridaId: sugeridaObj.id,
          sugeridaNombre: sugeridaObj.nombre,
          elegidaId: elegidaObj.id,
          elegidaNombre: elegidaObj.nombre,
        });
      }
    }
  };

  // ============================================================
  // GUARDAR
  // ============================================================

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSaving(true);
    const { error } = await concursoService.update(concursoId, formData);
    setSaving(false);
    if (!error) {
      router.push('/admin/concursos');
    }
  };

  const handleAddInscripcion = async (e: React.FormEvent) => {
    e.preventDefault();
    setInscripcionError('');

    if (!nuevaInscripcion.binomio_id) {
      setInscripcionError('Debes seleccionar un binomio');
      return;
    }

    if (!nuevaInscripcion.dorsal.trim()) {
      setInscripcionError('El dorsal es obligatorio');
      return;
    }

    if (!nuevaInscripcion.categoria_edad_id) {
      setInscripcionError('La categoria es obligatoria');
      return;
    }

    setGuardandoInscripcion(true);
    try {
      const categoriaObj = categorias.find((c) => c.id === nuevaInscripcion.categoria_edad_id);

      const res = await fetch('/api/inscripciones', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          binomio_id: nuevaInscripcion.binomio_id,
          concurso_id: concursoId,
          dorsal: parseInt(nuevaInscripcion.dorsal, 10),
          categoria: categoriaObj?.nombre || null,
          categoria_edad_id: nuevaInscripcion.categoria_edad_id,
          orden_salida: inscripciones.length + 1,
        }),
      });

      if (!res.ok) {
        const body = await res.json().catch(() => ({}));
        setInscripcionError(body.error || 'No se pudo guardar la inscripcion');
        return;
      }

      setNuevaInscripcion(inscripcionVacia());
      setCategoriaSugerida(null);
      await cargarInscripciones();
    } finally {
      setGuardandoInscripcion(false);
    }
  };

  const handleDeleteInscripcion = async (id: string) => {
    if (!confirm('Eliminar esta inscripcion?')) return;
    const res = await fetch('/api/inscripciones?id=' + id, { method: 'DELETE' });
    if (res.ok) {
      setInscripciones(inscripciones.filter((i) => i.id !== id));
    } else {
      const body = await res.json().catch(() => ({}));
      setInscripcionError(body.error || 'No se pudo eliminar la inscripcion');
    }
  };

  // ============================================================
  // HELPERS
  // ============================================================

  const formatearEdad = (edad: number | null) => {
    if (edad === null || edad === undefined) return '-';
    return edad + ' anos';
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
      <div className="card p-6 max-w-2xl mb-8">
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block font-bold mb-2">Nombre</label>
            <input
              type="text"
              value={formData.nombre}
              onChange={(e) => setFormData({ ...formData, nombre: e.target.value })}
              className="input w-full"
              required
            />
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block font-bold mb-2">Fecha Inicio</label>
              <input
                type="date"
                value={formData.fecha_inicio}
                onChange={(e) => setFormData({ ...formData, fecha_inicio: e.target.value })}
                className="input w-full"
                required
              />
            </div>
            <div>
              <label className="block font-bold mb-2">Fecha Fin</label>
              <input
                type="date"
                value={formData.fecha_fin}
                onChange={(e) => setFormData({ ...formData, fecha_fin: e.target.value })}
                className="input w-full"
                required
              />
            </div>
          </div>
          <div>
            <label className="block font-bold mb-2">Ubicacion</label>
            <input
              type="text"
              value={formData.ubicacion}
              onChange={(e) => setFormData({ ...formData, ubicacion: e.target.value })}
              className="input w-full"
            />
          </div>
          <div>
            <label className="block font-bold mb-2">Organizador</label>
            <input
              type="text"
              value={formData.organizador}
              onChange={(e) => setFormData({ ...formData, organizador: e.target.value })}
              className="input w-full"
            />
          </div>
          <button type="submit" className="btn btn-primary" disabled={saving}>
            {saving ? 'Guardando...' : 'Guardar Cambios'}
          </button>
        </form>
      </div>

      {/* INSCRIPCIONES */}
      <div className="card p-6 max-w-4xl mb-8">
        <div className="flex items-center justify-between mb-4">
          <div>
            <h2 className="text-xl font-bold">Inscripciones</h2>
            <p className="text-sm text-gray-600 mt-1">
              Categoria calculada automaticamente segun edad del jinete y del caballo (segun RFHE)
            </p>
          </div>
          <div className="text-right">
            <p className="text-xs text-gray-500">Total inscritos</p>
            <p className="text-2xl font-bold">{inscripciones.length}</p>
          </div>
        </div>

        {inscripcionError && (
          <div className="mb-4 p-3 bg-danger text-white rounded text-sm">{inscripcionError}</div>
        )}

        {inscripciones.length > 0 ? (
          <div className="table-responsive mb-6">
            <table className="table">
              <thead>
                <tr>
                  <th>N</th>
                  <th>Jinete</th>
                  <th>Caballo</th>
                  <th>Categoria</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                {inscripciones.map((i) => (
                  <tr key={i.id}>
                    <td className="font-bold">{i.dorsal}</td>
                    <td>{i.binomio?.nombre_jinete || '-'}</td>
                    <td>{i.binomio?.nombre_caballo || '-'}</td>
                    <td>
                      {i.categoria ? (
                        <span className="px-2 py-1 rounded text-xs bg-blue-100 text-blue-800 font-medium">
                          {i.categoria}
                        </span>
                      ) : (
                        <span className="px-2 py-1 rounded text-xs bg-red-100 text-red-800 font-medium">
                          Sin categoria
                        </span>
                      )}
                    </td>
                    <td>
                      <button
                        onClick={() => handleDeleteInscripcion(i.id)}
                        className="text-danger text-sm hover:underline"
                      >
                        Eliminar
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ) : (
          <p className="text-gray-600 mb-6">No hay inscripciones todavia</p>
        )}

        <h3 className="font-bold mb-2">Anadir inscripcion</h3>
        <form onSubmit={handleAddInscripcion} className="space-y-2">
          <select
            value={nuevaInscripcion.binomio_id}
            onChange={(e) => handleSeleccionarBinomio(e.target.value)}
            className="input w-full"
            required
          >
            <option value="">-- Elegir binomio --</option>
            {binomiosCatalogo.map((b) => (
              <option key={b.id} value={b.id}>
                {b.nombre_jinete} / {b.nombre_caballo}
                {b.categoria_principal && ' (' + b.categoria_principal + ')'}
              </option>
            ))}
          </select>

          {nuevaInscripcion.binomio_id && categoriaSugerida && (
            <div className="p-2 bg-blue-50 border border-blue-200 rounded text-sm">
              <strong>Categoria sugerida:</strong> {categoriaSugerida}
              {binomiosCatalogo.find((b) => b.id === nuevaInscripcion.binomio_id)?.edad_caballo !== null && (
                <span className="text-gray-600">
                  {' '}· Caballo: {formatearEdad(binomiosCatalogo.find((b) => b.id === nuevaInscripcion.binomio_id)?.edad_caballo || null)}
                </span>
              )}
              {binomiosCatalogo.find((b) => b.id === nuevaInscripcion.binomio_id)?.edad_jinete !== null && (
                <span className="text-gray-600">
                  {' '}· Jinete: {formatearEdad(binomiosCatalogo.find((b) => b.id === nuevaInscripcion.binomio_id)?.edad_jinete || null)}
                </span>
              )}
            </div>
          )}

          <div className="grid grid-cols-2 gap-2">
            <input
              type="number"
              placeholder="N (dorsal)"
              value={nuevaInscripcion.dorsal}
              onChange={(e) =>
                setNuevaInscripcion({ ...nuevaInscripcion, dorsal: e.target.value })
              }
              className="input"
              required
            />
            <select
              value={nuevaInscripcion.categoria_edad_id}
              onChange={(e) => handleCambiarCategoria(e.target.value)}
              className="input"
              required
            >
              <option value="">-- Categoria --</option>
              {categorias.map((c) => (
                <option key={c.id} value={c.id}>
                  {c.nombre}
                  {c.codigo === categoriaSugerida ? ' (sugerida)' : ''}
                </option>
              ))}
            </select>
          </div>
          <button
            type="submit"
            disabled={guardandoInscripcion || !nuevaInscripcion.binomio_id}
            className="btn btn-secondary disabled:opacity-50"
          >
            {guardandoInscripcion ? 'Anadiendo...' : '+ Anadir inscripcion'}
          </button>
        </form>
      </div>

      {/* EQUIPOS */}
      <EquiposSection concursoId={concursoId} />

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
      <PruebasSection concursoId={concursoId} />

      {/* MODAL DE COHERENCIA */}
      {modalCoherencia.abierto && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg p-6 max-w-md w-full">
            <h3 className="text-lg font-bold mb-3">Aviso de coherencia</h3>
            <p className="text-sm text-gray-700 mb-4">
              La categoria sugerida para este binomio es{' '}
              <strong>{modalCoherencia.sugeridaNombre}</strong>, pero has elegido{' '}
              <strong>{modalCoherencia.elegidaNombre}</strong>.
            </p>
            <p className="text-xs text-gray-500 mb-4">
              Segun el reglamento RFHE, la categoria sugerida es la que corresponde por edad del
              jinete y del caballo. Puedes continuar si es una excepcion justificada.
            </p>
            <div className="flex justify-end gap-2">
              <button
                onClick={() => {
                  setNuevaInscripcion({
                    ...nuevaInscripcion,
                    categoria_edad_id: modalCoherencia.sugeridaId,
                  });
                  setModalCoherencia({ ...modalCoherencia, abierto: false });
                }}
                className="btn btn-primary text-sm"
              >
                Usar la sugerida
              </button>
              <button
                onClick={() => setModalCoherencia({ ...modalCoherencia, abierto: false })}
                className="btn btn-outline text-sm"
              >
                Mantener mi eleccion
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}