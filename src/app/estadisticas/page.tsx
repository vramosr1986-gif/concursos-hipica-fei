'use client';

import { useEffect, useMemo, useState } from 'react';
import { supabase } from '@/lib/supabase';

// ============================================================
// TIPOS
// ============================================================

type Concurso = { id: string; nombre: string; ubicacion: string | null };

type Prueba = {
  id: string;
  nombre: string;
  categoria: string | null;
  nivel_codigo: string | null;
  tipo_codigo: string | null;
  reprise_codigo: string | null;
  concurso_nombre: string | null;
  fecha: string;
};

type Participacion = {
  id: string;
  prueba_id: string;
  dorsal: number;
  orden_salida: number;
  jinete: string;
  caballo: string;
  binomio_id: string | null;
  anio: number | null;
  equipo: string | null;
};

type Puntuacion = {
  participacion_id: string;
  nota: number;
  letraJuez: string;
  ejId: string;
  ejNum: number;
  ejLetra: string | null;
  ejDesc: string;
  ejCoef: number;
};

type Datos = {
  concursos: Concurso[];
  pruebas: Prueba[];
  partes: Participacion[];
  puntos: Puntuacion[];
};

// ============================================================
// AGGREGADOS
// ============================================================

type JuezStats = {
  letra: string;
  notas: number;
  media: number;
  mediaPerc: number;
  max: number;
  min: number;
};

type EjercicioStats = {
  ejId: string;
  num: number;
  letra: string | null;
  desc: string;
  coef: number;
  notas: number;
  media: number;
  max: number;
  min: number;
};

type RepriseStats = {
  codigo: string;
  nombre: string;
  pruebas: number;
  notas: number;
  mediaPerc: number;
};

type EdadStats = {
  edad: number;
  binomios: number;
  participaciones: number;
  media: number;
  max: number;
  min: number;
};

type StartPosStats = {
  startRank: number;
  n: number;
  mediaPos: number;
  mejorPos: number;
  peorPos: number;
  vecesPrimero: number;
};

type Stats = {
  totalNotas: number;
  totalParticipaciones: number;
  totalPruebas: number;
  totalBinomios: number;
  pruebasCoincidentes: number;
  mediaGlobal: number;
  jueces: JuezStats[];
  ejercicios: EjercicioStats[];
  reprises: RepriseStats[];
  edades: EdadStats[];
  startPos: StartPosStats[];
  correlacion: number | null;
  juezGeneroso: JuezStats | null;
  juezEstricto: JuezStats | null;
  maldito: EjercicioStats | null;
  favorito: EjercicioStats | null;
  notaMaxGlobal: { nota: number; desc: string } | null;
  notaMinGlobal: { nota: number; desc: string } | null;
};

