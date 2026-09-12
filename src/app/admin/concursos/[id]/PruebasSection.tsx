'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

// ============================================================
// TABLA DE COMPATIBILIDAD NIVEL -> CATEGORIAS Y TIPOS
// Basada en el Reglamento RFHE 2026
// ============================================================
const NIVEL_COMPATIBILIDAD: Record<string, { categorias: string[]; tipos: string[] }> = {
  N0: { categorias: ['BENJAMIN', 'ALEVIN'], tipos: ['PRE', 'IND', 'AP'] },
  N1: { categorias: ['ALEVIN'], tipos: ['PRE', 'EQU', 'IND', 'FIN'] },
  N2: { categorias: ['INFANTIL', 'CJ5'], tipos: ['PRE', 'EQU', 'IND', 'FIN'] },
  N3: { categorias: ['JUVENIL_0', 'PONI'], tipos: ['PRE', 'EQU', 'IND'] },
  N4: { categorias: ['JUVENIL', 'JUNIOR', 'CJ6'], tipos: ['PRE', 'EQU', 'IND', 'FIN'] },
  SJ: { categorias: ['JOVEN_JINETE', 'CJ7', 'VETERANO'], tipos: ['PRE', 'EQU', 'IND', 'FIN'] },
  INT_I: { categorias: ['ADULTO', 'JOVEN_JINETE', 'VETERANO'], tipos: ['IND'] },
  INT_II: { categorias: ['ADULTO'], tipos: ['IND'] },
  GP: { categorias: ['ADULTO', 'CJ8_10'], tipos: ['IND'] },
  KUR: {
    categorias: ['PONI', 'JUVENIL_0', 'JUVENIL', 'JUNIOR', 'JOVEN_JINETE', 'ADULTO', 'VETERANO'],
    tipos: ['KUR'],
  },
};

type Prueba = {
  id: string;
  concurso_id: string;
  reprise_id: string | null;
  jornada_id: string | null;
  nivel_id: string | null;
  categoria_edad_id: string | null;
  tipo_prueba_id: string | null;
  nombre: string;
  categoria: string | null;
  fecha: string;
  hora_inicio: string;
  pista: string | null;
  orden: number;
  estado: string;
  coeficiente: number | null;
  es_caballos_jovenes: boolean | null;
  reprise_nombre?: string;
  jornada_nombre?: string;
  nivel_codigo?: string;
  categoria_edad_nombre?: string;
  tipo_prueba_nombre?: string;
  num_jueces?: number;
  num_participantes?: number;
};

type Reprise = { id: string; codigo: string; nombre: string };
type Jornada = { id: string; fecha: string; numero: number; pista: string | null };
type Nivel = { id: string; codigo: string; nombre: string; orden: number; color: string | null };
type CategoriaEdad = { id: string; codigo: string; nombre: string; orden: number | null };
type TipoPrueba = { id: string; codigo: string; nombre: string; coeficiente: number; orden: number | null };

type NuevaPruebaForm = {
  nombre: string;
  jornada_id: string;
  nivel_id: string;
  categoria_edad_id: string;
  tipo_prueba_id: string;
  reprise_id: string;
  categoria: string;
  hora_inicio: string;
  pista: string;
  orden: string;
};

interface Props { concursoId: string }

