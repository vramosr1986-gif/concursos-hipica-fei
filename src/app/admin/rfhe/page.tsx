'use client';

import { FormEvent, useState } from 'react';
import { ArrowDown, ArrowDownToLine, ArrowDownUp, ArrowUp, ExternalLink, FileSearch, LoaderCircle } from 'lucide-react';
import { supabase } from '@/lib/supabase';

type RepriseInscrito = {
  reprise: string;
  caballo: string;
  lac: string;
  federacionCaballo: string;
};

type InscritoRfhe = {
  numero: string;
  jinete: string;
  ldn: string;
  federacionJinete: string;
  reprises: RepriseInscrito[];
};

type ExtractedTable = {
  encabezados: string[];
  filas: string[][];
};

type HtmlData = {
  url: string;
  titulo: string;
  texto: string;
  tablas: ExtractedTable[];
  inscritos?: InscritoRfhe[];
};

type SectionResult = { tipo: 'html'; datos: HtmlData } | { error: string };

type ExtractionResult = {
  concurso: SectionResult;
  inscritos: SectionResult;
};

type InscritoSortKey = 'numero' | 'jinete' | 'ldn' | 'federacionJinete' | 'caballo';

type CalendarContest = {
  fecha: string;
  categoria: string;
  nombre: string;
  provincia: string;
  sede: string;
  urlDetalle: string;
};

type CalendarResult = {
  year: number;
  titulo: string;
  url: string;
  total: number;
  concursos: CalendarContest[];
};

const CAMPOS = [
  { id: 'concursoUrl', label: 'URL del concurso' },
  { id: 'inscritosUrl', label: 'URL de admitidos e inscritos' },
] as const;

async function leerJsonApi<T>(response: Response): Promise<T> {
  const body = await response.text();
  try {
    return JSON.parse(body) as T;
  } catch {
    const resumen = body.replace(/\s+/g, ' ').slice(0, 180);
    throw new Error(`La API respondió HTTP ${response.status} sin JSON: ${resumen || response.statusText}`);
  }
}

