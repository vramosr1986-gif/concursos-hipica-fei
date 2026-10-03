'use client';

import { FormEvent, useState } from 'react';
import { Download, LoaderCircle } from 'lucide-react';
import { supabase } from '@/lib/supabase';

export type ResultadoImportacion = {
  fuente: string;
  jinetes: number;
  binomios_nuevos: number;
  inscripciones_nuevas: number;
  pruebas_nuevas: number;
  participaciones_nuevas: number;
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

/** Bloque para la ficha del concurso: pegar el enlace RFHE y traer inscritos y pruebas. */
export function ImportarRfhe({ concursoId, onImportado }: { concursoId: string; onImportado?: () => void }) {
  const [url, setUrl] = useState('');
  const [cargando, setCargando] = useState(false);
  const [error, setError] = useState('');
  const [resultado, setResultado] = useState<ResultadoImportacion | null>(null);

  const enviar = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    setError('');
    setResultado(null);
    setCargando(true);
    try {
      setResultado(await importarDesdeRfhe(concursoId, url.trim()));
      onImportado?.();
    } catch (err) {
      setError(err instanceof Error ? err.message : 'No se pudo importar');
    } finally {
      setCargando(false);
    }
  };

  return (
    <div className="card p-6 max-w-4xl mb-8">
      <h2 className="text-xl font-bold">Traer inscritos y pruebas de la RFHE</h2>
      <p className="mt-1 text-sm text-gray-600">
        Si es un concurso de la Federación, pega aquí el enlace de su página en la RFHE (el botón «Ver en la web de RFHE» del calendario).
        Se crearán solas las pruebas y se inscribirán los binomios. Puedes repetirlo cuando la RFHE actualice la lista: no se duplica nada.
      </p>
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
          {cargando ? <LoaderCircle className="size-4 animate-spin" aria-hidden="true" /> : <Download className="size-4" aria-hidden="true" />}
          {cargando ? 'Trayendo datos…' : 'Traer inscritos y pruebas'}
        </button>
      </form>
      {error && <p role="alert" className="mt-3 rounded border border-red-200 bg-red-50 p-3 text-sm text-red-700">{error}</p>}
      {resultado && <div className="mt-3"><ResumenImportacion resultado={resultado} /></div>}
    </div>
  );
}
