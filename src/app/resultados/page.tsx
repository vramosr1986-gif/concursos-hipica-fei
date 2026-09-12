'use client';

import { useEffect, useState, Suspense, Fragment } from 'react';
import { supabase } from '@/lib/supabase';

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
  posicion: number;
  dorsal: number;
  jinete: string;
  caballo: string;
  equipo_nombre: string | null;
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

type MiembroEquipo = {
  posicion_miembro: number;
  dorsal: number;
  nombre_jinete: string;
  nombre_caballo: string;
  porcentaje: number;
};

type EquipoClasificado = {
  equipo_id: string;
  equipo_nombre: string;
  puntuacion_equipo: number;
  posicion_equipo: number;
  miembros: MiembroEquipo[];
};

type PruebaConResultados = {
  prueba_id: string;
  prueba_nombre: string;
  categoria: string | null;
  reprise_nombre: string | null;
  fecha: string;
  hora_inicio: string;
  jueces: ResumenJuez[];
  clasificaciones: Clasificacion[];
  equipos: EquipoClasificado[];
};

// ============================================================
// COMPONENTE PRINCIPAL
// ============================================================

function ResultadosContent() {
  const [concursos, setConcursos] = useState<Concurso[]>([]);
  const [concursoSeleccionado, setConcursoSeleccionado] = useState<string>('');
  const [pruebasConResultados, setPruebasConResultados] = useState<PruebaConResultados[]>([]);
  const [loading, setLoading] = useState(true);
  const [loadingDatos, setLoadingDatos] = useState(false);
  const [error, setError] = useState('');
  const [filtroCategoria, setFiltroCategoria] = useState<string>('');
  const [ordenacion, setOrdenacion] = useState<'media' | 'dorsal' | 'jinete'>('media');
  const [pestanaActiva, setPestanaActiva] = useState<Record<string, 'individual' | 'equipos'>>({});
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
        if (data && data.length > 0) {
          setConcursoSeleccionado(data[0].id);
        }
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
        // 1. Cargar pruebas
        const { data: pruebas, error: pruebasErr } = await supabase
          .from('pruebas')
          .select('id, nombre, categoria, fecha, hora_inicio, reprise_id, reprise:reprise_id(nombre)')
          .eq('concurso_id', concursoSeleccionado)
          .order('fecha', { ascending: true })
          .order('orden', { ascending: true });

        if (pruebasErr) throw pruebasErr;

        if (!pruebas || pruebas.length === 0) {
          setPruebasConResultados([]);
          setLoadingDatos(false);
          return;
        }

        const resultados: PruebaConResultados[] = [];

        for (const prueba of pruebas) {
          // 2. Cargar jueces de la prueba
          const { data: pruebaJueces } = await supabase
            .from('prueba_jueces')
            .select('id, letra, juez:juez_id(nombre)')
            .eq('prueba_id', prueba.id)
            .order('letra');

          const jueces: ResumenJuez[] = [];
          for (const pj of pruebaJueces || []) {
            // Contar cuantas puntuaciones ha hecho este juez en esta prueba
            const { data: parts } = await supabase
              .from('participaciones')
              .select('id')
              .eq('prueba_id', prueba.id);

            const participacionIds = (parts || []).map((p: any) => p.id);

            let numPuntuaciones = 0;
            if (participacionIds.length > 0) {
              const { count } = await supabase
                .from('puntuaciones')
                .select('id', { count: 'exact', head: true })
                .eq('prueba_juez_id', pj.id)
                .in('participacion_id', participacionIds);

              numPuntuaciones = count || 0;
            }

            jueces.push({
              letra: (pj as any).letra,
              nombre: (pj as any).juez?.nombre || 'Sin nombre',
              numPuntuaciones,
            });
          }

          // 3. Cargar participaciones
          const { data: participaciones } = await supabase
            .from('participaciones')
            .select(`
              id,
              orden_salida,
              equipo:equipo_id(nombre),
              inscripcion:inscripcion_id(
                dorsal,
                binomio:binomio_id(nombre_jinete, nombre_caballo)
              )
            `)
            .eq('prueba_id', prueba.id)
            .order('orden_salida', { ascending: true });

          // 4. Cargar clasificaciones
          const clasificaciones: Clasificacion[] = [];

          for (const part of participaciones || []) {
            const { data: puntuaciones } = await supabase
              .from('puntuaciones')
              .select(`
                nota,
                ejercicio_reprise_id,
                prueba_juez:prueba_juez_id(id, letra),
                ejercicio_reprise:ejercicio_reprise_id(coeficiente)
              `)
              .eq('participacion_id', part.id);

            if (!puntuaciones || puntuaciones.length === 0) continue;

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

            const inscripcion = (part as any).inscripcion;
            const binomio = inscripcion?.binomio;

            // Agrupar notas por ejercicio
            const ejerciciosPorId: Record<string, EjercicioDetalle> = {};
            for (const p of puntuaciones as any[]) {
              const ejId = (p as any).ejercicio_reprise_id;
              if (!ejId) continue;
              const letra = p.prueba_juez?.letra || '?';
              if (!ejerciciosPorId[ejId]) {
                ejerciciosPorId[ejId] = {
                  id: ejId,
                  numero_orden: 0,
                  letra: null,
                  descripcion: '',
                  coeficiente: p.ejercicio_reprise?.coeficiente || 1,
                  notas: {},
                };
              }
              ejerciciosPorId[ejId].notas[letra] = p.nota;
            }

            // Traer metadatos de los ejercicios
            const ejercicioIds = Object.keys(ejerciciosPorId);
            if (ejercicioIds.length > 0) {
              const { data: ejerciciosData } = await supabase
                .from('ejercicios_reprise')
                .select('id, numero_orden, letra, descripcion, coeficiente')
                .in('id', ejercicioIds);
              (ejerciciosData || []).forEach((e: any) => {
                if (ejerciciosPorId[e.id]) {
                  ejerciciosPorId[e.id].numero_orden = e.numero_orden;
                  ejerciciosPorId[e.id].letra = e.letra;
                  ejerciciosPorId[e.id].descripcion = e.descripcion;
                  ejerciciosPorId[e.id].coeficiente = e.coeficiente;
                }
              });
            }

            const ejercicios = Object.values(ejerciciosPorId).sort(
              (a, b) => a.numero_orden - b.numero_orden
            );

            clasificaciones.push({
              participacion_id: part.id,
              posicion: 0,
              dorsal: inscripcion?.dorsal || 0,
              jinete: binomio?.nombre_jinete || '-',
              caballo: binomio?.nombre_caballo || '-',
              equipo_nombre: (part as any).equipo?.nombre || null,
              media: Math.round(media * 100) / 100,
              numJueces: puntuacionesPorJuez.length,
              puntuaciones: puntuacionesPorJuez,
              ejercicios,
            });
          }

          // Ordenar y asignar posiciones
          const ordenados = [...clasificaciones].sort((a, b) => b.media - a.media);
          ordenados.forEach((c, i) => {
            const original = clasificaciones.find(
              (x) => x.participacion_id === c.participacion_id
            );
            if (original) original.posicion = i + 1;
          });

          // 5. Cargar equipos
          const { data: equiposData } = await supabase
            .from('v_clasificacion_equipos')
            .select('*')
            .eq('prueba_id', prueba.id)
            .order('posicion_equipo', { ascending: true })
            .order('posicion_miembro', { ascending: true });

          const equiposPorId: Record<string, EquipoClasificado> = {};
          (equiposData || []).forEach((e: any) => {
            if (!equiposPorId[e.equipo_id]) {
              equiposPorId[e.equipo_id] = {
                equipo_id: e.equipo_id,
                equipo_nombre: e.equipo_nombre,
                puntuacion_equipo: e.puntuacion_equipo,
                posicion_equipo: e.posicion_equipo,
                miembros: [],
              };
            }
            equiposPorId[e.equipo_id].miembros.push({
              posicion_miembro: e.posicion_miembro,
              dorsal: e.dorsal,
              nombre_jinete: e.nombre_jinete,
              nombre_caballo: e.nombre_caballo,
              porcentaje: e.porcentaje,
            });
          });

          const equipos: EquipoClasificado[] = Object.values(equiposPorId).sort(
            (a, b) => a.posicion_equipo - b.posicion_equipo
          );

          resultados.push({
            prueba_id: prueba.id,
            prueba_nombre: prueba.nombre,
            categoria: prueba.categoria,
            reprise_nombre: (prueba as any).reprise?.nombre || null,
            fecha: prueba.fecha,
            hora_inicio: prueba.hora_inicio,
            jueces,
            clasificaciones,
            equipos,
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
    const copia = [...cls];
    if (ordenacion === 'media') copia.sort((a, b) => b.media - a.media);
    else if (ordenacion === 'dorsal') copia.sort((a, b) => a.dorsal - b.dorsal);
    else if (ordenacion === 'jinete') copia.sort((a, b) => a.jinete.localeCompare(b.jinete));
    return copia;
  };

  const categorias = Array.from(
    new Set(pruebasConResultados.map((p) => p.categoria).filter(Boolean))
  ) as string[];

  const pruebasFiltradas = filtroCategoria
    ? pruebasConResultados.filter((p) => p.categoria === filtroCategoria)
    : pruebasConResultados;

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
        <div className="grid md:grid-cols-3 gap-4">
          <div>
            <label className="block text-sm font-bold mb-2">Concurso:</label>
            <select
              value={concursoSeleccionado}
              onChange={(e) => setConcursoSeleccionado(e.target.value)}
              className="input w-full"
            >
              {concursos.length === 0 && <option value="">No hay concursos</option>}
              {concursos.map((c) => (
                <option key={c.id} value={c.id}>
                  {c.nombre} {c.ubicacion ? '- ' + c.ubicacion : ''}
                </option>
              ))}
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
            const tieneEquipos = prueba.equipos.length > 0;
            const pestana = pestanaActiva[prueba.prueba_id] || 'individual';
            const conPuntuacion = prueba.clasificaciones.filter((c) => c.numJueces > 0);
            const top3Individual = [...conPuntuacion].sort((a, b) => b.media - a.media).slice(0, 3);
            const top3Equipos = prueba.equipos.slice(0, 3);

            return (
              <div key={prueba.prueba_id} className="card overflow-hidden">
                {/* CABECERA */}
                <div className="p-4 bg-[#112d24] text-white">
                  <div className="flex items-start justify-between gap-4">
                    <div>
                      <div className="flex items-center gap-3 mb-1">
                        <h2 className="text-xl font-bold">{prueba.prueba_nombre}</h2>
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
                        {prueba.categoria && ' | ' + prueba.categoria}
                        {prueba.reprise_nombre && ' | ' + prueba.reprise_nombre}
                      </p>
                    </div>
                    <div className="text-right">
                      <p className="text-xs opacity-75">Binomios</p>
                      <p className="text-2xl font-bold">{prueba.clasificaciones.length}</p>
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
                          className={`px-3 py-2 rounded border ${
                            j.numPuntuaciones > 0
                              ? 'bg-green-50 border-green-300'
                              : 'bg-gray-100 border-gray-300'
                          }`}
                        >
                          <span className="font-bold text-lg mr-2">{j.letra}</span>
                          <span className="text-sm">{j.nombre}</span>
                          <span
                            className={`ml-2 text-xs ${
                              j.numPuntuaciones > 0 ? 'text-green-700' : 'text-gray-500'
                            }`}
                          >
                            {j.numPuntuaciones > 0 ? `✓ ${j.numPuntuaciones} notas` : 'Sin puntuar'}
                          </span>
                        </div>
                      ))}
                    </div>
                  </div>
                )}

                {/* PESTAÑAS */}
                {tieneEquipos && (
                  <div className="border-b bg-gray-50 flex">
                    <button
                      onClick={() =>
                        setPestanaActiva({ ...pestanaActiva, [prueba.prueba_id]: 'individual' })
                      }
                      className={`px-6 py-3 text-sm font-bold ${
                        pestana === 'individual'
                          ? 'text-[#112d24] border-b-2 border-[#112d24] bg-white'
                          : 'text-gray-600 hover:text-gray-900'
                      }`}
                    >
                      Individual
                    </button>
                    <button
                      onClick={() =>
                        setPestanaActiva({ ...pestanaActiva, [prueba.prueba_id]: 'equipos' })
                      }
                      className={`px-6 py-3 text-sm font-bold ${
                        pestana === 'equipos'
                          ? 'text-[#112d24] border-b-2 border-[#112d24] bg-white'
                          : 'text-gray-600 hover:text-gray-900'
                      }`}
                    >
                      Equipos ({prueba.equipos.length})
                    </button>
                  </div>
                )}

                {/* PESTANA INDIVIDUAL */}
                {pestana === 'individual' && (
                  <>
                    {top3Individual.length > 0 && (
                      <div className="p-6 bg-gradient-to-b from-gray-50 to-white border-b">
                        <p className="text-center text-sm text-gray-600 mb-4 font-semibold uppercase tracking-wide">
                          Podio Individual
                        </p>
                        <div className="flex items-end justify-center gap-4">
                          {top3Individual[1] && (
                            <div className="text-center flex-1 max-w-xs">
                              <div className="text-4xl mb-2">🥈</div>
                              <div className="bg-gray-200 rounded-t-lg p-4 pt-8 pb-4">
                                <p className="font-bold truncate">{top3Individual[1].jinete}</p>
                                <p className="text-xs text-gray-600 truncate">{top3Individual[1].caballo}</p>

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
                                <p className="font-bold truncate">{top3Individual[0].jinete}</p>
                                <p className="text-xs text-gray-700 truncate">{top3Individual[0].caballo}</p>

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
                                <p className="font-bold text-sm truncate">{top3Individual[2].jinete}</p>
                                <p className="text-xs text-gray-700 truncate">{top3Individual[2].caballo}</p>

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
                        No hay binomios puntuados en esta prueba todavia.
                      </div>
                    ) : (
                      <div className="table-responsive">
                        <table className="table">
                          <thead>
                            <tr>
                              <th className="text-center w-16">Pos.</th>
                              <th className="text-center w-16">Dorsal</th>
                              <th>Jinete</th>
                              <th>Caballo</th>
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
                            {ordenarClasificaciones(prueba.clasificaciones).map((c) => {
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
                                      {medallaEmoji(c.posicion)} {c.posicion}º
                                    </td>
                                    <td className="text-center font-bold">{c.dorsal}</td>
                                    <td>{c.jinete}</td>
                                    <td>{c.caballo}</td>

                                    {letrasJueces.map((l) => (
                                      <td key={l} className="text-center text-sm">
                                        {puntuacionPorLetra[l] !== null
                                          ? puntuacionPorLetra[l]!.toFixed(2) + '%'
                                          : '-'}
                                      </td>
                                    ))}
                                    <td className="text-right font-bold text-lg">
                                      {c.media.toFixed(2)}%
                                    </td>
                                    <td className="text-center">
                                      <button
                                        onClick={() =>
                                          setExpandidos((prev) => abierto ? prev.filter((x) => x !== c.participacion_id) : [...prev, c.participacion_id])
                                        }
                                        className="text-primary hover:underline text-sm font-medium"
                                      >
                                        {abierto ? 'Ocultar' : 'Ver detalle'}
                                      </button>
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
                  </>
                )}

                {/* PESTANA EQUIPOS */}
                {pestana === 'equipos' && tieneEquipos && (
                  <>
                    {top3Equipos.length > 0 && (
                      <div className="p-6 bg-gradient-to-b from-teal-50 to-white border-b">
                        <p className="text-center text-sm text-gray-600 mb-4 font-semibold uppercase tracking-wide">
                          Podio por Equipos
                        </p>
                        <div className="flex items-end justify-center gap-4">
                          {top3Equipos[1] && (
                            <div className="text-center flex-1 max-w-xs">
                              <div className="text-4xl mb-2">🥈</div>
                              <div className="bg-gray-200 rounded-t-lg p-4 pt-8 pb-4">
                                <p className="font-bold truncate">{top3Equipos[1].equipo_nombre}</p>
                                <p className="text-xl font-bold mt-2">
                                  {top3Equipos[1].puntuacion_equipo.toFixed(2)}%
                                </p>
                              </div>
                              <div className="bg-gray-300 h-12 flex items-center justify-center font-bold text-2xl text-gray-700">
                                2
                              </div>
                            </div>
                          )}
                          {top3Equipos[0] && (
                            <div className="text-center flex-1 max-w-xs">
                              <div className="text-5xl mb-2">🥇</div>
                              <div className="bg-yellow-200 rounded-t-lg p-4 pt-8 pb-4">
                                <p className="font-bold truncate">{top3Equipos[0].equipo_nombre}</p>
                                <p className="text-2xl font-bold mt-2">
                                  {top3Equipos[0].puntuacion_equipo.toFixed(2)}%
                                </p>
                              </div>
                              <div className="bg-yellow-400 h-16 flex items-center justify-center font-bold text-3xl text-yellow-900">
                                1
                              </div>
                            </div>
                          )}
                          {top3Equipos[2] && (
                            <div className="text-center flex-1 max-w-xs">
                              <div className="text-4xl mb-2">🥉</div>
                              <div className="bg-orange-200 rounded-t-lg p-4 pt-8 pb-4">
                                <p className="font-bold text-sm truncate">{top3Equipos[2].equipo_nombre}</p>
                                <p className="text-lg font-bold mt-2">
                                  {top3Equipos[2].puntuacion_equipo.toFixed(2)}%
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

                    <div className="table-responsive">
                      <table className="table">
                        <thead>
                          <tr>
                            <th className="text-center w-16">Pos.</th>
                            <th>Equipo</th>
                            <th className="text-center w-20">#</th>
                            <th>Jinete</th>
                            <th>Caballo</th>
                            <th className="text-right w-28">%</th>
                          </tr>
                        </thead>
                        <tbody>
                          {prueba.equipos.map((eq) => (
                            <Fragment key={eq.equipo_id}>
                              {eq.miembros.map((m, idx) => (
                                <tr
                                  key={eq.equipo_id + '-' + m.posicion_miembro}
                                  className={idx === 0 ? colorPuesto(eq.posicion_equipo) : ''}
                                >
                                  {idx === 0 && (
                                    <td
                                      className="text-center font-bold align-top"
                                      rowSpan={eq.miembros.length}
                                    >
                                      {medallaEmoji(eq.posicion_equipo)} {eq.posicion_equipo}º
                                    </td>
                                  )}
                                  {idx === 0 && (
                                    <td
                                      className="font-bold align-top"
                                      rowSpan={eq.miembros.length}
                                    >
                                      {eq.equipo_nombre}
                                      <div className="text-lg font-bold text-teal-700 mt-1">
                                        {eq.puntuacion_equipo.toFixed(2)}%
                                      </div>
                                    </td>
                                  )}
                                  <td className="text-center text-gray-500">{m.posicion_miembro}</td>
                                  <td>{m.nombre_jinete}</td>
                                  <td>{m.nombre_caballo}</td>
                                  <td className="text-right font-bold">
                                    {m.porcentaje.toFixed(2)}%
                                  </td>
                                </tr>
                              ))}
                            </Fragment>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  </>
                )}
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