function TablasHtml({ datos }: { datos: HtmlData }) {
  return (
    <div className="space-y-4">
      <div>
        <h3 className="font-semibold text-[#173b2f]">{datos.titulo || 'Página RFHE'}</h3>
        <p className="mt-1 break-all text-xs text-gray-500">{datos.url}</p>
      </div>
      {datos.tablas.map((tabla, tablaIndex) => (
        <div key={tablaIndex} className="overflow-auto rounded border border-[#e4dfd4]">
          <table className="min-w-full text-left text-sm">
            <thead className="sticky top-0 bg-[#f4f0e6] text-xs uppercase text-[#466257]">
              <tr>
                {tabla.encabezados.map((encabezado, index) => (
                  <th key={`${index}-${encabezado}`} className="whitespace-nowrap px-3 py-2 font-semibold">
                    {encabezado || `Columna ${index + 1}`}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {tabla.filas.map((fila, rowIndex) => (
                <tr key={rowIndex} className="border-t border-[#eee9df] even:bg-[#fffdfa]">
                  {tabla.encabezados.map((_, colIndex) => (
                    <td key={colIndex} className="whitespace-nowrap px-3 py-2 text-gray-700">
                      {fila[colIndex] || '—'}
                    </td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
          <p className="border-t border-[#e4dfd4] bg-white px-3 py-2 text-xs text-gray-500">
            {tabla.filas.length} filas extraídas
          </p>
        </div>
      ))}
      {datos.tablas.length === 0 && (
        <pre className="max-h-72 overflow-auto whitespace-pre-wrap rounded bg-[#f8f7f3] p-3 text-xs leading-5 text-gray-700">
          {datos.texto || 'No se encontraron tablas ni texto.'}
        </pre>
      )}
    </div>
  );
}

function TablaInscritos({ datos }: { datos: HtmlData }) {
  const inscritos = datos.inscritos || [];
  const [orden, setOrden] = useState<{ campo: InscritoSortKey; direccion: 'asc' | 'desc' }>({
    campo: 'numero',
    direccion: 'asc',
  });
  if (inscritos.length === 0) return <TablasHtml datos={datos} />;

  const totalReprises = inscritos.reduce((total, inscrito) => total + inscrito.reprises.length, 0);
  const cambiarOrden = (campo: InscritoSortKey) => {
    setOrden((actual) => ({
      campo,
      direccion: actual.campo === campo && actual.direccion === 'asc' ? 'desc' : 'asc',
    }));
  };
  const inscritosOrdenados = [...inscritos].sort((a, b) => {
    let comparacion = 0;
    if (orden.campo === 'numero') {
      comparacion = Number(a.numero) - Number(b.numero);
    } else if (orden.campo === 'caballo') {
      const textoA = a.reprises.map((r) => `${r.caballo} ${r.lac} ${r.federacionCaballo} ${r.reprise}`).join(' | ');
      const textoB = b.reprises.map((r) => `${r.caballo} ${r.lac} ${r.federacionCaballo} ${r.reprise}`).join(' | ');
      comparacion = textoA.localeCompare(textoB, 'es', { numeric: true, sensitivity: 'base' });
    } else {
      comparacion = a[orden.campo].localeCompare(b[orden.campo], 'es', { numeric: true, sensitivity: 'base' });
    }
    return orden.direccion === 'asc' ? comparacion : -comparacion;
  });
  const cabeceraOrdenable = (campo: InscritoSortKey, titulo: string, className = 'whitespace-nowrap') => (
    <th aria-sort={orden.campo === campo ? (orden.direccion === 'asc' ? 'ascending' : 'descending') : 'none'} className={`${className} px-3 py-2`}>
      <button type="button" onClick={() => cambiarOrden(campo)} className="inline-flex items-center gap-1.5 text-left">
        {titulo}
        {orden.campo === campo
          ? orden.direccion === 'asc' ? <ArrowUp className="size-3.5" aria-hidden="true" /> : <ArrowDown className="size-3.5" aria-hidden="true" />
          : <ArrowDownUp className="size-3.5 opacity-50" aria-hidden="true" />}
      </button>
    </th>
  );

  return (
    <div className="space-y-3">
      <div>
        <h3 className="font-semibold text-[#173b2f]">{datos.titulo || 'Relación de admitidos'}</h3>
        <p className="mt-1 break-all text-xs text-gray-500">{datos.url}</p>
        <p className="mt-2 text-sm text-gray-600">
          {inscritos.length} inscritos · {totalReprises} participaciones en reprises
        </p>
      </div>
      <div className="overflow-auto rounded border border-[#e4dfd4]">
        <table className="min-w-full text-left text-sm">
          <thead className="bg-[#f4f0e6] text-xs uppercase text-[#466257]">
            <tr>
              {cabeceraOrdenable('numero', 'Nº')}
              {cabeceraOrdenable('jinete', 'Jinete/Amazona')}
              {cabeceraOrdenable('ldn', 'LDN')}
              {cabeceraOrdenable('federacionJinete', 'FH jinete')}
              {cabeceraOrdenable('caballo', 'Caballo · LAC · FH · Reprise', 'min-w-72')}
            </tr>
          </thead>
          <tbody>
            {inscritosOrdenados.map((inscrito) => (
              <tr key={`${inscrito.numero}-${inscrito.ldn}`} className="border-t border-[#eee9df] align-top even:bg-[#fffdfa]">
                <td className="px-3 py-2">{inscrito.numero}</td>
                <td className="whitespace-nowrap px-3 py-2">{inscrito.jinete}</td>
                <td className="px-3 py-2">{inscrito.ldn}</td>
                <td className="px-3 py-2">{inscrito.federacionJinete}</td>
                <td className="px-3 py-2">
                  <ul className="space-y-1">
                    {inscrito.reprises.map((reprise, index) => (
                      <li key={`${reprise.reprise}-${index}`}>
                        {reprise.caballo} · LAC {reprise.lac} · {reprise.federacionCaballo} · {reprise.reprise}
                      </li>
                    ))}
                  </ul>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

function ContenidoResultado({ titulo, resultado, inscritos = false }: {
  titulo: string;
  resultado: SectionResult;
  inscritos?: boolean;
}) {
  return (
    <section className="space-y-4 border-t border-[#e4dfd4] pt-5">
      <h2 className="text-lg font-semibold text-[#173b2f]">{titulo}</h2>
      {'error' in resultado ? (
        <p className="rounded border border-red-200 bg-red-50 p-3 text-sm text-red-700">{resultado.error}</p>
      ) : (
        inscritos ? <TablaInscritos datos={resultado.datos} /> : <TablasHtml datos={resultado.datos} />
      )}
    </section>
  );
}

export default function RfheExtractionPage() {
  const currentYear = new Date().getFullYear();
  const [year, setYear] = useState(String(currentYear));
  const [calendar, setCalendar] = useState<CalendarResult | null>(null);
  const [calendarError, setCalendarError] = useState('');
  const [loadingCalendar, setLoadingCalendar] = useState(false);
  const [urls, setUrls] = useState({ concursoUrl: '', inscritosUrl: '' });
  const [resultado, setResultado] = useState<ExtractionResult | null>(null);
  const [error, setError] = useState('');
  const [cargando, setCargando] = useState(false);

  const cargarCalendario = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    setCalendarError('');
    setCalendar(null);
    setLoadingCalendar(true);

    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session?.access_token) throw new Error('La sesión ha caducado. Inicia sesión de nuevo.');

      const response = await fetch(`/api/admin/rfhe-extract?year=${encodeURIComponent(year)}`, {
        headers: { Authorization: `Bearer ${session.access_token}` },
      });
      const data = await leerJsonApi<CalendarResult & { error?: string }>(response);
      if (!response.ok) throw new Error(data.error || 'No se pudo cargar el calendario RFHE.');
      setCalendar(data as CalendarResult);
    } catch (err) {
      setCalendarError(err instanceof Error ? err.message : 'Error al cargar el calendario.');
    } finally {
      setLoadingCalendar(false);
    }
  };

  const extraerDatos = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    setError('');
    setResultado(null);
    setCargando(true);

    try {
      const { data: { session } } = await supabase.auth.getSession();
      if (!session?.access_token) throw new Error('La sesión ha caducado. Inicia sesión de nuevo.');

      const response = await fetch('/api/admin/rfhe-extract', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${session.access_token}`,
        },
        body: JSON.stringify(urls),
      });
      const data = await leerJsonApi<ExtractionResult & { error?: string }>(response);
      if (!response.ok) throw new Error(data.error || 'No se pudieron extraer las páginas.');
      setResultado(data as ExtractionResult);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Error al consultar las URL.');
    } finally {
      setCargando(false);
    }
  };

  return (
    <div className="space-y-6">
      <header>
        <p className="text-xs font-bold uppercase tracking-[0.2em] text-[#b88746]">Prototipo de lectura</p>
        <h2 className="mt-1 text-2xl font-semibold text-[#173b2f]">Extraer datos de RFHE</h2>
      </header>

      <section className="space-y-4 rounded-lg border border-[#e4dfd4] bg-white p-5">
        <div>
          <h3 className="text-lg font-semibold text-[#173b2f]">Calendario anual</h3>
          <p className="mt-1 text-sm text-gray-600">Carga los concursos de cualquier año disponible en RFHE.</p>
        </div>
        <form onSubmit={cargarCalendario} className="flex flex-wrap items-end gap-3">
          <div>
            <label htmlFor="rfhe-year" className="mb-1 block text-sm font-semibold text-[#33483f]">Año</label>
            <select id="rfhe-year" value={year} onChange={(event) => setYear(event.target.value)} className="input">
              {Array.from({ length: 16 }, (_, index) => currentYear - 5 + index).map((optionYear) => (
                <option key={optionYear} value={optionYear}>{optionYear}</option>
              ))}
            </select>
          </div>
          <button type="submit" disabled={loadingCalendar} className="btn btn-primary">
            {loadingCalendar ? <LoaderCircle className="size-4 animate-spin" /> : <FileSearch className="size-4" />}
            {loadingCalendar ? 'Cargando…' : 'Cargar calendario'}
          </button>
        </form>
        {calendarError && <p role="alert" className="rounded border border-red-200 bg-red-50 p-3 text-sm text-red-700">{calendarError}</p>}
        {calendar && (
          <div className="space-y-3">
            <div className="flex flex-wrap items-baseline justify-between gap-2">
              <h4 className="font-semibold text-[#173b2f]">{calendar.titulo}</h4>
              <span className="text-sm text-gray-600">{calendar.total} concursos encontrados</span>
            </div>
            <div className="max-h-[36rem] overflow-auto rounded border border-[#e4dfd4]">
              <table className="min-w-full text-left text-sm">
                <thead className="sticky top-0 bg-[#f4f0e6] text-xs uppercase text-[#466257]">
                  <tr>
                    <th className="whitespace-nowrap px-3 py-2">Fecha</th>
                    <th className="whitespace-nowrap px-3 py-2">Tipo</th>
                    <th className="min-w-64 px-3 py-2">Concurso</th>
                    <th className="whitespace-nowrap px-3 py-2">Provincia</th>
                    <th className="min-w-48 px-3 py-2">Sede</th>
                    <th className="px-3 py-2">Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  {calendar.concursos.map((contest, index) => (
                    <tr key={`${contest.urlDetalle}-${contest.fecha}-${index}`} className="border-t border-[#eee9df] even:bg-[#fffdfa]">
                      <td className="whitespace-nowrap px-3 py-2">{contest.fecha}</td>
                      <td className="whitespace-nowrap px-3 py-2">{contest.categoria}</td>
                      <td className="px-3 py-2 font-medium text-[#173b2f]">{contest.nombre}</td>
                      <td className="whitespace-nowrap px-3 py-2">{contest.provincia}</td>
                      <td className="px-3 py-2">{contest.sede}</td>
                      <td className="whitespace-nowrap px-3 py-2">
                        <div className="flex items-center gap-2">
                          <button
                            type="button"
                            onClick={() => setUrls((previous) => ({ ...previous, concursoUrl: contest.urlDetalle }))}
                            className="btn btn-sm btn-outline"
                            title="Usar esta URL en extracción de concurso"
                          >
                            <ArrowDownToLine className="size-4" aria-hidden="true" />
                          </button>
                          <a href={contest.urlDetalle} target="_blank" rel="noopener noreferrer" className="btn btn-sm btn-outline" title="Abrir detalle RFHE">
                            <ExternalLink className="size-4" aria-hidden="true" />
                          </a>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}
      </section>

      <form onSubmit={extraerDatos} className="space-y-4 rounded-lg border border-[#e4dfd4] bg-white p-5">
        {CAMPOS.map((campo) => (
          <div key={campo.id}>
            <label htmlFor={campo.id} className="mb-1.5 block text-sm font-semibold text-[#33483f]">
              {campo.label}
            </label>
            <input
              id={campo.id}
              type="url"
              required
              value={urls[campo.id]}
              placeholder="https://www.cbservicios.net/..."
              onChange={(event) => setUrls({ ...urls, [campo.id]: event.target.value })}
              className="input w-full"
            />
          </div>
        ))}

        <div className="flex flex-wrap items-center justify-between gap-3 border-t border-[#eee9df] pt-4">
          <p className="max-w-xl text-xs leading-5 text-gray-500">
            Solo consulta los dominios RFHE permitidos. La extracción se muestra para revisión; no guarda datos ni crea concursos o inscripciones.
          </p>
          <button type="submit" disabled={cargando} className="btn btn-primary shrink-0">
            {cargando ? <LoaderCircle className="size-4 animate-spin" /> : <FileSearch className="size-4" />}
            {cargando ? 'Extrayendo…' : 'Extraer datos'}
          </button>
        </div>
        {error && <p role="alert" className="rounded border border-red-200 bg-red-50 p-3 text-sm text-red-700">{error}</p>}
      </form>

      {resultado && (
        <div className="space-y-5 rounded-lg border border-[#e4dfd4] bg-white p-5">
          <ContenidoResultado titulo="Datos del concurso" resultado={resultado.concurso} />
          <ContenidoResultado titulo="Relación de admitidos" resultado={resultado.inscritos} inscritos />
        </div>
      )}
    </div>
  );
}