function calcularStats(pruebas: Prueba[], partes: Participacion[], puntos: Puntuacion[]): Stats {
  const pruebasIds = new Set(pruebas.map((p) => p.id));
  const partesFiltradas = partes.filter((p) => pruebasIds.has(p.prueba_id));
  const partIds = new Set(partesFiltradas.map((p) => p.id));
  const puntosFiltrados = puntos.filter((p) => partIds.has(p.participacion_id));

  // % por (participacion, juez)
  const perPJ = new Map<string, { sum: number; sumCoef: number }>();
  for (const p of puntosFiltrados) {
    const key = p.participacion_id + '|' + p.letraJuez;
    const cur = perPJ.get(key) || { sum: 0, sumCoef: 0 };
    cur.sum += p.nota * p.ejCoef;
    cur.sumCoef += p.ejCoef;
    perPJ.set(key, cur);
  }
  const percPJ = new Map<string, number>();
  for (const [key, v] of perPJ) {
    percPJ.set(key, (v.sum * 100) / (v.sumCoef * 10));
  }

  const parteJinetes: Record<string, Participacion> = {};
  for (const p of partesFiltradas) parteJinetes[p.id] = p;

  // ------ JUECES (por letra) ------
  const jueces: Record<string, { notas: number[]; percs: number[]; max: number; min: number }> = {};
  for (const [key, perc] of percPJ) {
    const letra = key.split('|')[1];
    const j = jueces[letra] || (jueces[letra] = { notas: [], percs: [], max: -Infinity, min: Infinity });
    j.percs.push(perc);
    j.max = Math.max(j.max, perc);
    j.min = Math.min(j.min, perc);
  }
  for (const p of puntosFiltrados) {
    const j = jueces[p.letraJuez];
    if (j) j.notas.push(p.nota);
  }
  const juecesStats: JuezStats[] = Object.entries(jueces).map(([letra, j]) => ({
    letra,
    notas: j.notas.length,
    media: j.notas.reduce((a, b) => a + b, 0) / j.notas.length,
    mediaPerc: j.percs.reduce((a, b) => a + b, 0) / j.percs.length,
    max: j.max,
    min: j.min,
  })).sort((a, b) => b.mediaPerc - a.mediaPerc);

  // ------ EJERCICIOS ------
  const ejs = new Map<string, EjercicioStats>();
  for (const p of puntosFiltrados) {
    let e = ejs.get(p.ejId);
    if (!e) {
      e = { ejId: p.ejId, num: p.ejNum, letra: p.ejLetra, desc: p.ejDesc, coef: p.ejCoef, notas: 0, media: 0, max: -Infinity, min: Infinity };
      ejs.set(p.ejId, e);
    }
    e.notas++;
    e.max = Math.max(e.max, p.nota);
    e.min = Math.min(e.min, p.nota);
    e.media = (e.media * (e.notas - 1) + p.nota) / e.notas;
  }
  const ejercicios: EjercicioStats[] = [...ejs.values()].sort((a, b) => a.media - b.media);

  // ------ REPRISES ------
  const repriseDePrueba: Record<string, Prueba> = {};
  for (const p of pruebas) repriseDePrueba[p.id] = p;
  const repr = new Map<string, { nombre: string; pruebas: Set<string>; percs: number[]; notas: number }>();
  for (const [key, perc] of percPJ) {
    const pId = key.split('|')[0];
    const prueba = repriseDePrueba[parteJinetes[pId]?.prueba_id];
    if (!prueba?.reprise_codigo) continue;
    const r = repr.get(prueba.reprise_codigo) || (repr.set(prueba.reprise_codigo, { nombre: prueba.reprise_codigo, pruebas: new Set(), percs: [], notas: 0 }).get(prueba.reprise_codigo)!);
    r.pruebas.add(prueba.id);
    r.percs.push(perc);
  }
  for (const p of puntosFiltrados) {
    const prueba = repriseDePrueba[parteJinetes[p.participacion_id]?.prueba_id];
    if (prueba?.reprise_codigo) {
      const r = repr.get(prueba.reprise_codigo)!;
      r.notas++;
    }
  }
  const reprises: RepriseStats[] = [...repr.entries()].map(([codigo, r]) => ({
    codigo,
    nombre: r.nombre,
    pruebas: r.pruebas.size,
    notas: r.notas,
    mediaPerc: r.percs.reduce((a, b) => a + b, 0) / r.percs.length,
  })).sort((a, b) => b.mediaPerc - a.mediaPerc);

  // ------ CABALLOS POR EDAD (sin nombres) ------
  const anioActual = new Date().getFullYear();
  const porEdad = new Map<number, { binomios: Set<string>; percs: number[] }>();
  const mediaParte = new Map<string, number>();
  const contadorParte = new Map<string, number>();
  for (const [key, perc] of percPJ) {
    const pId = key.split('|')[0];
    mediaParte.set(pId, (mediaParte.get(pId) || 0) + perc);
    contadorParte.set(pId, (contadorParte.get(pId) || 0) + 1);
  }
  for (const [pId, suma] of mediaParte) {
    mediaParte.set(pId, suma / (contadorParte.get(pId) || 1));
  }
  for (const part of partesFiltradas) {
    const perc = mediaParte.get(part.id);
    if (perc === undefined) continue;
    if (part.anio == null) continue;
    const edad = anioActual - part.anio;
    if (edad < 0) continue;
    const e = porEdad.get(edad) || (porEdad.set(edad, { binomios: new Set(), percs: [] }).get(edad)!);
    e.binomios.add(part.binomio_id || part.id);
    e.percs.push(perc);
  }
  const edades: EdadStats[] = [...porEdad.entries()].map(([edad, e]) => ({
    edad,
    binomios: e.binomios.size,
    participaciones: e.percs.length,
    media: e.percs.reduce((a, b) => a + b, 0) / e.percs.length,
    max: Math.max(...e.percs),
    min: Math.min(...e.percs),
  })).sort((a, b) => a.edad - b.edad);

  // ------ ORDEN DE SALIDA vs POSICIÓN ------
  const scored = partesFiltradas.filter((p) => mediaParte.has(p.id));
  const binomiosUnicos = new Set<string>();
  for (const p of scored) binomiosUnicos.add(p.binomio_id || p.id);

  const pares: { startRank: number; pos: number }[] = [];
  const grupos = new Map<string, { part: Participacion; perc: number; pos: number; startRank: number }[]>();
  for (const part of scored) {
    if (!grupos.has(part.prueba_id)) grupos.set(part.prueba_id, []);
    grupos.get(part.prueba_id)!.push({ part, perc: mediaParte.get(part.id)!, pos: 0, startRank: 0 });
  }
  for (const arr of grupos.values()) {
    arr.sort((a, b) => a.part.orden_salida - b.part.orden_salida);
    arr.forEach((x, i) => { x.startRank = i + 1; });
    arr.sort((a, b) => b.perc - a.perc);
    arr.forEach((x, i) => {
      x.pos = i > 0 && x.perc === arr[i - 1].perc ? arr[i - 1].pos : i + 1;
    });
  }
  for (const arr of grupos.values()) {
    for (const x of arr) pares.push({ startRank: x.startRank, pos: x.pos });
  }

  const porStartRank = new Map<number, { n: number; sumPos: number; mejor: number; peor: number; primeros: number }>();
  for (const p of pares) {
    const g = porStartRank.get(p.startRank) || (porStartRank.set(p.startRank, { n: 0, sumPos: 0, mejor: Infinity, peor: -Infinity, primeros: 0 }).get(p.startRank)!);
    g.n++;
    g.sumPos += p.pos;
    g.mejor = Math.min(g.mejor, p.pos);
    g.peor = Math.max(g.peor, p.pos);
    if (p.pos === 1) g.primeros++;
  }
  const startPos: StartPosStats[] = [...porStartRank.entries()].map(([startRank, g]) => ({
    startRank,
    n: g.n,
    mediaPos: g.sumPos / g.n,
    mejorPos: g.mejor,
    peorPos: g.peor,
    vecesPrimero: g.primeros,
  })).sort((a, b) => a.startRank - b.startRank);

  let correlacion: number | null = null;
  const numPares = pares.length;
  if (numPares >= 2) {
    const ms = pares.reduce((a, b) => a + b.startRank, 0) / numPares;
    const mp = pares.reduce((a, b) => a + b.pos, 0) / numPares;
    let num = 0, denS = 0, denP = 0;
    for (const p of pares) {
      const ds = p.startRank - ms;
      const dp = p.pos - mp;
      num += ds * dp;
      denS += ds * ds;
      denP += dp * dp;
    }
    correlacion = denS > 0 && denP > 0 ? num / Math.sqrt(denS * denP) : null;
  }

  const notaMaxGlobal = (ejercicios.length ? Math.max(...ejercicios.map((e) => e.max)) : -1);
  const notaMinGlobal = (ejercicios.length ? Math.min(...ejercicios.map((e) => e.min)) : Infinity);
  const maxEj = ejercicios.find((e) => e.max === notaMaxGlobal) || null;
  const minEj = ejercicios.find((e) => e.min === notaMinGlobal) || null;

  return {
    totalNotas: puntosFiltrados.length,
    totalParticipaciones: partesFiltradas.length,
    totalPruebas: pruebas.length,
    totalBinomios: binomiosUnicos.size,
    pruebasCoincidentes: pruebas.length,
    mediaGlobal: puntosFiltrados.length ? puntosFiltrados.reduce((a, b) => a + b.nota, 0) / puntosFiltrados.length : 0,
    jueces: juecesStats,
    ejercicios,
    reprises,
    edades,
    startPos,
    correlacion,
    juezGeneroso: juecesStats[0] || null,
    juezEstricto: juecesStats.length ? juecesStats[juecesStats.length - 1] : null,
    maldito: ejercicios[0] || null,
    favorito: ejercicios.length ? ejercicios[ejercicios.length - 1] : null,
    notaMaxGlobal: maxEj ? { nota: maxEj.max, desc: `${maxEj.num}. ${maxEj.letra || ''} ${maxEj.desc}` } : null,
    notaMinGlobal: minEj ? { nota: minEj.min, desc: `${minEj.num}. ${minEj.letra || ''} ${minEj.desc}` } : null,
  };
}

