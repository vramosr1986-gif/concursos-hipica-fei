'use client';

import { useEffect, useState, Suspense, Fragment } from 'react';
import { supabase } from '@/lib/supabase';
import { esPendienteConfirmacion, nombreConMarca } from '@/lib/rfhe-pruebas';
import { CaballoConBandera } from '@/components/BanderaFH';

// ============================================================
// TIPOS
// ============================================================

type Concurso = {
  id: string;
  nombre: string;
  ubicacion: string | null;
  fecha_inicio: string;
};

type PuntuacionJuez = {
  letra: string;
  puntuacion: number;
  numEjercicios: number;
};

type EjercicioDetalle = {
  id: string;
  numero_orden: number;
  letra: string | null;
  descripcion: string;
  coeficiente: number;
  notas: Record<string, number>;
};

type Clasificacion = {
  participacion_id: string;
  /** 0 si todavía no ha salido (sin notas). */
  posicion: number;
  orden_salida: number;
  /** Sin salir: sin notas. Puntuando: le faltan notas. Puntuada: todas. */
  estado: 'pendiente' | 'puntuando' | 'puntuada';
  dorsal: number;
  jinete: string;
  caballo: string;
  fh_caballo: string | null;
  /** "Pte. Confirmación" en la RFHE: se muestra con * tras el nombre. */
  pendiente: boolean;
  media: number;
  numJueces: number;
  puntuaciones: PuntuacionJuez[];
  ejercicios: EjercicioDetalle[];
};

type ResumenJuez = {
  letra: string;
  nombre: string;
  numPuntuaciones: number;
};

type PruebaConResultados = {
  prueba_id: string;
  prueba_nombre: string;
  concurso_nombre: string | null;
  categoria: string | null;
  reprise_nombre: string | null;
  fecha: string;
  hora_inicio: string;
  pista: string | null;
  jueces: ResumenJuez[];
  clasificaciones: Clasificacion[];
};

// ============================================================
// COMPONENTE PRINCIPAL
// ============================================================

