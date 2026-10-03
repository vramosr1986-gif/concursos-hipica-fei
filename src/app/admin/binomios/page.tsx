'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase';
import ModalBuscarRfhe from '@/components/ModalBuscarRfhe';

type BinomioConCategoria = {
  binomio_id: string;
  nombre_jinete: string;
  nombre_caballo: string;
  fecha_nacimiento_jinete: string | null;
  anio_nacimiento_caballo: number | null;
  edad_jinete: number | null;
  edad_caballo: number | null;
  categoria_jinete: string | null;
  categoria_caballo: string | null;
  categoria_principal: string | null;
  licencia_federativa: string | null;
  estado_validacion: 'pendiente' | 'valido' | 'no_valido';
};

const COLOR_CATEGORIA: Record<string, string> = {
  ALEVIN: 'bg-pink-100 text-pink-800',
  INFANTIL: 'bg-orange-100 text-orange-800',
  JUVENIL: 'bg-green-100 text-green-800',
  JOVEN_JINETE: 'bg-teal-100 text-teal-800',
  ADULTO: 'bg-blue-100 text-blue-800',
  CJ4: 'bg-purple-100 text-purple-800',
  CJ5: 'bg-purple-100 text-purple-800',
  CJ6: 'bg-purple-100 text-purple-800',
  CJ7: 'bg-purple-100 text-purple-800',
  CJ8_10: 'bg-amber-100 text-amber-800',
  CABALLO_ADULTO: 'bg-slate-100 text-slate-700',
};

const NOMBRE_CATEGORIA: Record<string, string> = {
  ALEVIN: 'Alevin',
  INFANTIL: 'Infantil',
  JUVENIL: 'Juvenil',
  JOVEN_JINETE: 'Joven Jinete',
  ADULTO: 'Adulto',
  CJ4: 'CJ 4 anos',
  CJ5: 'CJ 5 anos',
  CJ6: 'CJ 6 anos',
  CJ7: 'CJ 7 anos',
  CJ8_10: 'CJ 8-10 anos',
  CABALLO_ADULTO: 'Caballo adulto',
};

