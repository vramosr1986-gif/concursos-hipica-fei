'use client';

import { useEffect, useState } from 'react';
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
  num_ejercicios: number;
};

export default function AdminReprisesPage() {

  const [reprises, setReprises] = useState<Reprise[]>([]);
  const [categorias, setCategorias] = useState<string[]>([]);
  const [niveles, setNiveles] = useState<string[]>([]);
  const [anios, setAnios] = useState<number[]>([]);

  const [categoriaFiltro, setCategoriaFiltro] = useState('');
  const [nivelFiltro, setNivelFiltro] = useState('');
  const [anioFiltro, setAnioFiltro] = useState('');
  const [busqueda, setBusqueda] = useState('');

  const [vistaAgrupada, setVistaAgrupada] = useState(true);
  const [categoriasAbiertas, setCategoriasAbiertas] = useState<string[]>([]);

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const cargarFiltros = async () => {
    const { data } = await supabase
      .from('reprises')
      .select('categoria, nivel, anio');

    if (data) {
      const cats = Array.from(
        new Set(data.map((r: any) => r.categoria).filter(Boolean))
      ).sort() as string[];

      const nivs = Array.from(
        new Set(data.map((r: any) => r.nivel).filter(Boolean))
      ).sort() as string[];

      const yrs = Array.from(
        new Set(data.map((r: any) => r.anio).filter(Boolean))
      ).sort() as number[];

      setCategorias(cats);
      setNiveles(nivs);
      setAnios(yrs);
      setCategoriasAbiertas(cats); // por defecto todas abiertas
    }
  };

  const cargarReprises = async () => {
    setLoading(true);
    setError('');

    try {
      let query = supabase
        .from('reprises')
        .select(
          'id, codigo, nombre, categoria, nivel, tipo, anio, tiempo_orientativo, edad_minima_caballo, total_maximo'
        )
        .order('categoria', { ascending: true })
        .order('nivel', { ascending: true })
        .order('codigo', { ascending: true });

      if (categoriaFiltro) query = query.eq('categoria', categoriaFiltro);
      if (nivelFiltro) query = query.eq('nivel', nivelFiltro);
      if (anioFiltro) query = query.eq('anio', parseInt(anioFiltro, 10));

      if (busqueda.trim()) {
        const b = busqueda.trim();
        query = query.or(
          `nombre.ilike.%${b}%,codigo.ilike.%${b}%,nivel.ilike.%${b}%`
        );
      }

      const { data, error: dbError } = await query;

      if (dbError) throw dbError;

      // Contar ejercicios
      const reprisesConContador: Reprise[] = [];
      for (const r of data || []) {
        const { count } = await supabase
          .from('ejercicios_reprise')
          .select('id', { count: 'exact', head: true })
          .eq('reprise_id', r.id);

        reprisesConContador.push({
          ...r,
          num_ejercicios: count || 0,
        });
      }

      setReprises(reprisesConContador);
    } catch (err: any) {
      setError(err.message || 'Error al cargar las reprises');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    cargarFiltros();
  }, []);

  useEffect(() => {
    cargarReprises();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [categoriaFiltro, nivelFiltro, anioFiltro]);

  const handleBuscar = (e: React.FormEvent) => {
    e.preventDefault();
    cargarReprises();
  };

  const limpiarFiltros = () => {
    setCategoriaFiltro('');
    setNivelFiltro('');
    setAnioFiltro('');
    setBusqueda('');
  };

  const toggleCategoria = (cat: string) => {
    setCategoriasAbiertas((prev) =>
      prev.includes(cat) ? prev.filter((c) => c !== cat) : [...prev, cat]
    );
  };

  const agruparPorCategoria = () => {
    const grupos: Record<string, Reprise[]> = {};
    for (const r of reprises) {
      if (!grupos[r.categoria]) grupos[r.categoria] = [];
      grupos[r.categoria].push(r);
    }
    return grupos;
  };

  const grupos = agruparPorCategoria();
  const categoriasOrdenadas = Object.keys(grupos).sort();

  // Colores por categorÃ­a
  const colorCategoria = (cat: string) => {
    const colores: Record<string, string> = {
      Alevines: 'bg-pink-100 text-pink-800 border-pink-200',
      Infantiles: 'bg-orange-100 text-orange-800 border-orange-200',
      Benjamines: 'bg-yellow-100 text-yellow-800 border-yellow-200',
      Juveniles: 'bg-green-100 text-green-800 border-green-200',
      'Jovenes Jinetes': 'bg-teal-100 text-teal-800 border-teal-200',
      Rider: 'bg-blue-100 text-blue-800 border-blue-200',
      Promocion: 'bg-indigo-100 text-indigo-800 border-indigo-200',
      Clasica: 'bg-purple-100 text-purple-800 border-purple-200',
      Intermedia: 'bg-cyan-100 text-cyan-800 border-cyan-200',
      'Gran Premio': 'bg-red-100 text-red-800 border-red-200',
      'Caballos Jovenes': 'bg-amber-100 text-amber-800 border-amber-200',
      Kur: 'bg-fuchsia-100 text-fuchsia-800 border-fuchsia-200',
      Ponis: 'bg-rose-100 text-rose-800 border-rose-200',
      AP: 'bg-slate-100 text-slate-800 border-slate-200',
    };
    return colores[cat] || 'bg-gray-100 text-gray-800 border-gray-200';
  };

  const FilaReprise = ({ r }: { r: Reprise }) => (
    <tr className="border-b hover:bg-gray-50">
      <td className="p-3 font-medium">{r.nombre}</td>
      <td className="p-3 text-xs font-mono text-gray-600">{r.codigo}</td>
      <td className="p-3 text-sm">{r.nivel || '-'}</td>
      <td className="p-3 text-center text-sm">{r.anio || '-'}</td>
      <td className="p-3 text-center">
        <span className="px-2 py-1 rounded text-xs bg-blue-100 text-blue-800 font-medium">
          {r.num_ejercicios}
        </span>
      </td>
      <td className="p-3 text-right">
        <Link
          href={`/admin/reprises/${r.id}`}
          className="text-primary hover:underline text-sm font-medium"
        >
          Ver â†’
        </Link>
      </td>
    </tr>
  );

  return (
    <div className="container max-w-7xl py-8">
      {/* Cabecera */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-3xl font-bold">Reprises</h1>
          <p className="text-gray-600 mt-1">
            CatÃ¡logo de reprises oficiales RFHE
          </p>
        </div>

        <div className="text-right">
          <p className="text-sm text-gray-500">Mostrando</p>
          <p className="text-2xl font-bold">{reprises.length}</p>
        </div>
      </div>

      {/* Filtros */}
      <div className="card p-4 mb-6">
        <div className="grid md:grid-cols-4 gap-3 mb-3">
          <div>
            <label className="block text-xs font-bold mb-1 text-gray-600">
              CategorÃ­a
            </label>
            <select
              value={categoriaFiltro}
              onChange={(e) => setCategoriaFiltro(e.target.value)}
              className="input w-full text-sm"
            >
              <option value="">Todas</option>
              {categorias.map((c) => (
                <option key={c} value={c}>
                  {c}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-xs font-bold mb-1 text-gray-600">
              Nivel
            </label>
            <select
              value={nivelFiltro}
              onChange={(e) => setNivelFiltro(e.target.value)}
              className="input w-full text-sm"
            >
              <option value="">Todos</option>
              {niveles.map((n) => (
                <option key={n} value={n}>
                  {n}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-xs font-bold mb-1 text-gray-600">
              AÃ±o
            </label>
            <select
              value={anioFiltro}
              onChange={(e) => setAnioFiltro(e.target.value)}
              className="input w-full text-sm"
            >
              <option value="">Todos</option>
              {anios.map((a) => (
                <option key={a} value={a}>
                  {a}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-xs font-bold mb-1 text-gray-600">
              Buscar
            </label>
            <form onSubmit={handleBuscar} className="flex gap-2">
              <input
                type="text"
                placeholder="Nombre, cÃ³digo, nivel..."
                value={busqueda}
                onChange={(e) => setBusqueda(e.target.value)}
                className="input flex-1 text-sm"
              />
              <button type="submit" className="btn btn-primary text-sm px-3">
                ðŸ”
              </button>
            </form>
          </div>
        </div>

        <div className="flex items-center justify-between pt-3 border-t">
          <div className="flex items-center gap-3">
            <button
              onClick={() => setVistaAgrupada(!vistaAgrupada)}
              className="text-sm text-gray-600 hover:text-gray-900"
            >
              {vistaAgrupada ? 'ðŸ“‹ Ver lista plana' : 'ðŸ“ Ver agrupado por categorÃ­a'}
            </button>
          </div>

          {(categoriaFiltro || nivelFiltro || anioFiltro || busqueda) && (
            <button
              onClick={limpiarFiltros}
              className="text-sm text-danger hover:underline"
            >
              âœ• Limpiar filtros
            </button>
          )}
        </div>
      </div>

      {error && (
        <div className="mb-4 p-4 bg-red-100 border border-red-300 text-red-700 rounded">
          {error}
        </div>
      )}

      {loading ? (
        <div className="card p-6 text-center">Cargando reprises...</div>
      ) : reprises.length === 0 ? (
        <div className="card p-8 text-center">
          <p className="text-gray-600">No hay reprises que coincidan.</p>
        </div>
      ) : vistaAgrupada ? (
        // VISTA AGRUPADA
        <div className="space-y-4">
          {categoriasOrdenadas.map((cat) => {
            const items = grupos[cat];
            const abierta = categoriasAbiertas.includes(cat);

            return (
              <div key={cat} className="card overflow-hidden">
                <button
                  onClick={() => toggleCategoria(cat)}
                  className={`w-full p-4 flex items-center justify-between border-l-4 ${colorCategoria(cat)} hover:opacity-90 transition`}
                >
                  <div className="flex items-center gap-3">
                    <span className="text-lg">{abierta ? 'â–¼' : 'â–¶'}</span>
                    <span className="text-lg font-bold">{cat}</span>
                    <span className="text-sm opacity-75">
                      ({items.length} {items.length === 1 ? 'reprise' : 'reprisas'})
                    </span>
                  </div>
                  <span className="text-sm opacity-75">
                    {items.reduce((sum, r) => sum + r.num_ejercicios, 0)} ejercicios
                  </span>
                </button>

                {abierta && (
                  <div className="overflow-x-auto">
                    <table className="w-full">
                      <thead>
                        <tr className="border-b bg-gray-50">
                          <th className="text-left p-3 text-sm">Nombre</th>
                          <th className="text-left p-3 text-sm">CÃ³digo FEI</th>
                          <th className="text-left p-3 text-sm">Nivel</th>
                          <th className="text-center p-3 text-sm">AÃ±o</th>
                          <th className="text-center p-3 text-sm">Ejercicios</th>
                          <th className="text-right p-3 text-sm">Acciones</th>
                        </tr>
                      </thead>
                      <tbody>
                        {items.map((r) => (
                          <FilaReprise key={r.id} r={r} />
                        ))}
                      </tbody>
                    </table>
                  </div>
                )}
              </div>
            );
          })}
        </div>
      ) : (
        // VISTA PLANA
        <div className="card overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b bg-gray-50">
                  <th className="text-left p-3 text-sm">Nombre</th>
                  <th className="text-left p-3 text-sm">CÃ³digo FEI</th>
                  <th className="text-left p-3 text-sm">CategorÃ­a</th>
                  <th className="text-left p-3 text-sm">Nivel</th>
                  <th className="text-center p-3 text-sm">AÃ±o</th>
                  <th className="text-center p-3 text-sm">Ejercicios</th>
                  <th className="text-right p-3 text-sm">Acciones</th>
                </tr>
              </thead>
              <tbody>
                {reprises.map((r) => (
                  <tr key={r.id} className="border-b hover:bg-gray-50">
                    <td className="p-3 font-medium">{r.nombre}</td>
                    <td className="p-3 text-xs font-mono text-gray-600">
                      {r.codigo}
                    </td>
                    <td className="p-3 text-sm">
                      <span
                        className={`px-2 py-1 rounded text-xs border ${colorCategoria(r.categoria)}`}
                      >
                        {r.categoria}
                      </span>
                    </td>
                    <td className="p-3 text-sm">{r.nivel || '-'}</td>
                    <td className="p-3 text-center text-sm">{r.anio || '-'}</td>
                    <td className="p-3 text-center">
                      <span className="px-2 py-1 rounded text-xs bg-blue-100 text-blue-800 font-medium">
                        {r.num_ejercicios}
                      </span>
                    </td>
                    <td className="p-3 text-right">
                      <Link
                        href={`/admin/reprises/${r.id}`}
                        className="text-primary hover:underline text-sm font-medium"
                      >
                        Ver â†’
                      </Link>
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