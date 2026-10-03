'use client';

import { FormEvent, useEffect, useState } from 'react';
import { Download, LoaderCircle } from 'lucide-react';
import { supabase } from '@/lib/supabase';

export type ResultadoImportacion = {
  fuente: string;
  jinetes: number;
  binomios_nuevos: number;
  inscripciones_nuevas: number;
  pruebas_nuevas: number;
  participaciones_nuevas: number;
  observaciones_actualizadas: number;
  pendientes_confirmacion: number;
  pruebas_sin_reprise: string[];
};

/** Llama a la API que crea binomios, inscripciones, pruebas y participantes desde la RFHE. */
export async function importarDesdeRfhe(concursoId: string, url: string): Promise<ResultadoImportacion> {
  const { data: { session } } = await supabase.auth.getSession();
  if (!session?.access_token) throw new Error('La sesión ha caducado. Inicia sesión de nuevo.');

  const response = await fetch('/api/admin/rfhe-importar', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${session.access_token}` },
    body: JSON.stringify({ concurso_id: concursoId, url }),
  });
  const data = await response.json().catch(() => ({ error: `Error ${response.status} al importar` }));
  if (!response.ok) throw new Error(data.error || 'No se pudo importar desde la RFHE');
  return data as ResultadoImportacion;
}

export function ResumenImportacion({ resultado }: { resultado: ResultadoImportacion }) {
  return (
    <div role="status" className="rounded border border-green-200 bg-green-50 p-3 text-sm text-green-900">
      <p className="font-semibold">Datos traídos de la RFHE ({resultado.jinetes} jinetes en la lista):</p>
      <ul className="mt-1 list-disc pl-5">
        <li>{resultado.pruebas_nuevas} pruebas nuevas</li>
        <li>{resultado.inscripciones_nuevas} binomios inscritos ({resultado.binomios_nuevos} no estaban en el catálogo y se han dado de alta)</li>
        <li>{resultado.participaciones_nuevas} participaciones en pruebas</li>
        {resultado.observaciones_actualizadas > 0 && <li>{resultado.observaciones_actualizadas} participaciones han cambiado de estado en la RFHE (p. ej. ya confirmadas)</li>}
        {resultado.pendientes_confirmacion > 0 && <li>{resultado.pendientes_confirmacion} participaciones pendientes de confirmación en la RFHE (salen con *)</li>}
      </ul>
      {resultado.pruebas_sin_reprise.length > 0 && (
        <p className="mt-2 text-amber-800">
          Estas pruebas no tienen reprise en el catálogo y hay que elegírsela a mano: {resultado.pruebas_sin_reprise.join(', ')}.
        </p>
      )}
      <p className="mt-2 break-all text-xs text-green-800">Fuente: {resultado.fuente}</p>
    </div>
  );
}

type ConcursoCalendario = { nombre: string; fecha_inicio: string; urlDetalle: string };

const palabras = (texto: string) => new Set(
  texto.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase().split(/[^a-z0-9]+/).filter((p) => p.length > 2)
);

/** Busca en el calendario RFHE del año el concurso con la misma fecha de inicio y el nombre más parecido. */
async function buscarEnCalendario(nombre: string, fechaInicio: string): Promise<ConcursoCalendario | null> {
  const { data: { session } } = await supabase.auth.getSession();
  if (!session?.access_token) return null;
  const res = await fetch(`/api/admin/rfhe-extract?year=${fechaInicio.slice(0, 4)}`, {
    headers: { Authorization: `Bearer ${session.access_token}` },
  });
  if (!res.ok) return null;
  const data = await res.json() as { concursos?: ConcursoCalendario[] };
  const mismoDia = (data.concursos || []).filter((c) => c.fecha_inicio === fechaInicio);
  const buscadas = palabras(nombre);
  const puntuar = (c: ConcursoCalendario) => Array.from(palabras(c.nombre)).filter((p) => buscadas.has(p)).length;
  const mejor = mismoDia.sort((a, b) => puntuar(b) - puntuar(a))[0];
  return mejor && (mismoDia.length === 1 || puntuar(mejor) > 0) ? mejor : null;
}

/**
 * Bloque para la ficha del concurso. Si el concurso ya tiene guardado su enlace
 * RFHE, basta un clic para actualizar participantes; si no, se pega el enlace.
 */
export function ImportarRfhe({ concursoId, nombre, fechaInicio, urlGuardada, onImportado }: {
  concursoId: string;
  nombre: string;
  fechaInicio: string;
  urlGuardada?: string | null;
  onImportado?: () => void;
}) {
  const [url, setUrl] = useState(urlGuardada || '');
  const [cambiarEnlace, setCambiarEnlace] = useState(!urlGuardada);
  const [cargando, setCargando] = useState(false);
  const [error, setError] = useState('');
  const [resultado, setResultado] = useState<ResultadoImportacion | null>(null);
  const [buscando, setBuscando] = useState(false);
  const [encontrado, setEncontrado] = useState<string | null>(null);

  // Sin enlace guardado: se intenta encontrar el concurso en el calendario RFHE y se deja relleno.
  useEffect(() => {
    if (urlGuardada || !nombre || !fechaInicio) return;
    let cancelado = false;
    setBuscando(true);
    buscarEnCalendario(nombre, fechaInicio)
      .then((c) => {
        if (cancelado || !c) return;
        setUrl((actual) => actual || c.urlDetalle);
        setEncontrado(c.nombre);
      })
      .catch(() => undefined)
      .finally(() => { if (!cancelado) setBuscando(false); });
    return () => { cancelado = true; };
  }, [urlGuardada, nombre, fechaInicio]);

  const importar = async (enlace: string) => {
    setError('');
    setResultado(null);
    setCargando(true);
    try {
      setResultado(await importarDesdeRfhe(concursoId, enlace.trim()));
      setCambiarEnlace(false);
      onImportado?.();
    } catch (err) {
      setError(err instanceof Error ? err.message : 'No se pudo importar');
    } finally {
      setCargando(false);
    }
  };

  const enviar = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    importar(url);
  };

  const icono = cargando
    ? <LoaderCircle className="size-4 animate-spin" aria-hidden="true" />
    : <Download className="size-4" aria-hidden="true" />;

  return (
    <div className="card p-6 max-w-4xl mb-8">
      <h2 className="text-xl font-bold">Participantes de la RFHE</h2>
      {!cambiarEnlace && url ? (
        <>
          <p className="mt-1 text-sm text-gray-600">
            Trae de nuevo la lista de la Federación: añade los binomios y pruebas nuevos, y actualiza quién está pendiente de confirmación.
            No borra ni duplica nada, y respeta los dorsales, horas y pistas que ya hayas puesto.
          </p>
          <div className="mt-4 flex flex-wrap items-center gap-3">
            <button type="button" disabled={cargando} onClick={() => importar(url)} className="btn btn-primary">
              {icono}
              {cargando ? 'Actualizando…' : 'Actualizar participantes desde la RFHE'}
            </button>
            <button type="button" disabled={cargando} onClick={() => setCambiarEnlace(true)} className="btn btn-outline text-sm">
              Cambiar el enlace
            </button>
          </div>
          <p className="mt-2 break-all text-xs text-gray-500">Fuente: <a href={url} target="_blank" rel="noopener noreferrer" className="underline">{url}</a></p>
        </>
      ) : (
        <>
          <p className="mt-1 text-sm text-gray-600">
            Si es un concurso de la Federación, pega aquí el enlace de su página en la RFHE (el botón «Ver en la web de RFHE» del calendario).
            Se crearán solas las pruebas y se inscribirán los binomios. Puedes repetirlo cuando la RFHE actualice la lista: no se duplica nada.
          </p>
          {buscando && <p className="mt-3 text-sm text-gray-600">Buscando este concurso en el calendario de la RFHE…</p>}
          {encontrado && (
            <p role="status" className="mt-3 rounded border border-green-200 bg-green-50 p-3 text-sm text-green-900">
              Lo hemos encontrado en el calendario de la RFHE: <strong>{encontrado}</strong>. El enlace ya está puesto abajo;
              comprueba que es este concurso y pulsa «Traer inscritos y pruebas». Quedará guardado para la próxima vez.
            </p>
          )}
          <form onSubmit={enviar} className="mt-4 flex flex-wrap items-end gap-3">
            <div className="min-w-0 flex-1">
              <label htmlFor="rfhe-url-concurso" className="mb-1 block text-xs font-bold">Enlace del concurso en la RFHE</label>
              <input
                id="rfhe-url-concurso"
                type="url"
                required
                value={url}
                onChange={(e) => setUrl(e.target.value)}
                placeholder="https://www.cbservicios.net/..."
                className="input w-full"
              />
            </div>
            <button type="submit" disabled={cargando} className="btn btn-primary">
              {icono}
              {cargando ? 'Trayendo datos…' : 'Traer inscritos y pruebas'}
            </button>
          </form>
        </>
      )}
      {error && <p role="alert" className="mt-3 rounded border border-red-200 bg-red-50 p-3 text-sm text-red-700">{error}</p>}
      {resultado && <div className="mt-3"><ResumenImportacion resultado={resultado} /></div>}
    </div>
  );
}