// ============================================================
// COMPONENTE PRINCIPAL
// ============================================================

function EstadisticasContent() {
  const [concursos, setConcursos] = useState<Concurso[]>([]);
  const [concursoSeleccionado, setConcursoSeleccionado] = useState<string>('todos');
  const [datos, setDatos] = useState<Datos>({ concursos: [], pruebas: [], partes: [], puntos: [] });
  const [loading, setLoading] = useState(true);
  const [cargando, setCargando] = useState(false);
  const [error, setError] = useState('');
  const [filtroTipo, setFiltroTipo] = useState<'todas' | 'individuales' | 'equipos'>('todas');
  const [filtroCategoria, setFiltroCategoria] = useState('');
  const [filtroNivel, setFiltroNivel] = useState('');
  const [refreshKey, setRefreshKey] = useState(0);

  useEffect(() => {
    const cargarConcursos = async () => {
      const { data, error: dbError } = await supabase
        .from('concursos')
        .select('id, nombre, ubicacion')
        .order('fecha_inicio', { ascending: false });
      if (dbError) setError(dbError.message);
      else setConcursos(data || []);
      setLoading(false);
    };
    cargarConcursos();
  }, []);

  useEffect(() => {
    const cargar = async () => {
      setCargando(true);
      setError('');
      try {
        let query = supabase
          .from('pruebas')
          .select('id, nombre, categoria, fecha, concurso:concurso_id(nombre), nivel:nivel_id(codigo), tipo_prueba:tipo_prueba_id(codigo), reprise:reprise_id(codigo)');
        if (concursoSeleccionado !== 'todos') {
          query = query.eq('concurso_id', concursoSeleccionado);
        }
        const { data: pruebas, error: errP } = await query;
        if (errP) throw errP;

        const pruebasMap: Prueba[] = (pruebas || []).map((p: any) => ({
          id: p.id,
          nombre: p.nombre,
          categoria: p.categoria,
          nivel_codigo: p.nivel?.codigo || null,
          tipo_codigo: p.tipo_prueba?.codigo || null,
          reprise_codigo: p.reprise?.codigo || null,
          concurso_nombre: p.concurso?.nombre || null,
          fecha: p.fecha,
        }));

        const pruebaIds = pruebasMap.map((p) => p.id);
        if (pruebaIds.length === 0) {
          setDatos({ concursos, pruebas: [], partes: [], puntos: [] });
          setCargando(false);
          return;
        }

        const TAM_PARTES = 1000;
        const participacionesRows: any[] = [];
        if (pruebaIds.length > 0) {
          for (let desde = 0; ; desde += TAM_PARTES) {
            const { data, error } = await supabase
              .from('participaciones')
              .select(`
                id, prueba_id, orden_salida,
                equipo:equipo_id(nombre),
                inscripcion:inscripcion_id(dorsal, binomio:binomio_id(id, nombre_jinete, nombre_caballo, anio))
              `)
              .in('prueba_id', pruebaIds)
              .range(desde, desde + TAM_PARTES - 1);
            if (error) throw error;
            if (!data || data.length === 0) break;
            participacionesRows.push(...data);
            if (data.length < TAM_PARTES) break;
          }
        }
        const partes = participacionesRows;

        const participaciones: Participacion[] = (partes || []).map((p: any) => {
          const insc = p.inscripcion;
          const b = insc?.binomio;
          return {
            id: p.id,
            prueba_id: p.prueba_id,
            dorsal: insc?.dorsal || 0,
            orden_salida: p.orden_salida || 0,
            jinete: b?.nombre_jinete || '-',
            caballo: b?.nombre_caballo || '-',
            binomio_id: b?.id || null,
            anio: b?.anio ?? null,
            equipo: p.equipo?.nombre || null,
          };
        });

        // La API de Supabase limita cada consulta a 1000 filas: paginamos para
        // no perder puntuaciones (por ejemplo, las de pruebas por equipos).
        const TAM = 1000;
        const parteRows: any[] = [];
        if (pruebaIds.length > 0) {
          for (let desde = 0; ; desde += TAM) {
            const { data, error } = await supabase
              .from('puntuaciones')
              .select(`
                nota, participacion_id, ejercicio_reprise_id,
                prueba_juez:prueba_juez_id(letra),
                ejercicio_reprise:ejercicio_reprise_id(numero_orden, letra, descripcion, coeficiente)
              `)
              .in('participacion_id', (partes || []).map((p: any) => p.id))
              .range(desde, desde + TAM - 1);
            if (error) throw error;
            if (!data || data.length === 0) break;
            parteRows.push(...data);
            if (data.length < TAM) break;
          }
        }
        const puntos = parteRows;

        const puntuaciones: Puntuacion[] = puntos.map((p: any) => {
          const ej = p.ejercicio_reprise;
          return {
            participacion_id: p.participacion_id,
            nota: p.nota,
            letraJuez: p.prueba_juez?.letra || '?',
            ejId: p.ejercicio_reprise_id,
            ejNum: ej?.numero_orden || 0,
            ejLetra: ej?.letra || null,
            ejDesc: ej?.descripcion || '',
            ejCoef: ej?.coeficiente || 1,
          };
        });

        setDatos({ concursos, pruebas: pruebasMap, partes: participaciones, puntos: puntuaciones });
      } catch (err: any) {
        setError(err.message || 'Error al cargar estadísticas');
      } finally {
        setCargando(false);
      }
    };
    cargar();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [concursoSeleccionado, refreshKey]);

  useEffect(() => {
    const channel = supabase
      .channel('estadisticas-live')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'puntuaciones' }, () => setRefreshKey((k) => k + 1))
      .subscribe();
    return () => { supabase.removeChannel(channel); };
  }, []);

  const categorias = useMemo(
    () => Array.from(new Set(datos.pruebas.map((p) => p.categoria).filter(Boolean))) as string[],
    [datos.pruebas]
  );
  const niveles = useMemo(
    () => Array.from(new Set(datos.pruebas.map((p) => p.nivel_codigo).filter(Boolean))) as string[],
    [datos.pruebas]
  );

  const stats = useMemo(() => {
    const filtradas = datos.pruebas.filter((p) => {
      if (filtroTipo === 'individuales' && p.tipo_codigo === 'EQU') return false;
      if (filtroTipo === 'equipos' && p.tipo_codigo !== 'EQU') return false;
      if (filtroCategoria && p.categoria !== filtroCategoria) return false;
      if (filtroNivel && p.nivel_codigo !== filtroNivel) return false;
      return true;
    });
    return calcularStats(filtradas, datos.partes, datos.puntos);
  }, [datos, filtroTipo, filtroCategoria, filtroNivel]);

  const fmt = (n: number) => (Number.isFinite(n) ? n.toFixed(2) + '%' : '-');
  const notafmt = (n: number) => (Number.isFinite(n) ? n.toFixed(2) : '-');
  const interpretarRelacion = (r: number) => {
    const abs = Math.abs(r);
    if (abs < 0.2) return 'relación mínima';
    if (abs < 0.4) return 'relación leve';
    if (abs < 0.6) return 'relación moderada';
    return 'relación fuerte';
  };

  const maxMediaJuez = Math.max(...stats.jueces.map((j) => j.mediaPerc), 0);

  if (loading) return <div className="container py-8 text-center">Cargando estadísticas...</div>;

  return (
    <div className="container max-w-7xl py-8">
      <h1 className="text-3xl font-bold mb-2">Estadísticas y Curiosidades</h1>
      <p className="text-gray-600 mb-6">
        Datos agregados de todas las pruebas puntuadas. A modo de curiosidad, sin afán competitivo.
      </p>

      {error && <div className="mb-4 p-4 bg-red-100 border border-red-300 text-red-700 rounded">{error}</div>}

      {/* FILTROS */}
      <div className="card p-6 mb-6">
        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-4">
          <div>
            <label className="block text-sm font-bold mb-2">Concurso:</label>
            <select value={concursoSeleccionado} onChange={(e) => setConcursoSeleccionado(e.target.value)} className="input w-full">
              <option value="todos">Todos los concursos</option>
              {concursos.map((c) => (
                <option key={c.id} value={c.id}>{c.nombre}{c.ubicacion ? ' - ' + c.ubicacion : ''}</option>
              ))}
            </select>
          </div>
          <div>
            <label className="block text-sm font-bold mb-2">Tipo de prueba:</label>
            <select value={filtroTipo} onChange={(e) => setFiltroTipo(e.target.value as any)} className="input w-full">
              <option value="todas">Todas</option>
              <option value="individuales">Individuales</option>
              <option value="equipos">Por equipos</option>
            </select>
          </div>
          <div>
            <label className="block text-sm font-bold mb-2">Categoria:</label>
            <select value={filtroCategoria} onChange={(e) => setFiltroCategoria(e.target.value)} className="input w-full">
              <option value="">Todas</option>
              {categorias.map((c) => <option key={c} value={c}>{c}</option>)}
            </select>
          </div>
          <div>
            <label className="block text-sm font-bold mb-2">Nivel:</label>
            <select value={filtroNivel} onChange={(e) => setFiltroNivel(e.target.value)} className="input w-full">
              <option value="">Todos</option>
              {niveles.map((n) => <option key={n} value={n}>{n}</option>)}
            </select>
          </div>
        </div>
      </div>

      {cargando ? (
        <div className="card p-8 text-center">Calculando estadísticas...</div>
      ) : stats.totalNotas === 0 ? (
        <div className="card p-8 text-center text-gray-600">No hay pruebas puntuadas con estos filtros.</div>
      ) : (
        <>
          {/* KPI */}
          <div className="grid grid-cols-2 md:grid-cols-5 gap-4 mb-6">
            {[
              { label: 'Pruebas', value: String(stats.totalPruebas), icon: '🏇' },
              { label: 'Participaciones', value: String(stats.totalParticipaciones), icon: '🎟️' },
              { label: 'Binomios distintos', value: String(stats.totalBinomios), icon: '👥' },
              { label: 'Notas registradas', value: String(stats.totalNotas), icon: '📝' },
              { label: 'Media global de nota', value: notafmt(stats.mediaGlobal), icon: '📊' },
            ].map((kpi) => (
              <div key={kpi.label} className="card p-4 text-center">
                <div className="text-2xl mb-1">{kpi.icon}</div>
                <div className="text-2xl font-bold">{kpi.value}</div>
                <div className="text-xs text-gray-500 font-semibold uppercase">{kpi.label}</div>
              </div>
            ))}
          </div>

          {/* JUECES POR LETRA */}
          <div className="card p-6 mb-6">
            <h2 className="text-xl font-bold mb-1">Jueces por letra</h2>
            <p className="text-sm text-gray-500 mb-4">Media de porcentaje asignada por cada letra de juez sobre los binomios puntuados.</p>
            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
              {stats.jueces.map((j) => (
                <div key={j.letra} className="rounded-lg border border-gray-200 p-4">
                  <div className="flex items-center justify-between mb-2">
                    <span className="text-4xl font-serif font-bold text-[#173b2f]">{j.letra}</span>
                    <span className="text-lg font-bold">{fmt(j.mediaPerc)}</span>
                  </div>
                  <div className="h-2 rounded-full bg-gray-200 overflow-hidden mb-3">
                    <div className="h-full bg-[#b88746]" style={{ width: (j.mediaPerc / maxMediaJuez) * 100 + '%' }} />
                  </div>
                  <div className="flex justify-between text-xs text-gray-500">
                    <span>Rango {fmt(j.min)} - {fmt(j.max)}</span>
                    <span>{j.notas} notas</span>
                  </div>
                  <p className="text-xs text-gray-400 mt-1">Media de nota bruta: {notafmt(j.media)}</p>
                </div>
              ))}
            </div>
          </div>

          {/* EJERCICIOS */}
          <div className="card p-6 mb-6">
            <div className="flex flex-wrap items-center justify-between gap-2 mb-2">
              <h2 className="text-xl font-bold">Ejercicios / Movimientos</h2>
              <div className="flex flex-wrap gap-2 text-xs">
                {stats.maldito && (
                  <span className="px-2 py-1 rounded-full bg-red-100 text-red-800 font-semibold">
                    🥵 Más difícil: {stats.maldito.num}. {stats.maldito.letra || ''} · {fmt(stats.maldito.media)}
                  </span>
                )}
                {stats.favorito && (
                  <span className="px-2 py-1 rounded-full bg-green-100 text-green-800 font-semibold">
                    😌 Más fácil: {stats.favorito.num}. {stats.favorito.letra || ''} · {fmt(stats.favorito.media)}
                  </span>
                )}
              </div>
            </div>
            <p className="text-sm text-gray-500 mb-4">Media, mejor y peor nota registrada por movimiento (ord. por dificultad: menor media primero).</p>
            <div className="table-responsive">
              <table className="table">
                <thead>
                  <tr>
                    <th className="text-center w-14">N</th>
                    <th className="w-16">Letra</th>
                    <th>Movimiento</th>
                    <th className="text-center w-16">Coef</th>
                    <th className="text-center w-20">Veces</th>
                    <th className="text-right w-24">Media</th>
                    <th className="text-center w-20">Mejor</th>
                    <th className="text-center w-20">Peor</th>
                  </tr>
                </thead>
                <tbody>
                  {stats.ejercicios.slice(0, 30).map((e) => (
                    <tr key={e.ejId}>
                      <td className="text-center font-bold">{e.num}</td>
                      <td className="font-mono text-xs">{e.letra || '-'}</td>
                      <td className="text-xs">{e.desc}</td>
                      <td className="text-center">{e.coef > 1 ? 'x' + e.coef : '1'}</td>
                      <td className="text-center">{e.notas}</td>
                      <td className="text-right font-bold">{notafmt(e.media)}</td>
                      <td className={`text-center font-semibold ${e.max === stats.notaMaxGlobal?.nota ? 'text-green-700' : ''}`}>{e.max.toFixed(2)}</td>
                      <td className={`text-center font-semibold ${e.min === stats.notaMinGlobal?.nota ? 'text-red-700' : ''}`}>{e.min.toFixed(2)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>

          {/* REPRISES */}
          <div className="card p-6 mb-6">
            <h2 className="text-xl font-bold mb-1">Por reprise</h2>
            <p className="text-sm text-gray-500 mb-4">Rendimiento medio de cada reprise en todas sus pruebas.</p>
            <div className="table-responsive">
              <table className="table">
                <thead>
                  <tr>
                    <th>Reprise</th>
                    <th className="text-center w-20">Pruebas</th>
                    <th className="text-center w-20">Notas</th>
                    <th className="text-right w-28">Media %</th>
                  </tr>
                </thead>
                <tbody>
                  {stats.reprises.map((r) => (
                    <tr key={r.codigo}>
                      <td className="font-mono text-xs">{r.codigo}</td>
                      <td className="text-center">{r.pruebas}</td>
                      <td className="text-center">{r.notas}</td>
                      <td className="text-right font-bold">{fmt(r.mediaPerc)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>

          {/* CABALLOS POR EDAD */}
          <div className="card p-6 mb-6">
            <h2 className="text-xl font-bold mb-1">Caballos por edad</h2>
            <p className="text-sm text-gray-400 mb-4">Agregado anónimo por edad del caballo (año actual - año de nacimiento). Sin nombres.</p>
            <div className="table-responsive">
              <table className="table">
                <thead>
                  <tr>
                    <th className="text-center w-20">Edad</th>
                    <th className="text-center w-24">Binomios</th>
                    <th className="text-center w-28">Participaciones</th>
                    <th className="text-right w-28">Media %</th>
                    <th className="text-center w-24">Mejor</th>
                    <th className="text-center w-24">Peor</th>
                  </tr>
                </thead>
                <tbody>
                  {stats.edades.map((e) => (
                    <tr key={e.edad}>
                      <td className="text-center font-bold">{e.edad} años</td>
                      <td className="text-center">{e.binomios}</td>
                      <td className="text-center">{e.participaciones}</td>
                      <td className="text-right font-bold">{fmt(e.media)}</td>
                      <td className="text-center">{fmt(e.max)}</td>
                      <td className="text-center">{fmt(e.min)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>

          {/* ORDEN DE SALIDA vs POSICIÓN */}
          {stats.startPos.length > 0 && (
            <div className="card p-6 mb-6">
              <div className="mb-2 flex flex-wrap items-center justify-between gap-3">
                <h2 className="text-xl font-bold">Orden de salida vs posición</h2>
                {stats.correlacion !== null && (
                  <span className="rounded-full bg-[#173b2f] px-3 py-1 text-xs font-semibold text-[#e8c98d]">
                    Correlación: {stats.correlacion.toFixed(2)} · {interpretarRelacion(stats.correlacion)}
                    {stats.correlacion < -0.2 ? ' · salir antes ayuda' : stats.correlacion > 0.2 ? ' · salir antes penaliza' : ' · sin apenas influencia'}
                  </span>
                )}
              </div>
              <p className="text-sm text-gray-500 mb-4">
                Media de la posición final para cada puesto de salida dentro de cada prueba. Sin nombres.
              </p>
              <div className="table-responsive">
                <table className="table">
                  <thead>
                    <tr>
                      <th className="text-center">Orden de salida</th>
                      <th className="text-center">Veces</th>
                      <th className="text-right">Media posición</th>
                      <th className="text-center">Mejor</th>
                      <th className="text-center">Peor</th>
                      <th className="text-center">1er puestos</th>
                    </tr>
                  </thead>
                  <tbody>
                    {stats.startPos.map((s) => (
                      <tr key={s.startRank}>
                        <td className="text-center font-bold">{s.startRank}º</td>
                        <td className="text-center">{s.n}</td>
                        <td className="text-right font-bold">{s.mediaPos.toFixed(2)}</td>
                        <td className="text-center">{s.mejorPos}º</td>
                        <td className="text-center">{s.peorPos}º</td>
                        <td className="text-center">{s.vecesPrimero}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          )}

          {/* CURIOSIDADES */}
          <div className="card p-6">
            <h2 className="text-xl font-bold mb-4">Curiosidades (casa de apuestas)</h2>
            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
              {stats.juezGeneroso && (
                <div className="rounded-lg border border-red-200 bg-red-50 p-4">
                  <div className="text-3xl mb-1">🎁</div>
                  <p className="font-bold text-red-800">Juez más generoso</p>
                  <p className="text-sm text-gray-600">Letra <b>{stats.juezGeneroso.letra}</b> · media {fmt(stats.juezGeneroso.mediaPerc)}</p>
                </div>
              )}
              {stats.juezEstricto && (
                <div className="rounded-lg border border-blue-200 bg-blue-50 p-4">
                  <div className="text-3xl mb-1">🧊</div>
                  <p className="font-bold text-blue-800">Juez más estricto</p>
                  <p className="text-sm text-gray-600">Letra <b>{stats.juezEstricto.letra}</b> · media {fmt(stats.juezEstricto.mediaPerc)}</p>
                </div>
              )}
              {stats.maldito && (
                <div className="rounded-lg border border-orange-200 bg-orange-50 p-4">
                  <div className="text-3xl mb-1">🥵</div>
                  <p className="font-bold text-orange-800">Movimiento maldito</p>
                  <p className="text-sm text-gray-600 text-xs">{stats.maldito.num}. {stats.maldito.letra || ''} {stats.maldito.desc} · media {notafmt(stats.maldito.media)}</p>
                </div>
              )}
              {stats.favorito && (
                <div className="rounded-lg border border-green-200 bg-green-50 p-4">
                  <div className="text-3xl mb-1">😌</div>
                  <p className="font-bold text-green-800">Movimiento favorito</p>
                  <p className="text-sm text-gray-600 text-xs">{stats.favorito.num}. {stats.favorito.letra || ''} {stats.favorito.desc} · media {notafmt(stats.favorito.media)}</p>
                </div>
              )}
              {stats.notaMaxGlobal && (
                <div className="rounded-lg border border-yellow-200 bg-yellow-50 p-4">
                  <div className="text-3xl mb-1">🏆</div>
                  <p className="font-bold text-yellow-800">Nota más alta registrada</p>
                  <p className="text-sm text-gray-600">{notafmt(stats.notaMaxGlobal.nota)} · {stats.notaMaxGlobal.desc}</p>
                </div>
              )}
              {stats.notaMinGlobal && (
                <div className="rounded-lg border border-gray-200 bg-gray-50 p-4">
                  <div className="text-3xl mb-1">🧨</div>
                  <p className="font-bold text-gray-800">Nota más baja registrada</p>
                  <p className="text-sm text-gray-600">{notafmt(stats.notaMinGlobal.nota)} · {stats.notaMinGlobal.desc}</p>
                </div>
              )}
              {stats.reprises[0] && (
                <div className="rounded-lg border border-teal-200 bg-teal-50 p-4">
                  <div className="text-3xl mb-1">📈</div>
                  <p className="font-bold text-teal-800">Reprise más rentable</p>
                  <p className="text-sm text-gray-600">{stats.reprises[0].codigo} · media {fmt(stats.reprises[0].mediaPerc)}</p>
                </div>
              )}
              {stats.edades[0] && (
                <div className="rounded-lg border border-purple-200 bg-purple-50 p-4">
                  <div className="text-3xl mb-1">🐴</div>
                  <p className="font-bold text-purple-800">Caballo más joven puntuando</p>
                  <p className="text-sm text-gray-600">{stats.edades[0].edad} años</p>
                </div>
              )}
              {stats.edades[stats.edades.length - 1] && (
                <div className="rounded-lg border border-indigo-200 bg-indigo-50 p-4">
                  <div className="text-3xl mb-1">🦙</div>
                  <p className="font-bold text-indigo-800">Caballo más veterano puntuando</p>
                  <p className="text-sm text-gray-600">{stats.edades[stats.edades.length - 1].edad} años</p>
                </div>
              )}
            </div>
          </div>
        </>
      )}
    </div>
  );
}

export default function EstadisticasPage() {
  return <EstadisticasContent />;
}