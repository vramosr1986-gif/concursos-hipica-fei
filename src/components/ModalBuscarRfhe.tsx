'use client';

import { useState } from 'react';

interface RFHEResult {
  ldn: string;
  ano: string;
  nombre: string;
  categoria: string;
  identificacion: string;
  nacimiento: string;
}

interface ModalBuscarRfheProps {
  isOpen: boolean;
  onClose: () => void;
  tipo: 'jinete' | 'caballo';
  onSelect?: (result: RFHEResult) => void;
}

export default function ModalBuscarRfhe({
  isOpen,
  onClose,
  tipo,
  onSelect,
}: ModalBuscarRfheProps) {
  const [busqueda, setBusqueda] = useState('');
  const [resultados, setResultados] = useState<RFHEResult[]>([]);
  const [cargando, setCargando] = useState(false);
  const [error, setError] = useState('');

  const handleBuscar = async () => {
    if (!busqueda.trim()) {
      setError('Ingresa un nombre o apellido');
      return;
    }

    setCargando(true);
    setError('');
    setResultados([]);

    try {
      const response = await fetch('/api/rfhe/search', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          apellidos: busqueda,
          tipo: tipo === 'jinete' ? 'jinete' : 'caballo',
        }),
      });

      const data = await response.json();

      if (!response.ok) {
        setError(data.error || 'Error en búsqueda RFHE');
        return;
      }

      setResultados(data.resultados || []);
      if (data.resultados?.length === 0) {
        setError('No se encontraron resultados');
      }
    } catch (err: any) {
      setError(err.message || 'Error al consultar RFHE');
    } finally {
      setCargando(false);
    }
  };

  const handleSelect = (result: RFHEResult) => {
    if (onSelect) onSelect(result);
    onClose();
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div className="bg-white rounded-lg p-6 w-full max-w-2xl max-h-[80vh] overflow-y-auto">
        <div className="flex justify-between items-center mb-4">
          <h2 className="text-xl font-bold">
            Buscar {tipo === 'jinete' ? 'Jinete (LDN)' : 'Caballo (LAC)'}
          </h2>
          <button onClick={onClose} className="text-2xl font-bold hover:text-red-500">
            ×
          </button>
        </div>

        {/* Input de búsqueda */}
        <div className="flex gap-2 mb-4">
          <input
            type="text"
            placeholder={`Ingresa ${tipo === 'jinete' ? 'apellidos' : 'nombre del caballo'}...`}
            value={busqueda}
            onChange={(e) => {
              setBusqueda(e.target.value);
              setError('');
            }}
            onKeyDown={(e) => e.key === 'Enter' && handleBuscar()}
            className="flex-1 input input-bordered"
            disabled={cargando}
          />
          <button
            onClick={handleBuscar}
            disabled={cargando}
            className="btn btn-primary"
          >
            {cargando ? '⏳ Buscando...' : '🔍 Buscar'}
          </button>
        </div>

        {/* Mensaje de error */}
        {error && (
          <div className="alert alert-error mb-4">
            <span>{error}</span>
          </div>
        )}

        {/* Tabla de resultados */}
        {resultados.length > 0 && (
          <div className="overflow-x-auto">
            <table className="table table-compact w-full text-xs">
              <thead>
                <tr className="bg-gray-200">
                  <th>{tipo === 'jinete' ? 'LDN' : 'LAC'}</th>
                  <th>Año</th>
                  <th>Nombre</th>
                  <th>Categoría</th>
                  <th>ID</th>
                  <th>Acción</th>
                </tr>
              </thead>
              <tbody>
                {resultados.map((result, idx) => (
                  <tr key={idx} className="hover:bg-gray-100">
                    <td className="font-bold">{result.ldn}</td>
                    <td>{result.ano}</td>
                    <td>{result.nombre}</td>
                    <td>{result.categoria}</td>
                    <td>{result.identificacion}</td>
                    <td>
                      <button
                        onClick={() => handleSelect(result)}
                        className="btn btn-sm btn-success"
                      >
                        ✓
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        {/* Estado vacío */}
        {!cargando && resultados.length === 0 && !error && (
          <div className="text-center py-8 text-gray-500">
            Ingresa un término de búsqueda y presiona "Buscar"
          </div>
        )}
      </div>
    </div>
  );
}