export default function AdminBinomiosPage() {
  const router = useRouter();

  const [binomios, setBinomios] = useState<BinomioConCategoria[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [modalAbierto, setModalAbierto] = useState(false);
  const [tipoModal, setTipoModal] = useState<'jinete' | 'caballo'>('jinete');

  const cargarBinomios = async () => {
    setLoading(true);
    setError('');

    try {
      const { data, error: dbError } = await supabase
        .from('v_binomios_categorias')
        .select('binomio_id, nombre_jinete, nombre_caballo, fecha_nacimiento_jinete, anio_nacimiento_caballo, edad_jinete, edad_caballo, categoria_jinete, categoria_caballo, categoria_principal')
        .order('nombre_jinete', { ascending: true });

      if (dbError) throw dbError;

      // Enriquecer con licencia_federativa y estado_validacion desde la tabla original
      const ids = (data || []).map((b: any) => b.binomio_id);
      let enriquecimiento: Record<string, any> = {};

      if (ids.length > 0) {
        const { data: binomiosData } = await supabase
          .from('binomios')
          .select('id, licencia_federativa, estado_validacion')
          .in('id', ids);

        (binomiosData || []).forEach((b: any) => {
          enriquecimiento[b.id] = {
            licencia_federativa: b.licencia_federativa,
            estado_validacion: b.estado_validacion || 'pendiente',
          };
        });
      }

      const enriquecidos: BinomioConCategoria[] = (data || []).map((b: any) => ({
        ...b,
        licencia_federativa: enriquecimiento[b.binomio_id]?.licencia_federativa || null,
        estado_validacion: enriquecimiento[b.binomio_id]?.estado_validacion || 'pendiente',
      }));

      setBinomios(enriquecidos);
    } catch (err: any) {
      setError(err.message || 'Error al cargar los binomios');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    cargarBinomios();
  }, []);

  const changeEstadoValidacion = async (id: string, nuevoEstado: 'pendiente' | 'valido' | 'no_valido') => {
    try {
      const { error: dbError } = await supabase
        .from('binomios')
        .update({ estado_validacion: nuevoEstado })
        .eq('id', id);

      if (dbError) throw dbError;

      // Actualizar en el estado local
      setBinomios((actuales) =>
        actuales.map((b) =>
          b.binomio_id === id ? { ...b, estado_validacion: nuevoEstado } : b
        )
      );
    } catch (err: any) {
      alert(err.message || 'Error al cambiar el estado de validación');
    }
  };

  const abrirBuscadorRfhe = (tipo: 'jinete' | 'caballo') => {
    setTipoModal(tipo);
    setModalAbierto(true);
  };

  const chipCategoria = (cat: string | null) => {
    if (!cat) return <span className="text-gray-400 text-xs">-</span>;
    const color = COLOR_CATEGORIA[cat] || 'bg-gray-100 text-gray-800';
    const nombre = NOMBRE_CATEGORIA[cat] || cat;
    return (
      <span className={'px-2 py-0.5 rounded text-xs font-medium ' + color}>
        {nombre}
      </span>
    );
  };

  const chipEstadoValidacion = (estado: 'pendiente' | 'valido' | 'no_valido') => {
    const estilos = {
      pendiente: 'bg-yellow-100 text-yellow-800',
      valido: 'bg-green-100 text-green-800',
      no_valido: 'bg-red-100 text-red-800',
    };
    const iconos = {
      pendiente: '🔄',
      valido: '✓',
      no_valido: '✗',
    };
    const textos = {
      pendiente: 'Pendiente',
      valido: 'Válido',
      no_valido: 'No válido',
    };
    return (
      <span className={'px-2 py-0.5 rounded text-xs font-medium ' + estilos[estado]}>
        {iconos[estado]} {textos[estado]}
      </span>
    );
  };

  return (
    <div className="container max-w-7xl py-8">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-3xl font-bold">Binomios</h1>
          <p className="text-gray-600 mt-1">
            Catalogo de jinetes y caballos con su categoria oficial calculada
          </p>
        </div>

        <button
          onClick={() => router.push('/admin/binomios/nuevo')}
          className="btn btn-primary"
        >
          + Nuevo Binomio
        </button>
      </div>

      {error && (
        <div className="mb-4 p-4 bg-red-100 border border-red-300 text-red-700 rounded">
          {error}
        </div>
      )}

      {loading ? (
        <div className="card p-6 text-center">Cargando binomios...</div>
      ) : binomios.length === 0 ? (
        <div className="card p-8 text-center">
          <h2 className="text-xl font-semibold mb-2">No hay binomios registrados</h2>
          <p className="text-gray-600 mb-4">Anade el primer binomio al catalogo.</p>
          <button
            onClick={() => router.push('/admin/binomios/nuevo')}
            className="btn btn-primary"
          >
            + Registrar primer binomio
          </button>
        </div>
      ) : (
        <div className="card overflow-hidden">
          <div className="p-4 border-b bg-gray-50">
            <strong>{binomios.length}</strong>{' '}
            {binomios.length === 1 ? 'binomio registrado' : 'binomios registrados'}
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="border-b bg-gray-50">
                  <th className="text-left p-2 font-medium">Jinete</th>
                  <th className="text-left p-2 font-medium">Caballo</th>
                  <th className="text-center p-2 font-medium hidden sm:table-cell">Edad</th>
                  <th className="text-center p-2 font-medium hidden md:table-cell">Cat. jinete</th>
                  <th className="text-center p-2 font-medium hidden md:table-cell">E.Cab</th>
                  <th className="text-center p-2 font-medium hidden lg:table-cell">Cat. cab</th>
                  <th className="text-center p-2 font-medium hidden lg:table-cell">Cat.Ppal</th>
                  <th className="text-center p-2 font-medium">RFHE</th>
                  <th className="text-center p-2 font-medium">Acciones</th>
                </tr>
              </thead>

              <tbody>
                {binomios.map((b) => (
                  <tr key={b.binomio_id} className="border-b hover:bg-gray-50">
                    <td className="p-2 font-medium text-xs sm:text-sm">{b.nombre_jinete}</td>
                    <td className="p-2 text-xs sm:text-sm">{b.nombre_caballo}</td>
                    <td className="p-2 text-center text-xs text-gray-600 hidden sm:table-cell">
                      {b.edad_jinete || '-'}
                    </td>
                    <td className="p-2 text-center hidden md:table-cell">{chipCategoria(b.categoria_jinete)}</td>
                    <td className="p-2 text-center text-xs text-gray-600 hidden md:table-cell">
                      {b.edad_caballo || '-'}
                    </td>
                    <td className="p-2 text-center hidden lg:table-cell">{chipCategoria(b.categoria_caballo)}</td>
                    <td className="p-2 text-center hidden lg:table-cell">
                      <span className="font-medium">{chipCategoria(b.categoria_principal)}</span>
                    </td>
                    <td className="p-2 text-center">
                      {chipEstadoValidacion(b.estado_validacion)}
                    </td>
                    <td className="p-2">
                      <div className="flex flex-col gap-1 items-center">
                        <div className="flex gap-0.5 justify-center flex-wrap">
                          <button
                            onClick={() => changeEstadoValidacion(b.binomio_id, 'valido')}
                            className={`btn btn-sm text-xs px-1.5 py-0.5 ${b.estado_validacion === 'valido' ? 'btn-success' : 'btn-outline'}`}
                            title="Válido"
                          >
                            ✓
                          </button>
                          <button
                            onClick={() => changeEstadoValidacion(b.binomio_id, 'no_valido')}
                            className={`btn btn-sm text-xs px-1.5 py-0.5 ${b.estado_validacion === 'no_valido' ? 'btn-danger' : 'btn-outline'}`}
                            title="No válido"
                          >
                            ✗
                          </button>
                          <button
                            onClick={() => changeEstadoValidacion(b.binomio_id, 'pendiente')}
                            className={`btn btn-sm text-xs px-1.5 py-0.5 ${b.estado_validacion === 'pendiente' ? 'btn-warning' : 'btn-outline'}`}
                            title="Pendiente"
                          >
                            🔄
                          </button>
                          <div className="dropdown dropdown-end">
                            <button
                              className="btn btn-sm btn-outline text-sm px-1.5 py-0.5"
                              title="Buscar en RFHE"
                            >
                              🔍
                            </button>
                            <ul className="dropdown-content menu bg-base-100 rounded-box z-[1] w-52 p-2 shadow">
                              <li>
                                <a onClick={() => abrirBuscadorRfhe('jinete')}>
                                  LDN - Buscar Jinete
                                </a>
                              </li>
                              <li>
                                <a onClick={() => abrirBuscadorRfhe('caballo')}>
                                  LAC - Buscar Caballo
                                </a>
                              </li>
                            </ul>
                          </div>
                        </div>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      <ModalBuscarRfhe
        isOpen={modalAbierto}
        onClose={() => setModalAbierto(false)}
        tipo={tipoModal}
      />
    </div>
  );
}