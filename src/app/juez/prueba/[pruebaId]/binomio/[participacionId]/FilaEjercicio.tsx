'use client';

import { useState, useEffect, useRef } from 'react';

type Ejercicio = {
  id: string;
  numero_orden: number;
  letra: string | null;
  descripcion: string;
  coeficiente: number;
  puntuacion_max: number;
  tipo: string;
};

type Props = {
  ejercicio: Ejercicio;
  notaActual: number | null;
  comentarioActual: string | null;
  onGuardar: (ejercicioId: string, nota: number, comentario: string) => Promise<void>;
};

type EstadoGuardado = 'sin_puntuar' | 'guardando' | 'guardado' | 'error';

export default function FilaEjercicio({
  ejercicio,
  notaActual,
  comentarioActual,
  onGuardar,
}: Props) {
  const [nota, setNota] = useState<string>(notaActual !== null ? String(notaActual) : '');
  const [comentario, setComentario] = useState<string>(comentarioActual || '');
  const [estado, setEstado] = useState<EstadoGuardado>(
    notaActual !== null ? 'guardado' : 'sin_puntuar'
  );
  const [errorMsg, setErrorMsg] = useState('');

  const debounceRef = useRef<NodeJS.Timeout | null>(null);
  const ultimoGuardadoRef = useRef<string>(`${notaActual ?? ''}|${comentarioActual ?? ''}`);

  // Sincronizar si cambia el valor externo (por ejemplo, otra pestana)
  useEffect(() => {
    setNota(notaActual !== null ? String(notaActual) : '');
    setComentario(comentarioActual || '');
    ultimoGuardadoRef.current = `${notaActual ?? ''}|${comentarioActual ?? ''}`;
  }, [notaActual, comentarioActual]);

  // Debounce: guardar 700ms despues del ultimo cambio
  useEffect(() => {
    const actual = `${nota}|${comentario}`;
    if (actual === ultimoGuardadoRef.current) return;

    if (debounceRef.current) clearTimeout(debounceRef.current);

    debounceRef.current = setTimeout(async () => {
      // Validar nota
      if (nota.trim() === '') {
        setEstado('sin_puntuar');
        return;
      }

      const notaNum = parseFloat(nota);
      if (isNaN(notaNum) || notaNum < 0 || notaNum > 10) {
        setEstado('error');
        setErrorMsg('Nota debe ser 0-10');
        return;
      }

      setEstado('guardando');
      setErrorMsg('');

      try {
        await onGuardar(ejercicio.id, notaNum, comentario);
        ultimoGuardadoRef.current = actual;
        setEstado('guardado');
      } catch (err: any) {
        setEstado('error');
        setErrorMsg(err.message || 'Error al guardar');
      }
    }, 700);

    return () => {
      if (debounceRef.current) clearTimeout(debounceRef.current);
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [nota, comentario]);

  const colorEstado = () => {
    if (estado === 'guardado') return 'border-l-4 border-green-500 bg-green-50';
    if (estado === 'guardando') return 'border-l-4 border-amber-500 bg-amber-50';
    if (estado === 'error') return 'border-l-4 border-red-500 bg-red-50';
    return 'border-l-4 border-gray-300 bg-white';
  };

  const iconoEstado = () => {
    if (estado === 'guardado') return 'OK';
    if (estado === 'guardando') return '...';
    if (estado === 'error') return '!';
    return '';
  };

  return (
    <div className={`p-3 rounded ${colorEstado()}`}>
      <div className="flex gap-3 items-start">
        <div className="flex-shrink-0 w-12 text-center">
          <p className="font-bold text-lg">{ejercicio.numero_orden}</p>
          <p className="text-xs text-gray-500 font-mono">{ejercicio.letra || '-'}</p>
        </div>

        <div className="flex-1">
          <p className="text-sm">{ejercicio.descripcion}</p>
          <div className="flex gap-2 mt-1 text-xs text-gray-500">
            <span>Coef: {ejercicio.coeficiente}</span>
            <span>Max: {ejercicio.puntuacion_max}</span>
            {ejercicio.tipo === 'nota_conjunto' && (
              <span className="text-purple-600 font-bold">NOTA CONJUNTO</span>
            )}
          </div>
        </div>

        <div className="flex-shrink-0 w-24">
          <input
            type="number"
            min="0"
            max="10"
            step="0.1"
            value={nota}
            onChange={(e) => setNota(e.target.value)}
            placeholder="0-10"
            className="input w-full text-center font-bold"
          />
        </div>

        <div className="flex-shrink-0 w-8 text-center pt-2">
          {iconoEstado()}
        </div>
      </div>

      <div className="mt-2 ml-15">
        <input
          type="text"
          value={comentario}
          onChange={(e) => setComentario(e.target.value)}
          placeholder="Comentario (opcional)"
          className="input w-full text-sm"
        />
      </div>

      {errorMsg && (
        <p className="text-xs text-red-600 mt-1">{errorMsg}</p>
      )}
    </div>
  );
}