export function PruebasSection({ concursoId }: Props) {
  const [pruebas, setPruebas] = useState<Prueba[]>([]);
  const [reprises, setReprises] = useState<Reprise[]>([]);
  const [jornadas, setJornadas] = useState<Jornada[]>([]);
  const [niveles, setNiveles] = useState<Nivel[]>([]);
  const [categorias, setCategorias] = useState<CategoriaEdad[]>([]);
  const [tipos, setTipos] = useState<TipoPrueba[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [guardando, setGuardando] = useState(false);
  const [modalAbierto, setModalAbierto] = useState(false);

  const [nuevaPrueba, setNuevaPrueba] = useState<NuevaPruebaForm>({
    nombre: '',
    categoria: '',
    jornada_id: '',
    nivel_id: '',
    categoria_edad_id: '',
    tipo_prueba_id: '',
    reprise_id: '',
    hora_inicio: '09:00',
    pista: '',
    orden: '',
  });

  const nivelSeleccionado = niveles.find((n) => n.id === nuevaPrueba.nivel_id);
  const compat = nivelSeleccionado ? NIVEL_COMPATIBILIDAD[nivelSeleccionado.codigo] : null;

  const categoriasCompatibles = compat
    ? categorias.filter((c) => compat.categorias.includes(c.codigo))
    : categorias;

  const tiposCompatibles = compat
    ? tipos.filter((t) => compat.tipos.includes(t.codigo))
    : tipos;

  const cargarPruebas = async () => {
    setLoading(true);
    setError('');
    try {
      const { data, error: dbError } = await supabase
        .from('pruebas')
        .select(`
          id, concurso_id, reprise_id, jornada_id, nivel_id, categoria_edad_id, tipo_prueba_id,
          nombre, categoria, fecha, hora_inicio, pista, orden, estado, coeficiente, es_caballos_jovenes,
          reprise:reprise_id(nombre, codigo),
          jornada:jornada_id(fecha, numero),
          nivel:nivel_id(codigo, nombre),
          categoria_edad:categoria_edad_id(nombre),
          tipo_prueba:tipo_prueba_id(nombre)
        `)
        .eq('concurso_id', concursoId)
        .order('fecha', { ascending: true })
        .order('orden', { ascending: true });

      if (dbError) throw dbError;

      const enriquecidas: Prueba[] = [];
      for (const p of data || []) {
        const [juecesRes, participacionesRes] = await Promise.all([
          supabase.from('prueba_jueces').select('id', { count: 'exact', head: true }).eq('prueba_id', p.id),
          supabase.from('participaciones').select('id', { count: 'exact', head: true }).eq('prueba_id', p.id),
        ]);

        enriquecidas.push({
          ...(p as any),
          reprise_nombre: (p as any).reprise?.nombre || undefined,
          jornada_nombre: (p as any).jornada
            ? `J${(p as any).jornada.numero} - ${(p as any).jornada.fecha}`
            : undefined,
          nivel_codigo: (p as any).nivel?.codigo || undefined,
          categoria_edad_nombre: (p as any).categoria_edad?.nombre || undefined,
          tipo_prueba_nombre: (p as any).tipo_prueba?.nombre || undefined,
          num_jueces: juecesRes.count || 0,
          num_participantes: participacionesRes.count || 0,
        });
      }
      setPruebas(enriquecidas);
    } catch (err: any) {
      setError(err.message || 'Error al cargar las pruebas');
    } finally {
      setLoading(false);
    }
  };

  const cargarCatalogos = async () => {
    const [jornadasRes, nivelesRes, categoriasRes, tiposRes] = await Promise.all([
      supabase.from('jornadas').select('id, fecha, numero, pista').eq('concurso_id', concursoId).order('fecha'),
      supabase.from('niveles').select('id, codigo, nombre, orden, color').order('orden'),
      supabase.from('categorias_edad').select('id, codigo, nombre, orden').order('orden'),
      supabase.from('tipos_prueba').select('id, codigo, nombre, coeficiente, orden').order('orden'),
    ]);
    if (jornadasRes.data) setJornadas(jornadasRes.data as any);
    if (nivelesRes.data) setNiveles(nivelesRes.data as any);
    if (categoriasRes.data) setCategorias(categoriasRes.data as any);
    if (tiposRes.data) setTipos(tiposRes.data as any);
  };

  const cargarReprisesPorNivel = async (nivelId: string) => {
    if (!nivelId) {
      setReprises([]);
      return;
    }
    const { data, error: dbError } = await supabase
      .from('niveles_reprises')
      .select('reprise_id, reprise:reprise_id(id, codigo, nombre)')
      .eq('nivel_id', nivelId);

    if (dbError) {
      console.error(dbError);
      setReprises([]);
      return;
    }

    const formateadas: Reprise[] = (data || [])
      .map((r: any) => ({ id: r.reprise.id, codigo: r.reprise.codigo, nombre: r.reprise.nombre }))
      .sort((a, b) => a.nombre.localeCompare(b.nombre));

    setReprises(formateadas);
  };

  useEffect(() => {
    cargarPruebas();
    cargarCatalogos();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [concursoId]);

  useEffect(() => {
    if (nuevaPrueba.nivel_id) {
      cargarReprisesPorNivel(nuevaPrueba.nivel_id);
    } else {
      setReprises([]);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [nuevaPrueba.nivel_id]);

  const handleAddPrueba = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    if (!nuevaPrueba.nombre.trim()) { setError('El nombre es obligatorio'); return; }
    if (!nuevaPrueba.jornada_id) { setError('La jornada es obligatoria'); return; }
    if (!nuevaPrueba.nivel_id) { setError('El nivel es obligatorio'); return; }
    if (!nuevaPrueba.categoria_edad_id) { setError('La categoria de edad es obligatoria'); return; }

    const jornadaSel = jornadas.find((j) => j.id === nuevaPrueba.jornada_id);
    if (!jornadaSel) { setError('Jornada no valida'); return; }

    const nivelObj = niveles.find((n) => n.id === nuevaPrueba.nivel_id);
    const catObj = categorias.find((c) => c.id === nuevaPrueba.categoria_edad_id);
    const tipoObj = tipos.find((t) => t.id === nuevaPrueba.tipo_prueba_id);

    if (nivelObj && compat) {
      if (catObj && !compat.categorias.includes(catObj.codigo)) {
        setError(`La categoria "${catObj.nombre}" no es compatible con el nivel "${nivelObj.nombre}"`);
        return;
      }
      if (tipoObj && !compat.tipos.includes(tipoObj.codigo)) {
        setError(`El tipo "${tipoObj.nombre}" no es compatible con el nivel "${nivelObj.nombre}"`);
        return;
      }
    }

    setGuardando(true);
    try {
      const categoriaTexto = catObj?.nombre || null;
      const nuevoOrden = nuevaPrueba.orden.trim() !== ''
        ? parseInt(nuevaPrueba.orden, 10)
        : pruebas.length + 1;

      const { error: dbError } = await supabase.from('pruebas').insert({
        concurso_id: concursoId,
        jornada_id: nuevaPrueba.jornada_id,
        nivel_id: nuevaPrueba.nivel_id,
        categoria_edad_id: nuevaPrueba.categoria_edad_id || null,
        categoria: categoriaTexto,
        tipo_prueba_id: nuevaPrueba.tipo_prueba_id || null,
        reprise_id: nuevaPrueba.reprise_id || null,
        es_caballos_jovenes: esCaballosJovenes(nuevaPrueba.reprise_id),
        nombre: nuevaPrueba.nombre.trim(),
        fecha: jornadaSel.fecha,
        hora_inicio: nuevaPrueba.hora_inicio.length === 5
          ? nuevaPrueba.hora_inicio + ':00'
          : nuevaPrueba.hora_inicio,
        pista: nuevaPrueba.pista.trim() || null,
        orden: nuevoOrden,
        estado: 'programada',
      });

      if (dbError) throw dbError;

      await cargarPruebas();
      setModalAbierto(false);
      setNuevaPrueba({
        nombre: '', categoria: '', jornada_id: '', nivel_id: '',
        categoria_edad_id: '', tipo_prueba_id: '', reprise_id: '',
        hora_inicio: '09:00', pista: '', orden: '',
      });
    } catch (err: any) {
      setError(err.message || 'Error al crear la prueba');
    } finally {
      setGuardando(false);
    }
  };

  const eliminarPrueba = async (id: string, nombre: string) => {
    if (!confirm(`Eliminar la prueba "${nombre}"? Se eliminaran tambien sus jueces y participantes.`)) return;
    try {
      const { error: dbError } = await supabase.from('pruebas').delete().eq('id', id);
      if (dbError) throw dbError;
      setPruebas((actuales) => actuales.filter((p) => p.id !== id));
    } catch (err: any) {
      alert(err.message || 'Error al eliminar la prueba');
    }
  };

  const esCaballosJovenes = (repriseId: string | null): boolean => {
    if (!repriseId) return false;
    const reprise = reprises.find((r) => r.id === repriseId);
    if (!reprise) return false;
    const codigo = reprise.codigo || '';
    return (
      codigo.includes('CJ4') || codigo.includes('CJ5') ||
      codigo.includes('CJ6') || codigo.includes('CJ7') ||
      codigo.includes('CJ8')
    );
  };

  const formatearFecha = (fecha: string) => {
    if (!fecha) return '-';
    const [y, m, d] = fecha.split('-');
    return `${d}/${m}/${y}`;
  };

  return (
    <div className="card p-6 max-w-6xl mb-8">
      <div className="flex items-center justify-between mb-4">
        <h2 className="text-xl font-bold">Pruebas del Concurso</h2>
        <button onClick={() => setModalAbierto(!modalAbierto)} className="btn btn-primary text-sm">
          + Anadir Prueba
        </button>
      </div>

      {error && <div className="mb-4 p-3 bg-danger text-white rounded text-sm">{error}</div>}

      {modalAbierto && (
        <div className="mb-6 p-4 border border-primary rounded bg-blue-50">
          <h3 className="font-bold mb-3">Nueva Prueba</h3>
          <form onSubmit={handleAddPrueba} className="space-y-3">
            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className="block text-xs font-bold mb-1">Nombre *</label>
                <input
                  type="text"
                  value={nuevaPrueba.nombre}
                  onChange={(e) => setNuevaPrueba({ ...nuevaPrueba, nombre: e.target.value })}
                  placeholder="Ej. Clasica 1 - Alevines"
                  className="input w-full"
                  required
                />
              </div>
              <div>
                <label className="block text-xs font-bold mb-1">Jornada *</label>
                <select
                  value={nuevaPrueba.jornada_id}
                  onChange={(e) => setNuevaPrueba({ ...nuevaPrueba, jornada_id: e.target.value })}
                  className="input w-full"
                  required
                >
                  <option value="">-- Elegir jornada --</option>
                  {jornadas.map((j) => (
                    <option key={j.id} value={j.id}>
                      J{j.numero} - {formatearFecha(j.fecha)}{j.pista ? ` (${j.pista})` : ''}
                    </option>
                  ))}
                </select>
              </div>
            </div>

            <div className="grid grid-cols-3 gap-3">
              <div>
                <label className="block text-xs font-bold mb-1">Nivel *</label>
                <select
                  value={nuevaPrueba.nivel_id}
                  onChange={(e) => {
                    setNuevaPrueba({
                      ...nuevaPrueba,
                      nivel_id: e.target.value,
                      categoria_edad_id: '',
                      categoria: '',
                      tipo_prueba_id: '',
                      reprise_id: '',
                    });
                  }}
                  className="input w-full"
                  required
                >
                  <option value="">-- Elegir nivel --</option>
                  {niveles.map((n) => (
                    <option key={n.id} value={n.id}>
                      {n.codigo} - {n.nombre}
                    </option>
                  ))}
                </select>
                {compat && (
                  <p className="text-xs text-gray-500 mt-1">
                    {compat.categorias.length} cat. · {compat.tipos.length} tipos
                  </p>
                )}
              </div>
              <div>
                <label className="block text-xs font-bold mb-1">Categoria edad *</label>
                <select
                  value={nuevaPrueba.categoria_edad_id}
                  onChange={(e) => {
                    const catId = e.target.value;
                    const catObj = categorias.find((c) => c.id === catId);
                    setNuevaPrueba({
                      ...nuevaPrueba,
                      categoria_edad_id: catId,
                      categoria: catObj?.nombre || '',
                    });
                  }}
                  className="input w-full"
                  required
                  disabled={!nuevaPrueba.nivel_id}
                >
                  <option value="">
                    {nuevaPrueba.nivel_id ? '-- Elegir categoria --' : '-- Elige un nivel primero --'}
                  </option>
                  {categoriasCompatibles.map((c) => (
                    <option key={c.id} value={c.id}>{c.nombre}</option>
                  ))}
                </select>
                {nuevaPrueba.nivel_id && categoriasCompatibles.length === 0 && (
                  <p className="text-xs text-orange-600 mt-1">Sin categorias compatibles.</p>
                )}
              </div>
              <div>
                <label className="block text-xs font-bold mb-1">Tipo de prueba</label>
                <select
                  value={nuevaPrueba.tipo_prueba_id}
                  onChange={(e) => setNuevaPrueba({ ...nuevaPrueba, tipo_prueba_id: e.target.value })}
                  className="input w-full"
                  disabled={!nuevaPrueba.nivel_id}
                >
                  <option value="">
                    {nuevaPrueba.nivel_id ? '-- Elegir tipo --' : '-- Elige un nivel primero --'}
                  </option>
                  {tiposCompatibles.map((t) => (
                    <option key={t.id} value={t.id}>
                      {t.nombre} (coef {t.coeficiente})
                    </option>
                  ))}
                </select>
              </div>
            </div>

            <div>
              <label className="block text-xs font-bold mb-1">
                Reprise {nuevaPrueba.nivel_id ? '(filtrada por nivel)' : '(elige un nivel primero)'}
              </label>
              <select
                value={nuevaPrueba.reprise_id}
                onChange={(e) => setNuevaPrueba({ ...nuevaPrueba, reprise_id: e.target.value })}
                className="input w-full"
                disabled={!nuevaPrueba.nivel_id}
              >
                <option value="">-- Elegir reprise --</option>
                {reprises.map((r) => (
                  <option key={r.id} value={r.id}>{r.nombre} ({r.codigo})</option>
                ))}
              </select>
              {nuevaPrueba.nivel_id && reprises.length === 0 && (
                <p className="text-xs text-orange-600 mt-1">No hay reprises para este nivel.</p>
              )}
            </div>

            <div className="grid grid-cols-3 gap-3">
              <div>
                <label className="block text-xs font-bold mb-1">Hora Inicio *</label>
                <input
                  type="time"
                  value={nuevaPrueba.hora_inicio}
                  onChange={(e) => setNuevaPrueba({ ...nuevaPrueba, hora_inicio: e.target.value })}
                  className="input w-full"
                  required
                />
              </div>
              <div>
                <label className="block text-xs font-bold mb-1">Pista</label>
                <input
                  type="text"
                  value={nuevaPrueba.pista}
                  onChange={(e) => setNuevaPrueba({ ...nuevaPrueba, pista: e.target.value })}
                  placeholder="Ej. Pista A"
                  className="input w-full"
                />
              </div>
              <div>
                <label className="block text-xs font-bold mb-1">Orden</label>
                <input
                  type="number"
                  value={nuevaPrueba.orden}
                  onChange={(e) => setNuevaPrueba({ ...nuevaPrueba, orden: e.target.value })}
                  placeholder="Auto"
                  className="input w-full"
                />
              </div>
            </div>

            <div className="flex justify-end gap-2 pt-2">
              <button type="button" onClick={() => setModalAbierto(false)} className="btn btn-outline text-sm" disabled={guardando}>
                Cancelar
              </button>
              <button type="submit" className="btn btn-primary text-sm" disabled={guardando}>
                {guardando ? 'Guardando...' : 'Guardar Prueba'}
              </button>
            </div>
          </form>
        </div>
      )}

      {loading ? (
        <p className="text-center text-gray-600 py-4">Cargando pruebas...</p>
      ) : pruebas.length === 0 ? (
        <p className="text-gray-600">No hay pruebas creadas. Pulsa "+ Anadir Prueba" para empezar.</p>
      ) : (
        <div className="table-responsive">
          <table className="table">
            <thead>
              <tr>
                <th>Orden</th><th>Nombre</th><th>Jornada</th><th>Nivel</th>
                <th>Tipo</th><th>Categoria edad</th><th>Hora</th><th>Reprise</th>
                <th className="text-center">Jueces</th>
                <th className="text-center">Binomios</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {pruebas.map((p) => (
                <tr key={p.id}>
                  <td className="font-bold">{p.orden}</td>
                  <td className="font-medium">{p.nombre}</td>
                  <td className="text-sm">{p.jornada_nombre || '-'}</td>
                  <td className="text-sm">{p.nivel_codigo || '-'}</td>
                  <td className="text-sm">{p.tipo_prueba_nombre || '-'}</td>
                  <td className="text-sm">{p.categoria_edad_nombre || '-'}</td>
                  <td className="text-sm">{p.hora_inicio.substring(0, 5)}</td>
                  <td className="text-sm">{p.reprise_nombre || '-'}</td>
                  <td className="text-center">
                    <span className="px-2 py-1 rounded text-xs bg-amber-100 text-amber-800 font-medium">
                      {p.num_jueces || 0}
                    </span>
                  </td>
                  <td className="text-center">
                    <span className="px-2 py-1 rounded text-xs bg-blue-100 text-blue-800 font-medium">
                      {p.num_participantes || 0}
                    </span>
                  </td>
                  <td className="text-right">
                    <div className="flex gap-2 justify-end">
                      <Link href={`/admin/concursos/${concursoId}/pruebas/${p.id}`} className="text-primary hover:underline text-sm font-medium">
                        Gestionar
                      </Link>
                      <button onClick={() => eliminarPrueba(p.id, p.nombre)} className="text-danger hover:underline text-sm">
                        Eliminar
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}