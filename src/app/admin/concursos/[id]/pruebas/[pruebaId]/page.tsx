'use client';

import { useEffect, useState } from 'react';
import { useParams } from 'next/navigation';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';

const LETRAS = ['A', 'B', 'C', 'D', 'E'];

type Prueba = {
  id: string;
  concurso_id: string;
  nombre: string;
  categoria: string | null;
  categoria_edad_id: string | null;
  fecha: string;
  hora_inicio: string;
  pista: string | null;
  estado: string;
  reprise_id: string | null;
  reprise_nombre: string | null;
  reprise_codigo: string | null;
  es_caballos_jovenes: boolean | null;
};

type JuezAsignado = {
  id: string;
  juez_id: string;
  letra: string;
  nombre: string;
  email: string;
};

type BinomioParticipante = {
  id: string;
  inscripcion_id: string;
  orden_salida: number;
  dorsal: number;
  jinete: string;
  caballo: string;
  equipo_id: string | null;
  equipo_nombre: string | null;
};

type UserJuezOption = {
  id: string;
  nombre: string | null;
  email: string;
};

type InscripcionOption = {
  id: string;
  dorsal: number;
  categoria: string | null;
  categoria_edad_id: string | null;
  categoria_caballo: string | null;
  categoria_jinete: string | null;
  edad_jinete: number | null;
  edad_caballo: number | null;
  nombre_jinete: string;
  nombre_caballo: string;
  equipo_id: string | null;
  equipo_nombre: string | null;
};