function ResultadosContent() {
  const [concursos, setConcursos] = useState<Concurso[]>([]);
  const [concursoSeleccionado, setConcursoSeleccionado] = useState<string>('todos');
  const [pruebasConResultados, setPruebasConResultados] = useState<PruebaConResultados[]>([]);
  const [loading, setLoading] = useState(true);
  const [loadingDatos, setLoadingDatos] = useState(false);
  const [error, setError] = useState('');
  const [filtroCategoria, setFiltroCategoria] = useState<string>('');
  const [filtroEstado, setFiltroEstado] = useState<'todos' | 'en_curso' | 'finalizada' | 'programada'>('todos');
  const [filtroReprise, setFiltroReprise] = useState<string>('');
  const [filtroPrueba, setFiltroPrueba] = useState<string>('');
  const [filtroJinete, setFiltroJinete] = useState<string>('');
  const [filtroCaballo, setFiltroCaballo] = useState<string>('');
  const [filtroFecha, setFiltroFecha] = useState<string>('');
  const [filtroResultados, setFiltroResultados] = useState<'todas' | 'con' | 'sin'>('todas');
  const [busqueda, setBusqueda] = useState('');
  const [ordenacion, setOrdenacion] = useState<'media' | 'dorsal' | 'jinete'>('media');
  const [expandidos, setExpandidos] = useState<string[]>([]);

  useEffect(() => {
    const cargarConcursos = async () => {
      const { data, error: dbError } = await supabase
        .from('concursos')
        .select('id, nombre, ubicacion, fecha_inicio')
        .order('fecha_inicio', { ascending: false });

      if (dbError) {
        setError(dbError.message);
      } else {
        setConcursos(data || []);
      }
      setLoading(false);
    };
    cargarConcursos();
  }, []);

  // Suscripcion Realtime a cambios en puntuaciones
  useEffect(() => {
    const channel = supabase
      .channel('resultados-live')
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'puntuaciones' },
        () => {
          // Cuando cambia una puntuacion, recargamos los datos del concurso actual
          if (concursoSeleccionado) {
            // Disparamos una recarga cambiando un estado interno
            setRefreshKey((k) => k + 1);
          }
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [concursoSeleccionado]);

  const [refreshKey, setRefreshKey] = useState(0);

  useEffect(() => {
    if (!concursoSeleccionado) return;

    const cargarResultados = async () => {
      setLoadingDatos(true);
      setError('');

try {
        // 1. Cargar pruebas de todos los concursos o de uno solo
        let query = supabase
          .from('pruebas')
          .select('id, nombre, categoria, fecha, hora_inicio, pista, reprise_id, reprise:reprise_id(nombre), concurso:concurso_id(nombre)');

        if (concursoSeleccionado !== 'todos') {
          query = query.eq('concurso_id', concursoSeleccionado);
        }

        const { data: pruebas, error: pruebasErr } = await query
          .order('fecha', { ascending: true })
          .order('orden', { ascending: true });

        if (pruebasErr) throw pruebasErr;

        if (!pruebas || pruebas.length === 0) {
          setPruebasConResultados([]);
          setLoadingDatos(false);
          return;
        }

        const pruebaIds = pruebas.map((p: any) => p.id);

        // 2. Cargar jueces de todas las pruebas (1 query) + perfiles (1 query)
        const { data: pruebaJueces } = await supabase
          .from('prueba_jueces')
          .select('id, letra, juez_id, prueba_id')
          .in('prueba_id', pruebaIds)
          .order('letra');

        const juezIds = Array.from(
          new Set((pruebaJueces || []).map((pj: any) => pj.juez_id).filter(Boolean))
        );
        let perfilesMap: Record<string, string> = {};
        if (juezIds.length > 0) {
          const { data: perfiles } = await supabase
            .from('profiles')
            .select('id, nombre, email')
            .in('id', juezIds);

          (perfiles || []).forEach((p: any) => {
            perfilesMap[p.id] = p.nombre || p.email || 'Sin nombre';
          });
        }

        // 3. Cargar participaciones de todas las pruebas (1 query)
        const { data: participaciones } = await supabase
          .from('participaciones')
          .select(`
            id,
            prueba_id,
            orden_salida,
            observaciones,
            inscripcion:inscripcion_id(
              dorsal,
              binomio:binomio_id(nombre_jinete, nombre_caballo, fh_caballo)
            )
          `)
          .in('prueba_id', pruebaIds);

        const participacionIds = (participaciones || []).map((p: any) => p.id);
        const pruebaDeParte: Record<string, string> = {};
        (participaciones || []).forEach((p: any) => {
          pruebaDeParte[p.id] = p.prueba_id;
        });

        // 4. Cargar puntuaciones de todas las participaciones (1 query paginada)
        let puntuacionesRows: any[] = [];
        if (participacionIds.length > 0) {
          const TAM = 1000;
          for (let desde = 0; ; desde += TAM) {
            const { data: puntuaciones, error: errP } = await supabase
              .from('puntuaciones')
              .select(`
                nota,
                participacion_id,
                ejercicio_reprise_id,
                prueba_juez:prueba_juez_id(id, letra),
                ejercicio_reprise:ejercicio_reprise_id(coeficiente)
              `)
              .in('participacion_id', participacionIds)
              .range(desde, desde + TAM - 1);
            if (errP) throw errP;
            if (!puntuaciones || puntuaciones.length === 0) break;
            puntuacionesRows.push(...(puntuaciones as any[]));
            if (puntuaciones.length < TAM) break;
          }
        }

        // 5. Cargar metadatos de todos los ejercicios (1 query)
        const ejercicioIds = Array.from(
          new Set(puntuacionesRows.map((p) => (p as any).ejercicio_reprise_id).filter(Boolean))
        );
        const ejerciciosMetaMap: Record<string, any> = {};
        if (ejercicioIds.length > 0) {
          const { data: ejerciciosData } = await supabase
            .from('ejercicios_reprise')
            .select('id, numero_orden, letra, descripcion, coeficiente')
            .in('id', ejercicioIds);
          (ejerciciosData || []).forEach((e: any) => {
            ejerciciosMetaMap[e.id] = e;
          });
        }

        // Ejercicios de cada reprise: puntuado = todas las notas de todos los jueces.
        const repriseIds = Array.from(new Set((pruebas as any[]).map((p) => p.reprise_id).filter(Boolean)));
        const ejerciciosPorReprise: Record<string, number> = {};
        if (repriseIds.length > 0) {
          const { data: ejs } = await supabase.from('ejercicios_reprise').select('reprise_id').in('reprise_id', repriseIds);
          (ejs || []).forEach((e: any) => { ejerciciosPorReprise[e.reprise_id] = (ejerciciosPorReprise[e.reprise_id] || 0) + 1; });
        }

        // Agrupar por prueba
        const partesPorPrueba: Record<string, any[]> = {};
        const puntosPorPrueba: Record<string, any[]> = {};
        (participaciones || []).forEach((part: any) => {
          (partesPorPrueba[part.prueba_id] ||= []).push(part);
        });
        puntuacionesRows.forEach((p) => {
          const pruebaId = pruebaDeParte[p.participacion_id];
          if (pruebaId) (puntosPorPrueba[pruebaId] ||= []).push(p);
        });

        const resultados: PruebaConResultados[] = [];

        for (const prueba of pruebas as any[]) {
          // Jueces de esta prueba
          const juecesDePrueba = (pruebaJueces || []).filter(
            (pj: any) => pj.prueba_id === prueba.id
          );
          const notasPorJuez: Record<string, number> = {};
          for (const p of puntosPorPrueba[prueba.id] || []) {
            const pjId = p.prueba_juez?.id;
            if (pjId) notasPorJuez[pjId] = (notasPorJuez[pjId] || 0) + 1;
          }
          const jueces: ResumenJuez[] = juecesDePrueba.map((pj: any) => ({
            letra: pj.letra,
            nombre: perfilesMap[pj.juez_id] || 'Sin nombre',
            numPuntuaciones: notasPorJuez[pj.id] || 0,
          }));

          // Clasificaciones de esta prueba
          const clasificaciones: Clasificacion[] = [];
          for (const part of partesPorPrueba[prueba.id] || []) {
            const puntuaciones = (puntosPorPrueba[prueba.id] || []).filter(
              (p) => p.participacion_id === part.id
            );

            const inscripcionBase = (part as any).inscripcion;
            const datosBinomio = {
              participacion_id: part.id,
              orden_salida: (part as any).orden_salida || 0,
              dorsal: inscripcionBase?.dorsal || 0,
              jinete: inscripcionBase?.binomio?.nombre_jinete || '-',
              caballo: inscripcionBase?.binomio?.nombre_caballo || '-',
              fh_caballo: inscripcionBase?.binomio?.fh_caballo || null,
              pendiente: esPendienteConfirmacion((part as any).observaciones),
            };

            if (!puntuaciones || puntuaciones.length === 0) {
              clasificaciones.push({ ...datosBinomio, posicion: 0, estado: 'pendiente', media: 0, numJueces: 0, puntuaciones: [], ejercicios: [] });
              continue;
            }

            // Agrupar por juez
            const porJuez: Record<string, { suma: number; sumaCoef: number; numEjs: number }> = {};
            for (const p of puntuaciones as any[]) {
              const letra = p.prueba_juez?.letra || '?';
              const coef = p.ejercicio_reprise?.coeficiente || 1;
              if (!porJuez[letra]) porJuez[letra] = { suma: 0, sumaCoef: 0, numEjs: 0 };
              porJuez[letra].suma += p.nota * coef;
              porJuez[letra].sumaCoef += coef;
              porJuez[letra].numEjs += 1;
            }

            const puntuacionesPorJuez: PuntuacionJuez[] = Object.entries(porJuez)
              .map(([letra, datos]) => ({
                letra,
                puntuacion: (datos.suma * 100.0) / (datos.sumaCoef * 10),
                numEjercicios: datos.numEjs,
              }))
              .sort((a, b) => a.letra.localeCompare(b.letra));

            if (puntuacionesPorJuez.length === 0) continue;

            const media =
              puntuacionesPorJuez.reduce((acc, p) => acc + p.puntuacion, 0) /
              puntuacionesPorJuez.length;

            // Agrupar notas por ejercicio
            const ejerciciosPorId: Record<string, EjercicioDetalle> = {};
            for (const p of puntuaciones as any[]) {
              const ejId = (p as any).ejercicio_reprise_id;
              if (!ejId) continue;
              const letra = p.prueba_juez?.letra || '?';
              if (!ejerciciosPorId[ejId]) {
                const meta = ejerciciosMetaMap[ejId];
                ejerciciosPorId[ejId] = {
                  id: ejId,
                  numero_orden: meta?.numero_orden || 0,
                  letra: meta?.letra || null,
                  descripcion: meta?.descripcion || '',
                  coeficiente: meta?.coeficiente || p.ejercicio_reprise?.coeficiente || 1,
                  notas: {},
                };
              }
              ejerciciosPorId[ejId].notas[letra] = p.nota;
            }

            const ejercicios = Object.values(ejerciciosPorId).sort(
              (a, b) => a.numero_orden - b.numero_orden
            );

            const necesarias = (ejerciciosPorReprise[prueba.reprise_id] || 0) * juecesDePrueba.length;
            clasificaciones.push({
              ...datosBinomio,
              posicion: 0,
              estado: necesarias > 0 && puntuaciones.length >= necesarias ? 'puntuada' : 'puntuando',
              media: Math.round(media * 100) / 100,
              numJueces: puntuacionesPorJuez.length,
              puntuaciones: puntuacionesPorJuez,
              ejercicios,
            });
          }

          // Ordenar y asignar posiciones
          const ordenados = clasificaciones.filter((c) => c.estado !== 'pendiente').sort((a, b) => b.media - a.media);
          ordenados.forEach((c, i) => {
            const original = clasificaciones.find(
              (x) => x.participacion_id === c.participacion_id
            );
            if (original) original.posicion = i + 1;
          });

          resultados.push({
            prueba_id: prueba.id,
            prueba_nombre: prueba.nombre,
            concurso_nombre: (prueba as any).concurso?.nombre || null,
            categoria: prueba.categoria,
            reprise_nombre: (prueba as any).reprise?.nombre || null,
            fecha: prueba.fecha,
            hora_inicio: prueba.hora_inicio,
            pista: (prueba as any).pista || null,
            jueces,
            clasificaciones,
          });
        }

        setPruebasConResultados(resultados);
      } catch (err: any) {
        setError(err.message || 'Error al cargar resultados');
      } finally {
        setLoadingDatos(false);
      }
    };

    cargarResultados();
  }, [concursoSeleccionado, refreshKey]);

  // Devuelve el estado temporal de una prueba: 'en_curso' | 'programada' | 'finalizada' | 'sin_fecha'
  const estadoTemporal = (
    fecha: string,
    horaInicio: string
  ): 'en_curso' | 'programada' | 'finalizada' | 'sin_fecha' => {
    if (!fecha || !horaInicio) return 'sin_fecha';

    const inicio = new Date(fecha + 'T' + horaInicio);
    const ahora = new Date();
    const finEstimado = new Date(inicio.getTime() + 4 * 60 * 60 * 1000); // 4 horas despues

    if (ahora < inicio) return 'programada';
    if (ahora >= inicio && ahora <= finEstimado) return 'en_curso';
    return 'finalizada';
  };

  const formatearFecha = (fecha: string) => {
    if (!fecha) return '-';
    const [y, m, d] = fecha.split('-');
    return d + '/' + m + '/' + y;
  };

  const ordenarClasificaciones = (cls: Clasificacion[]) => {
    const copia = cls.filter((c) => c.estado !== 'pendiente');
    const sinSalir = cls.filter((c) => c.estado === 'pendiente').sort((a, b) => a.orden_salida - b.orden_salida);
    if (ordenacion === 'media') copia.sort((a, b) => b.media - a.media);
    else if (ordenacion === 'dorsal') copia.sort((a, b) => a.dorsal - b.dorsal);
    else if (ordenacion === 'jinete') copia.sort((a, b) => a.jinete.localeCompare(b.jinete));
    return [...copia, ...sinSalir];
  };

const categorias = Array.from(
    new Set(pruebasConResultados.map((p) => p.categoria).filter(Boolean))
  ) as string[];

  const reprises = Array.from(
    new Set(pruebasConResultados.map((p) => p.reprise_nombre).filter(Boolean))
  ).sort() as string[];

  const nombresPrueba = Array.from(new Set(pruebasConResultados.map((p) => p.prueba_nombre))).sort((a, b) => a.localeCompare(b, 'es'));
  const sinAcentos = (t: string) => t.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase();
  const jineteBuscado = sinAcentos(filtroJinete.trim());
  const caballoBuscado = sinAcentos(filtroCaballo.trim());
  /** Con filtro de jinete o caballo, en cada prueba solo salen sus filas. */
  const coincideBinomio = (c: Clasificacion) =>
    (!jineteBuscado || sinAcentos(c.jinete).includes(jineteBuscado)) &&
    (!caballoBuscado || sinAcentos(c.caballo).includes(caballoBuscado));

  const textoBusqueda = busqueda.trim().toLowerCase();

  const pruebasFiltradas = pruebasConResultados.filter((p) => {
    if (filtroCategoria && p.categoria !== filtroCategoria) return false;
    if (filtroEstado !== 'todos' && estadoTemporal(p.fecha, p.hora_inicio) !== filtroEstado) return false;
    if (filtroReprise && p.reprise_nombre !== filtroReprise) return false;
    if (filtroPrueba && p.prueba_nombre !== filtroPrueba) return false;
    if ((jineteBuscado || caballoBuscado) && !p.clasificaciones.some(coincideBinomio)) return false;
    if (filtroFecha && p.fecha !== filtroFecha) return false;
    const conNotas = p.clasificaciones.some((c) => c.estado !== 'pendiente');
    if (filtroResultados === 'con' && !conNotas) return false;
    if (filtroResultados === 'sin' && conNotas) return false;
    if (textoBusqueda) {
      const coincide =
        p.prueba_nombre.toLowerCase().includes(textoBusqueda) ||
        (p.reprise_nombre || '').toLowerCase().includes(textoBusqueda) ||
        (p.concurso_nombre || '').toLowerCase().includes(textoBusqueda) ||
        p.clasificaciones.some(
          (c) =>
            c.jinete.toLowerCase().includes(textoBusqueda) ||
            c.caballo.toLowerCase().includes(textoBusqueda)
        );
      if (!coincide) return false;
    }
    return true;
  });

  const colorPuesto = (pos: number) => {
    if (pos === 1) return 'bg-yellow-50 border-l-4 border-yellow-400';
    if (pos === 2) return 'bg-gray-50 border-l-4 border-gray-400';
    if (pos === 3) return 'bg-orange-50 border-l-4 border-orange-400';
    return '';
  };

  const medallaEmoji = (pos: number) => {
    if (pos === 1) return '🥇';
    if (pos === 2) return '🥈';
    if (pos === 3) return '🥉';
    return '';
  };

  // Todas las letras de jueces posibles
  const letrasJueces = ['A', 'B', 'C', 'D', 'E'];

  if (loading) return <div className="container py-8 text-center">Cargando concursos...</div>;

  return (
    <div className="container max-w-7xl py-8">
      <div className="flex items-center gap-3 mb-6">
        <h1 className="text-3xl font-bold">Resultados y Clasificaciones</h1>
        {(() => {
          if (!concursoSeleccionado || pruebasConResultados.length === 0) return null;

          // Comprobar si ALGUNA prueba del concurso esta en curso ahora mismo
          const algunaEnCurso = pruebasConResultados.some((p) => {
            return estadoTemporal(p.fecha, p.hora_inicio) === 'en_curso';
          });

          if (!algunaEnCurso) return null;

          return (
            <span className="px-3 py-1 rounded-full bg-red-100 text-red-800 text-xs font-bold flex items-center gap-2">
              <span className="w-2 h-2 rounded-full bg-red-500 animate-pulse"></span>
              EN VIVO
            </span>
          );
        })()}
      </div>

      {error && (
        <div className="mb-4 p-4 bg-red-100 border border-red-300 text-red-700 rounded">
          {error}
        </div>
      )}

{/* FILTROS */}
      <div className="card p-6 mb-6">
        <div className="mb-4 flex flex-col sm:flex-row sm:items-center gap-3">
          <div className="flex-1">
            <label className="block text-sm font-bold mb-2">Buscar:</label>
            <input
              type="search"
              value={busqueda}
              onChange={(e) => setBusqueda(e.target.value)}
              placeholder="Prueba, concurso, reprise, jinete o caballo..."
              className="input w-full"
            />
          </div>
          <div className="flex items-end gap-2">
            <span className="text-sm text-gray-600 whitespace-nowrap pb-2">
              {pruebasFiltradas.length} de {pruebasConResultados.length} pruebas
            </span>
            <button
              onClick={() => {
                setConcursoSeleccionado('todos');
                setFiltroCategoria('');
                setFiltroEstado('todos');
                setFiltroReprise('');
                setFiltroPrueba('');
                setFiltroJinete('');
                setFiltroCaballo('');
                setFiltroFecha('');
                setFiltroResultados('todas');
                setBusqueda('');
              }}
              className="btn btn-outline text-sm whitespace-nowrap"
            >
              Limpiar filtros
            </button>
          </div>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-4">
          <div>
            <label className="block text-sm font-bold mb-2">Concurso:</label>
            <select
              value={concursoSeleccionado}
              onChange={(e) => setConcursoSeleccionado(e.target.value)}
              className="input w-full"
            >
              <option value="todos">Todos los concursos</option>
              {concursos.length === 0 && <option value="">No hay concursos</option>}
              {concursos.map((c) => (
                <option key={c.id} value={c.id}>
                  {c.nombre} {c.ubicacion ? '- ' + c.ubicacion : ''}
                </option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">Estado:</label>
            <select
              value={filtroEstado}
              onChange={(e) => setFiltroEstado(e.target.value as any)}
              className="input w-full"
            >
              <option value="todos">Todos</option>
              <option value="en_curso">En directo</option>
              <option value="finalizada">Acabadas</option>
              <option value="programada">Por empezar</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">Categoria:</label>
            <select
              value={filtroCategoria}
              onChange={(e) => setFiltroCategoria(e.target.value)}
              className="input w-full"
            >
              <option value="">Todas</option>
              {categorias.map((c) => (
                <option key={c} value={c}>{c}</option>
              ))}
            </select>
          </div>

          <div>
            <label htmlFor="filtro-prueba" className="block text-sm font-bold mb-2">Prueba:</label>
            <select id="filtro-prueba" value={filtroPrueba} onChange={(e) => setFiltroPrueba(e.target.value)} className="input w-full">
              <option value="">Todas</option>
              {nombresPrueba.map((n) => <option key={n} value={n}>{n}</option>)}
            </select>
          </div>

          <div>
            <label htmlFor="filtro-jinete" className="block text-sm font-bold mb-2">Jinete:</label>
            <input id="filtro-jinete" type="search" value={filtroJinete} onChange={(e) => setFiltroJinete(e.target.value)} placeholder="Nombre o apellido" className="input w-full" />
          </div>

          <div>
            <label htmlFor="filtro-caballo" className="block text-sm font-bold mb-2">Caballo:</label>
            <input id="filtro-caballo" type="search" value={filtroCaballo} onChange={(e) => setFiltroCaballo(e.target.value)} placeholder="Nombre del caballo" className="input w-full" />
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">Reprise:</label>
            <select
              value={filtroReprise}
              onChange={(e) => setFiltroReprise(e.target.value)}
              className="input w-full"
            >
              <option value="">Todas</option>
              {reprises.map((r) => (
                <option key={r} value={r}>{r}</option>
              ))}
            </select>
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">Fecha:</label>
            <input
              type="date"
              value={filtroFecha}
              onChange={(e) => setFiltroFecha(e.target.value)}
              className="input w-full"
            />
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">Resultados:</label>
            <select
              value={filtroResultados}
              onChange={(e) => setFiltroResultados(e.target.value as any)}
              className="input w-full"
            >
              <option value="todas">Todas</option>
              <option value="con">Con resultados</option>
              <option value="sin">Sin resultados</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-bold mb-2">Ordenar por:</label>
            <select
              value={ordenacion}
              onChange={(e) => setOrdenacion(e.target.value as any)}
              className="input w-full"
            >
              <option value="media">Media (mayor a menor)</option>
              <option value="dorsal">Dorsal</option>
              <option value="jinete">Jinete (A-Z)</option>
            </select>
          </div>
        </div>
      </div>

      {/* RESULTADOS */}
      {loadingDatos ? (
        <div className="card p-8 text-center">Cargando resultados...</div>
      ) : pruebasFiltradas.length === 0 ? (
        <div className="card p-8 text-center text-gray-600">No hay pruebas para mostrar.</div>
      ) : (
        <div className="space-y-8">
{pruebasFiltradas.map((prueba) => {
            const conPuntuacion = prueba.clasificaciones.filter((c) => c.estado !== 'pendiente');
            const top3Individual = [...conPuntuacion].sort((a, b) => b.media - a.media).slice(0, 3);

            return (
              <div key={prueba.prueba_id} className="card overflow-hidden">
                {/* CABECERA */}
                <div className="p-4 bg-[#112d24] text-white">
                  <div className="flex items-start justify-between gap-4">
                    <div>
<div className="flex items-center gap-3 mb-1">
                        <h2 className="text-xl font-bold">{prueba.prueba_nombre}</h2>
                        {concursoSeleccionado === 'todos' && prueba.concurso_nombre && (
                          <span className="px-2 py-0.5 rounded-full bg-amber-400 text-amber-950 text-xs font-bold">
                            {prueba.concurso_nombre}
                          </span>
                        )}
                        {(() => {
                          const estado = estadoTemporal(prueba.fecha, prueba.hora_inicio);
                          if (estado === 'en_curso') {
                            return (
                              <span className="px-2 py-0.5 rounded-full bg-red-500 text-white text-xs font-bold flex items-center gap-1">
                                <span className="w-1.5 h-1.5 rounded-full bg-white animate-pulse"></span>
                                EN VIVO
                              </span>
                            );
                          }
                          if (estado === 'finalizada') {
                            return (
                              <span className="px-2 py-0.5 rounded-full bg-green-600 text-white text-xs font-bold">
                                ✓ FINALIZADA
                              </span>
                            );
                          }
                          if (estado === 'programada') {
                            return (
                              <span className="px-2 py-0.5 rounded-full bg-gray-400 text-white text-xs font-bold">
                                ⏱ PROGRAMADA
                              </span>
                            );
                          }
                          return null;
                        })()}
                      </div>
                      <p className="text-sm opacity-75">
                        {formatearFecha(prueba.fecha)} | {prueba.hora_inicio.substring(0, 5)}
                        {prueba.pista && ' | ' + prueba.pista}
                        {prueba.categoria && ' | ' + prueba.categoria}
                        {prueba.reprise_nombre && ' | ' + prueba.reprise_nombre}
                      </p>
                    </div>
<div className="text-right">
                      <p className="text-xs opacity-75">Binomios puntuados</p>
                      <p className="text-2xl font-bold">
                        {prueba.clasificaciones.filter((c) => c.estado === 'puntuada').length}
                        <span className="text-base font-normal opacity-75"> de {prueba.clasificaciones.length}</span>
                      </p>
                    </div>
                  </div>
                </div>

                {/* RESUMEN DE JUECES */}
{prueba.jueces.length > 0 && (
                  <div className="p-4 bg-gray-50 border-b">
                    <p className="text-xs font-bold text-gray-600 uppercase mb-2">
                      Jueces de esta prueba
                    </p>
                    <div className="flex flex-wrap gap-2">
                      {prueba.jueces.map((j) => (
                        <div
                          key={j.letra}
                          className="px-3 py-2 rounded border border-gray-200 bg-white"
                        >
                          <span className="font-bold text-lg mr-2">{j.letra}</span>
                          <span className="text-sm">{j.nombre}</span>
                        </div>
                      ))}
                    </div>
                  </div>
                )}

{/* PESTANA INDIVIDUAL */}
                <>
                    {top3Individual.length > 0 && (
                      <div className="p-6 bg-gradient-to-b from-gray-50 to-white border-b">
                        <p className="text-center text-sm text-gray-600 mb-4 font-semibold uppercase tracking-wide">
                          Podio
                        </p>
                        <div className="flex items-end justify-center gap-4">
                          {top3Individual[1] && (
                            <div className="text-center flex-1 max-w-xs">
                              <div className="text-4xl mb-2">🥈</div>
                              <div className="bg-gray-200 rounded-t-lg p-4 pt-8 pb-4">
                                <p className="font-bold truncate">{nombreConMarca(top3Individual[1].jinete, top3Individual[1].pendiente)}</p>
                                <p className="text-xs text-gray-600 truncate"><CaballoConBandera nombre={top3Individual[1].caballo} fh={top3Individual[1].fh_caballo} /></p>

                                <p className="text-xl font-bold mt-2">
                                  {top3Individual[1].media.toFixed(2)}%
                                </p>
                              </div>
                              <div className="bg-gray-300 h-12 flex items-center justify-center font-bold text-2xl text-gray-700">
                                2
                              </div>
                            </div>
                          )}
                          {top3Individual[0] && (
                            <div className="text-center flex-1 max-w-xs">
                              <div className="text-5xl mb-2">🥇</div>
                              <div className="bg-yellow-200 rounded-t-lg p-4 pt-8 pb-4">
                                <p className="font-bold truncate">{nombreConMarca(top3Individual[0].jinete, top3Individual[0].pendiente)}</p>
                                <p className="text-xs text-gray-700 truncate"><CaballoConBandera nombre={top3Individual[0].caballo} fh={top3Individual[0].fh_caballo} /></p>

                                <p className="text-2xl font-bold mt-2">
                                  {top3Individual[0].media.toFixed(2)}%
                                </p>
                              </div>
                              <div className="bg-yellow-400 h-16 flex items-center justify-center font-bold text-3xl text-yellow-900">
                                1
                              </div>
                            </div>
                          )}
                          {top3Individual[2] && (
                            <div className="text-center flex-1 max-w-xs">
                              <div className="text-4xl mb-2">🥉</div>
                              <div className="bg-orange-200 rounded-t-lg p-4 pt-8 pb-4">
                                <p className="font-bold text-sm truncate">{nombreConMarca(top3Individual[2].jinete, top3Individual[2].pendiente)}</p>
                                <p className="text-xs text-gray-700 truncate"><CaballoConBandera nombre={top3Individual[2].caballo} fh={top3Individual[2].fh_caballo} /></p>

                                <p className="text-lg font-bold mt-2">
                                  {top3Individual[2].media.toFixed(2)}%
                                </p>
                              </div>
                              <div className="bg-orange-400 h-8 flex items-center justify-center font-bold text-2xl text-orange-900">
                                3
                              </div>
                            </div>
                          )}
                        </div>
                      </div>
                    )}

                    {prueba.clasificaciones.length === 0 ? (
                      <div className="p-6 text-center text-gray-600">
                        Esta prueba todavía no tiene binomios.
                      </div>
                    ) : (
                      <div className="table-responsive">
                        <table className="table">
<thead>
                            <tr>
                              <th className="text-center w-16">Pos.</th>
                              <th className="hidden sm:table-cell text-center w-16">Dorsal</th>
                              <th className="hidden sm:table-cell">Jinete</th>
                              <th className="hidden sm:table-cell">Caballo</th>
                              <th className="sm:hidden">Binomio</th>
                              {letrasJueces.map((l) => (
                                <th key={l} className="text-center w-20">
                                  {l}
                                </th>
                              ))}
                              <th className="text-right w-24">Media</th>
                              <th className="text-center w-24"></th>
                              <th className="text-center w-24"></th>
                            </tr>
                          </thead>
                          <tbody>
                            {ordenarClasificaciones(prueba.clasificaciones).filter(coincideBinomio).map((c) => {
                              const puntuacionPorLetra: Record<string, number | null> = {};
                              letrasJueces.forEach((l) => {
                                const p = c.puntuaciones.find((pu) => pu.letra === l);
                                puntuacionPorLetra[l] = p ? p.puntuacion : null;
                              });

                              const abierto = expandidos.includes(c.participacion_id);

                              return (
                                <Fragment key={c.participacion_id}>
                                  <tr className={colorPuesto(c.posicion)}>
<td className="text-center font-bold">
                                      {c.posicion > 0 ? <>{medallaEmoji(c.posicion)} {c.posicion}º</> : <span className="text-gray-400">—</span>}
                                      <span className="sm:hidden text-[0.65rem] font-normal text-gray-500">
                                        {' '}· {c.dorsal}
                                      </span>
                                    </td>
                                    <td className="hidden sm:table-cell text-center font-bold">
                                      {c.dorsal}
                                    </td>
                                    <td className="hidden sm:table-cell">
                                      {nombreConMarca(c.jinete, c.pendiente)}
                                      {c.estado !== 'puntuada' && (
                                        <span className={`ml-2 rounded px-1.5 py-0.5 text-xs ${c.estado === 'pendiente' ? 'bg-gray-100 text-gray-600' : 'bg-amber-100 text-amber-800'}`}>
                                          {c.estado === 'pendiente' ? 'Sin salir' : 'Puntuando'}
                                        </span>
                                      )}
                                    </td>
                                    <td className="hidden sm:table-cell"><CaballoConBandera nombre={c.caballo} fh={c.fh_caballo} /></td>
                                    <td className="sm:hidden">
                                      <span className="block">
                                        {nombreConMarca(c.jinete, c.pendiente)}
                                        {c.estado !== 'puntuada' && <span className="ml-1 text-xs font-normal text-gray-500">({c.estado === 'pendiente' ? 'sin salir' : 'puntuando'})</span>}
                                      </span>
                                      <span className="block text-xs font-normal text-gray-500">
                                        <CaballoConBandera nombre={c.caballo} fh={c.fh_caballo} />
                                      </span>
                                    </td>

                                    {letrasJueces.map((l) => (
                                      <td key={l} className="text-center text-sm">
                                        {puntuacionPorLetra[l] !== null
                                          ? puntuacionPorLetra[l]!.toFixed(2) + '%'
                                          : '-'}
                                      </td>
                                    ))}
                                    <td className="text-right font-bold text-lg">
                                      {c.estado === 'pendiente' ? <span className="text-gray-400">—</span> : `${c.media.toFixed(2)}%`}
                                    </td>
                                    <td className="text-center">
                                      {c.ejercicios.length > 0 && <button
                                        onClick={() =>
                                          setExpandidos((prev) => abierto ? prev.filter((x) => x !== c.participacion_id) : [...prev, c.participacion_id])
                                        }
                                        className="text-primary hover:underline text-sm font-medium"
                                      >
                                        {abierto ? 'Ocultar' : 'Ver detalle'}
                                      </button>}
                                    </td>
                                  </tr>

                                  {abierto && (
                                    <tr>
                                      <td colSpan={5 + letrasJueces.length + 2} className="bg-blue-50 p-4">
                                        <h4 className="font-bold mb-2">
                                          Detalle por ejercicio · {c.jinete} / {c.caballo}
                                        </h4>
                                        <div className="table-responsive">
                                          <table className="table text-sm">
                                            <thead>
                                              <tr>
                                                <th className="text-center w-14">N</th>
                                                <th className="w-16">Letra</th>
                                                <th>Movimiento</th>
                                                <th className="text-center w-16">Coef</th>
                                                {letrasJueces.map((l) => (
                                                  <th key={l} className="text-center w-20">
                                                    {l}
                                                  </th>
                                                ))}
                                                <th className="text-center w-24">Media</th>
                                              </tr>
                                            </thead>
                                            <tbody>
                                              {c.ejercicios.map((ej) => {
                                                const notas = letrasJueces
                                                  .map((l) => ej.notas[l])
                                                  .filter((n) => n !== undefined) as number[];
                                                const mediaEj =
                                                  notas.length > 0
                                                    ? notas.reduce((a, b) => a + b, 0) / notas.length
                                                    : 0;

                                                return (
                                                  <tr key={ej.id}>
                                                    <td className="text-center font-bold">
                                                      {ej.numero_orden}
                                                    </td>
                                                    <td className="font-mono text-xs">
                                                      {ej.letra || '-'}
                                                    </td>
                                                    <td className="text-xs">{ej.descripcion}</td>
                                                    <td className="text-center">
                                                      {ej.coeficiente > 1
                                                        ? 'x' + ej.coeficiente
                                                        : '1'}
                                                    </td>
                                                    {letrasJueces.map((l) => (
                                                      <td key={l} className="text-center">
                                                        {ej.notas[l] !== undefined
                                                          ? ej.notas[l].toFixed(1)
                                                          : '-'}
                                                      </td>
                                                    ))}
                                                    <td className="text-center font-bold">
                                                      {mediaEj.toFixed(2)}
                                                    </td>
                                                  </tr>
                                                );
                                              })}
                                            </tbody>
                                            <tfoot>
                                              <tr className="bg-gray-100 border-t-2 font-bold">
                                                <td colSpan={4} className="text-right pr-2">
                                                  SUMA:
                                                </td>
                                                {letrasJueces.map((l) => {
                                                  const punt = c.puntuaciones.find(
                                                    (p) => p.letra === l
                                                  );
                                                  return (
                                                    <td key={l} className="text-center">
                                                      {punt ? punt.puntuacion.toFixed(2) + '%' : '-'}
                                                    </td>
                                                  );
                                                })}
                                                <td className="text-center text-blue-700">
                                                  {c.media.toFixed(2)}%
                                                </td>
                                              </tr>
                                            </tfoot>
                                          </table>
                                        </div>
                                      </td>
                                    </tr>
                                  )}
                                </Fragment>
                              );
                            })}
                          </tbody>
                        </table>
                      </div>
                    )}
                    {prueba.clasificaciones.some((c) => c.pendiente) && (
                      <p className="border-t px-4 py-2 text-xs text-gray-600">* Pendiente de confirmación en la RFHE.</p>
                    )}
                  </>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}

export default function ResultadosPage() {
  return (
    <Suspense fallback={<div className="container py-8 text-center">Cargando...</div>}>
      <ResultadosContent />
    </Suspense>
  );
}