export default function DetallePruebaPage() {
  const params = useParams();
  const concursoId = params.id as string;
  const pruebaId = params.pruebaId as string;

  const [prueba, setPrueba] = useState<Prueba | null>(null);
  const [jueces, setJueces] = useState<JuezAsignado[]>([]);
  const [binomios, setBinomios] = useState<BinomioParticipante[]>([]);
  const [usuariosJuez, setUsuariosJuez] = useState<UserJuezOption[]>([]);
  const [inscripcionesDisponibles, setInscripcionesDisponibles] = useState<InscripcionOption[]>([]);

  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  const [modalJuezAbierto, setModalJuezAbierto] = useState(false);
  const [nuevoJuez, setNuevoJuez] = useState({ juez_id: '', letra: 'A' });
  const [guardandoJuez, setGuardandoJuez] = useState(false);

  const [modalBinomioAbierto, setModalBinomioAbierto] = useState(false);
  const [nuevoBinomio, setNuevoBinomio] = useState({ inscripcion_id: '', orden_salida: '' });
  const [guardandoBinomio, setGuardandoBinomio] = useState(false);

  const cargarPrueba = async () => {
    const { data, error: dbError } = await supabase
      .from('pruebas')
      .select('id, concurso_id, nombre, categoria, categoria_edad_id, fecha, hora_inicio, pista, estado, reprise_id, es_caballos_jovenes, reprise:reprise_id(nombre, codigo)')
      .eq('id', pruebaId)
      .single();

    if (dbError) throw dbError;

    setPrueba({
      ...(data as any),
      reprise_nombre: (data as any).reprise?.nombre || null,
      reprise_codigo: (data as any).reprise?.codigo || null,
    });
  };

  const cargarJueces = async () => {
    const { data, error: dbError } = await supabase
      .from('prueba_jueces')
      .select('id, juez_id, letra, juez:juez_id(nombre, email)')
      .eq('prueba_id', pruebaId)
      .order('letra', { ascending: true });

    if (dbError) throw dbError;

    const formateados: JuezAsignado[] = (data || []).map((j: any) => ({
      id: j.id,
      juez_id: j.juez_id,
      letra: j.letra,
      nombre: j.juez?.nombre || 'Sin nombre',
      email: j.juez?.email || '',
    }));

    setJueces(formateados);
  };

  const cargarBinomios = async () => {
    const { data, error: dbError } = await supabase
      .from('participaciones')
      .select('id, inscripcion_id, orden_salida, equipo_id, inscripcion:inscripcion_id(dorsal, binomio:binomio_id(nombre_jinete, nombre_caballo)), equipo:equipo_id(nombre)')
      .eq('prueba_id', pruebaId)
      .order('orden_salida', { ascending: true });

    if (dbError) throw dbError;

    const formateados: BinomioParticipante[] = (data || []).map((b: any) => ({
      id: b.id,
      inscripcion_id: b.inscripcion_id,
      orden_salida: b.orden_salida,
      dorsal: b.inscripcion?.dorsal || 0,
      jinete: b.inscripcion?.binomio?.nombre_jinete || '-',
      caballo: b.inscripcion?.binomio?.nombre_caballo || '-',
      equipo_id: b.equipo_id || null,
      equipo_nombre: b.equipo?.nombre || null,
    }));

    setBinomios(formateados);
  };

  const cargarUsuariosJuez = async () => {
    const { data } = await supabase
      .from('profiles')
      .select('id, nombre, email')
      .eq('rol', 'juez')
      .order('nombre');

    if (data) setUsuariosJuez(data);
  };

  const cargarInscripcionesDisponibles = async (
    esCaballosJovenes: boolean,
    categoriaEdadId: string | null
  ) => {
    const { data: inscripciones } = await supabase
      .from('inscripciones')
      .select('id, dorsal, categoria, categoria_edad_id, binomio_id, binomio:binomio_id(nombre_jinete, nombre_caballo)')
      .eq('concurso_id', concursoId)
      .order('dorsal');

    if (!inscripciones) {
      setInscripcionesDisponibles([]);
      return;
    }

    const binomioIds = inscripciones.map((i: any) => i.binomio_id);
    let categoriasPorBinomio: Record<string, any> = {};

    if (binomioIds.length > 0) {
      const { data: cats } = await supabase
        .from('v_binomios_categorias')
        .select('binomio_id, categoria_jinete, categoria_caballo, edad_jinete, edad_caballo')
        .in('binomio_id', binomioIds);

      (cats || []).forEach((c: any) => {
        categoriasPorBinomio[c.binomio_id] = c;
      });
    }

    // Cargar los equipos de las inscripciones
    const inscripcionIds = inscripciones.map((i: any) => i.id);
    const equiposPorInscripcion: Record<string, { id: string; nombre: string }> = {};

    if (inscripcionIds.length > 0) {
      const { data: miembros } = await supabase
        .from('equipo_miembros')
        .select('inscripcion_id, equipo:equipo_id(id, nombre)')
        .in('inscripcion_id', inscripcionIds);

      (miembros || []).forEach((m: any) => {
        if (m.equipo) {
          equiposPorInscripcion[m.inscripcion_id] = {
            id: m.equipo.id,
            nombre: m.equipo.nombre,
          };
        }
      });
    }

    const filtradas: InscripcionOption[] = [];

    for (const i of inscripciones as any[]) {
      const cat = categoriasPorBinomio[i.binomio_id] || {};
      const equipo = equiposPorInscripcion[i.id] || null;

      if (esCaballosJovenes) {
        if (!cat.categoria_caballo) continue;
      } else {
        if (categoriaEdadId && i.categoria_edad_id !== categoriaEdadId) continue;
      }

      filtradas.push({
        id: i.id,
        dorsal: i.dorsal,
        categoria: i.categoria,
        categoria_edad_id: i.categoria_edad_id,
        categoria_caballo: cat.categoria_caballo || null,
        categoria_jinete: cat.categoria_jinete || null,
        edad_jinete: cat.edad_jinete ?? null,
        edad_caballo: cat.edad_caballo ?? null,
        nombre_jinete: i.binomio?.nombre_jinete || '-',
        nombre_caballo: i.binomio?.nombre_caballo || '-',
        equipo_id: equipo?.id || null,
        equipo_nombre: equipo?.nombre || null,
      });
    }

    setInscripcionesDisponibles(filtradas);
  };

  useEffect(() => {
    const cargar = async () => {
      try {
        await cargarPrueba();
        await Promise.all([
          cargarJueces(),
          cargarBinomios(),
          cargarUsuariosJuez(),
        ]);
      } catch (err: any) {
        setError(err.message || 'Error al cargar');
      } finally {
        setLoading(false);
      }
    };

    if (pruebaId) cargar();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [pruebaId]);

  useEffect(() => {
    if (prueba) {
      cargarInscripcionesDisponibles(
        !!prueba.es_caballos_jovenes,
        prueba.categoria_edad_id
      );
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [prueba?.id, prueba?.es_caballos_jovenes, prueba?.categoria_edad_id]);

  const handleAddJuez = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    if (!nuevoJuez.juez_id) {
      setError('Selecciona un juez');
      return;
    }

    setGuardandoJuez(true);
    try {
      const { error: dbError } = await supabase
        .from('prueba_jueces')
        .insert({
          prueba_id: pruebaId,
          juez_id: nuevoJuez.juez_id,
          letra: nuevoJuez.letra,
        });

      if (dbError) {
        if ((dbError as any).code === '23505') {
          throw new Error('Ya hay un juez con esa letra en esta prueba');
        }
        throw dbError;
      }

      await cargarJueces();
      setModalJuezAbierto(false);
      setNuevoJuez({ juez_id: '', letra: 'A' });
    } catch (err: any) {
      setError(err.message || 'Error al anadir juez');
    } finally {
      setGuardandoJuez(false);
    }
  };

  const handleDeleteJuez = async (id: string) => {
    if (!confirm('Eliminar este juez de la prueba?')) return;

    try {
      const { error: dbError } = await supabase
        .from('prueba_jueces')
        .delete()
        .eq('id', id);

      if (dbError) throw dbError;

      setJueces((actuales) => actuales.filter((j) => j.id !== id));
    } catch (err: any) {
      alert(err.message || 'Error al eliminar');
    }
  };

  const handleAddBinomio = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

    if (!nuevoBinomio.inscripcion_id) {
      setError('Selecciona un binomio');
      return;
    }

    setGuardandoBinomio(true);
    try {
      const nuevoOrden = nuevoBinomio.orden_salida.trim() !== ''
        ? parseInt(nuevoBinomio.orden_salida, 10)
        : binomios.length + 1;

      // Buscar si la inscripcion pertenece a algun equipo
      const { data: equipoMiembro } = await supabase
        .from('equipo_miembros')
        .select('equipo_id')
        .eq('inscripcion_id', nuevoBinomio.inscripcion_id)
        .maybeSingle();

      const equipoId = equipoMiembro?.equipo_id || null;

      const { error: dbError } = await supabase
        .from('participaciones')
        .insert({
          prueba_id: pruebaId,
          inscripcion_id: nuevoBinomio.inscripcion_id,
          orden_salida: nuevoOrden,
          estado: 'pendiente',
          equipo_id: equipoId,
        });

      if (dbError) {
        if ((dbError as any).code === '23505') {
          throw new Error('Ese binomio ya esta inscrito en esta prueba');
        }
        throw dbError;
      }

      await cargarBinomios();
      setModalBinomioAbierto(false);
      setNuevoBinomio({ inscripcion_id: '', orden_salida: '' });
    } catch (err: any) {
      setError(err.message || 'Error al anadir binomio');
    } finally {
      setGuardandoBinomio(false);
    }
  };

  const handleDeleteBinomio = async (id: string) => {
    if (!confirm('Eliminar este binomio de la prueba?')) return;

    try {
      const { error: dbError } = await supabase
        .from('participaciones')
        .delete()
        .eq('id', id);

      if (dbError) throw dbError;

      setBinomios((actuales) => actuales.filter((b) => b.id !== id));
    } catch (err: any) {
      alert(err.message || 'Error al eliminar');
    }
  };

  const formatearFecha = (fecha: string) => {
    if (!fecha) return '-';
    const [y, m, d] = fecha.split('-');
    return d + '/' + m + '/' + y;
  };

  const formatearEdad = (edad: number | null) => {
    if (edad === null || edad === undefined) return '-';
    return edad + ' anos';
  };

  if (loading) return <div className="container py-8">Cargando...</div>;
  if (!prueba) return <div className="container py-8">Prueba no encontrada</div>;

  // Comprobar si la prueba tiene equipos
  const tieneEquipos = binomios.some((b) => b.equipo_id);

  return (
    <div className="container max-w-5xl py-8">
      <Link
        href={'/admin/concursos/' + concursoId}
        className="text-primary mb-4 inline-block hover:underline"
      >
        Volver al concurso
      </Link>

      <div className="card p-6 mb-6">
        <h1 className="text-2xl font-bold mb-2">{prueba.nombre}</h1>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm mt-4">
          <div>
            <span className="text-gray-500">Fecha</span>
            <p className="font-bold">{formatearFecha(prueba.fecha)}</p>
          </div>
          <div>
            <span className="text-gray-500">Hora</span>
            <p className="font-bold">{prueba.hora_inicio.substring(0, 5)}</p>
          </div>
          <div>
            <span className="text-gray-500">Pista</span>
            <p className="font-bold">{prueba.pista || '-'}</p>
          </div>
          <div>
            <span className="text-gray-500">Categoria</span>
            <p className="font-bold">{prueba.categoria || '-'}</p>
          </div>
        </div>

        {prueba.reprise_nombre && (
          <div className="mt-4 pt-4 border-t">
            <span className="text-gray-500 text-sm">Reprise</span>
            <p className="font-bold">
              {prueba.reprise_nombre}
              {prueba.reprise_codigo && (
                <span className="text-xs font-mono text-gray-400 ml-2">
                  ({prueba.reprise_codigo})
                </span>
              )}
            </p>
          </div>
        )}

        {prueba.es_caballos_jovenes && (
          <div className="mt-3 p-2 bg-amber-50 border border-amber-300 rounded text-sm">
            <strong>Prueba de Caballos Jovenes</strong> · Se muestran solo los binomios con categoria de caballo joven (CJ4, CJ5, CJ6, CJ7, CJ8_10).
          </div>
        )}
      </div>

      {error && (
        <div className="mb-4 p-4 bg-red-100 border border-red-300 text-red-700 rounded">
          {error}
        </div>
      )}

      <div className="card p-6 mb-6">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-xl font-bold">Jueces asignados ({jueces.length})</h2>
          <button
            onClick={() => setModalJuezAbierto(!modalJuezAbierto)}
            className="btn btn-primary text-sm"
          >
            + Anadir Juez
          </button>
        </div>

        {modalJuezAbierto && (
          <div className="mb-4 p-4 border border-primary rounded bg-blue-50">
            <form onSubmit={handleAddJuez} className="space-y-3">
              <div>
                <label className="block text-xs font-bold mb-1">Juez</label>
                <select
                  value={nuevoJuez.juez_id}
                  onChange={(e) => setNuevoJuez({ ...nuevoJuez, juez_id: e.target.value })}
                  className="input w-full"
                  required
                >
                  <option value="">-- Elegir juez --</option>
                  {usuariosJuez.map((u) => (
                    <option key={u.id} value={u.id}>
                      {u.nombre || u.email}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-xs font-bold mb-1">Letra</label>
                <select
                  value={nuevoJuez.letra}
                  onChange={(e) => setNuevoJuez({ ...nuevoJuez, letra: e.target.value })}
                  className="input w-full"
                >
                  {LETRAS.map((l) => (
                    <option key={l} value={l}>{l}</option>
                  ))}
                </select>
              </div>

              <div className="flex justify-end gap-2">
                <button
                  type="button"
                  onClick={() => setModalJuezAbierto(false)}
                  className="btn btn-outline text-sm"
                >
                  Cancelar
                </button>
                <button
                  type="submit"
                  className="btn btn-primary text-sm"
                  disabled={guardandoJuez}
                >
                  {guardandoJuez ? 'Guardando...' : 'Anadir'}
                </button>
              </div>
            </form>
          </div>
        )}

        {jueces.length === 0 ? (
          <p className="text-gray-600">No hay jueces asignados todavia</p>
        ) : (
          <table className="table">
            <thead>
              <tr>
                <th>Letra</th>
                <th>Nombre</th>
                <th>Email</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {jueces.map((j) => (
                <tr key={j.id}>
                  <td className="font-bold text-lg">{j.letra}</td>
                  <td>{j.nombre}</td>
                  <td className="text-sm text-gray-600">{j.email}</td>
                  <td>
                    <button
                      onClick={() => handleDeleteJuez(j.id)}
                      className="text-danger text-sm hover:underline"
                    >
                      Eliminar
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>

      <div className="card p-6 mb-6">
        <div className="flex items-center justify-between mb-4">
          <div>
            <h2 className="text-xl font-bold">Binomios participantes ({binomios.length})</h2>
            {tieneEquipos && (
              <p className="text-sm text-teal-700 mt-1">
                Algunos binomios pertenecen a equipos. Se muestra el equipo en cada uno.
              </p>
            )}
          </div>
          <button
            onClick={() => setModalBinomioAbierto(!modalBinomioAbierto)}
            className="btn btn-primary text-sm"
          >
            + Anadir Binomio
          </button>
        </div>

        {!prueba.es_caballos_jovenes && prueba.categoria && (
          <p className="text-sm text-gray-600 mb-3">
            Mostrando inscripciones de la categoria: <strong>{prueba.categoria}</strong>
          </p>
        )}
        {prueba.es_caballos_jovenes && (
          <p className="text-sm text-amber-700 mb-3">
            Mostrando binomios con caballo joven (por edad del caballo)
          </p>
        )}

        {modalBinomioAbierto && (
          <div className="mb-4 p-4 border border-primary rounded bg-blue-50">
            {inscripcionesDisponibles.length === 0 ? (
              <p className="text-sm text-gray-600">
                No hay inscripciones disponibles para esta prueba.
                {prueba.es_caballos_jovenes
                  ? ' Anade binomios con caballos jovenes al concurso.'
                  : ' Anade inscripciones con esta categoria al concurso primero.'}
              </p>
            ) : (
              <form onSubmit={handleAddBinomio} className="space-y-3">
                <div>
                  <label className="block text-xs font-bold mb-1">
                    Binomio ({inscripcionesDisponibles.length} disponibles)
                  </label>
                  <select
                    value={nuevoBinomio.inscripcion_id}
                    onChange={(e) => setNuevoBinomio({ ...nuevoBinomio, inscripcion_id: e.target.value })}
                    className="input w-full"
                    required
                  >
                    <option value="">-- Elegir binomio --</option>
                    {inscripcionesDisponibles.map((i) => (
                      <option key={i.id} value={i.id}>
                        #{i.dorsal} · {i.nombre_jinete} / {i.nombre_caballo} · Jinete: {formatearEdad(i.edad_jinete)} ({i.categoria_jinete || '-'}) · Caballo: {formatearEdad(i.edad_caballo)} ({i.categoria_caballo || 'adulto'}){i.equipo_nombre ? ' · Equipo: ' + i.equipo_nombre : ''}
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className="block text-xs font-bold mb-1">Orden de salida (auto si vacio)</label>
                  <input
                    type="number"
                    value={nuevoBinomio.orden_salida}
                    onChange={(e) => setNuevoBinomio({ ...nuevoBinomio, orden_salida: e.target.value })}
                    placeholder="Auto"
                    className="input w-full"
                  />
                </div>

                <div className="flex justify-end gap-2">
                  <button
                    type="button"
                    onClick={() => setModalBinomioAbierto(false)}
                    className="btn btn-outline text-sm"
                  >
                    Cancelar
                  </button>
                  <button
                    type="submit"
                    className="btn btn-primary text-sm"
                    disabled={guardandoBinomio}
                  >
                    {guardandoBinomio ? 'Guardando...' : 'Anadir'}
                  </button>
                </div>
              </form>
            )}
          </div>
        )}

        {binomios.length === 0 ? (
          <p className="text-gray-600">No hay binomios participantes todavia</p>
        ) : (
          <table className="table">
            <thead>
              <tr>
                <th>Orden</th>
                <th>Dorsal</th>
                <th>Jinete</th>
                <th>Caballo</th>
                {tieneEquipos && <th>Equipo</th>}
                <th></th>
              </tr>
            </thead>
            <tbody>
              {binomios.map((b) => (
                <tr key={b.id}>
                  <td className="font-bold">{b.orden_salida}</td>
                  <td>{b.dorsal}</td>
                  <td>{b.jinete}</td>
                  <td>{b.caballo}</td>
                  {tieneEquipos && (
                    <td>
                      {b.equipo_nombre ? (
                        <span className="px-2 py-1 rounded text-xs bg-teal-100 text-teal-800 font-medium">
                          {b.equipo_nombre}
                        </span>
                      ) : (
                        <span className="text-gray-400 text-xs">-</span>
                      )}
                    </td>
                  )}
                  <td>
                    <button
                      onClick={() => handleDeleteBinomio(b.id)}
                      className="text-danger text-sm hover:underline"
                    >
                      Eliminar
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </div>
    </div>
  );
}