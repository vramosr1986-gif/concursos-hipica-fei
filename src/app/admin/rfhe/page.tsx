'use client';

import { FormEvent, useState } from 'react';
import Link from 'next/link';
import { ArrowDown, ArrowDownUp, ArrowUp, CalendarPlus, ExternalLink, FileSearch, LoaderCircle, Users } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import { crearUrlInscritos, esPendienteConfirmacion, nombreConMarca, sugerirJornada } from '@/lib/rfhe-pruebas';
import { compararPorInicio, formatearFecha } from '@/lib/fechas';

type RepriseInscrito = {
  reprise: string;
  caballo: string;
  lac: string;
  federacionCaballo: string;
  observaciones: string;
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
  fecha_inicio?: string;
  fecha_fin?: string;
  tablas: ExtractedTable[];
  inscritos?: InscritoRfhe[];
  inscritosConNumero?: boolean;
};

type SectionResult = { tipo: 'html'; datos: HtmlData } | { error: string };

type ExtractionResult = {
  concurso: SectionResult;
  inscritos: SectionResult;
};

type InscritoSortKey = 'numero' | 'jinete' | 'ldn' | 'federacionJinete' | 'caballo' | 'lac' | 'federacionCaballo' | 'reprise' | 'observaciones';

type FilaInscrito = InscritoRfhe & RepriseInscrito & { filaId: string };

type CalendarContest = {
  fecha_inicio: string;
  fecha_fin: string;
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

type CalendarSortKey = 'fecha_inicio' | 'fecha_fin' | 'categoria' | 'nombre' | 'provincia' | 'sede';

function normalizarTexto(texto: string): string {
  return texto.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLocaleLowerCase('es');
}

const CAMPOS = [
  { id: 'concursoUrl', label: 'Dirección (enlace) del concurso en RFHE' },
  { id: 'inscritosUrl', label: 'Dirección (enlace) de la lista de inscritos' },
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
        <p className="mt-1 break-all text-xs text-gray-500">Fuente: <a href={datos.url} target="_blank" rel="noopener noreferrer" className="underline hover:text-[#173b2f]">{datos.url}</a></p>
        {datos.fecha_inicio && (
          <dl className="mt-2 flex flex-wrap gap-x-6 gap-y-1 text-sm">
            <div className="flex gap-1.5"><dt className="font-semibold text-[#33483f]">Fecha inicio:</dt><dd>{formatearFecha(datos.fecha_inicio)}</dd></div>
            <div className="flex gap-1.5"><dt className="font-semibold text-[#33483f]">Fecha fin:</dt><dd>{formatearFecha(datos.fecha_fin)}</dd></div>
          </dl>
        )}
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
    campo: datos.inscritosConNumero ? 'numero' : 'jinete',
    direccion: 'asc',
  });
  const [jornadasPorReprise, setJornadasPorReprise] = useState<Record<string, string>>({});
  if (inscritos.length === 0) return <TablasHtml datos={datos} />;

  const filasCompletas: FilaInscrito[] = inscritos.flatMap((inscrito) => {
    const reprises = inscrito.reprises.length > 0
      ? inscrito.reprises
      : [{ reprise: '', caballo: '', lac: '', federacionCaballo: '', observaciones: '' }];
    return reprises.map((reprise, index) => ({
      ...inscrito,
      ...reprise,
      filaId: `${inscrito.numero || inscrito.ldn}-${inscrito.ldn}-${reprise.lac}-${index}`,
    }));
  });
  const totalReprises = inscritos.reduce((total, inscrito) => total + inscrito.reprises.length, 0);
  const reprisesUnicas = Array.from(new Set(filasCompletas
    .map((fila) => fila.reprise.trim())
    .filter(Boolean))).sort((a, b) => a.localeCompare(b, 'es', { numeric: true, sensitivity: 'base' }));
  const cambiarOrden = (campo: InscritoSortKey) => {
    setOrden((actual) => ({
      campo,
      direccion: actual.campo === campo && actual.direccion === 'asc' ? 'desc' : 'asc',
    }));
  };
  const filasOrdenadas = [...filasCompletas].sort((a, b) => {
    let comparacion = 0;
    if (orden.campo === 'numero' && /^\d+$/.test(a.numero) && /^\d+$/.test(b.numero)) {
      comparacion = Number(a.numero) - Number(b.numero);
    } else {
      comparacion = String(a[orden.campo] || '').localeCompare(String(b[orden.campo] || ''), 'es', { numeric: true, sensitivity: 'base' });
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
        <p className="mt-1 break-all text-xs text-gray-500">Fuente: <a href={datos.url} target="_blank" rel="noopener noreferrer" className="underline hover:text-[#173b2f]">{datos.url}</a></p>
        <p className="mt-2 text-sm text-gray-600">
          {inscritos.length} inscritos · {totalReprises} participaciones en reprises
        </p>
      </div>
      <div className="overflow-auto rounded border border-[#e4dfd4]">
        <table className="min-w-full text-left text-sm">
          <thead className="bg-[#f4f0e6] text-xs uppercase text-[#466257]">
            <tr>
              {datos.inscritosConNumero && cabeceraOrdenable('numero', 'Nº')}
              {cabeceraOrdenable('jinete', 'Jinete/Amazona')}
              {cabeceraOrdenable('ldn', 'LDN')}
              {cabeceraOrdenable('federacionJinete', 'FH jinete')}
              {cabeceraOrdenable('caballo', 'Caballo')}
              {cabeceraOrdenable('lac', 'LAC')}
              {cabeceraOrdenable('federacionCaballo', 'FH caballo')}
              {cabeceraOrdenable('reprise', 'Repris')}
              {cabeceraOrdenable('observaciones', 'Observaciones', 'min-w-48')}
            </tr>
          </thead>
          <tbody>
            {filasOrdenadas.map((fila) => (
              <tr key={fila.filaId} className="border-t border-[#eee9df] align-top even:bg-[#fffdfa]">
                {datos.inscritosConNumero && <td className="px-3 py-2">{fila.numero || '—'}</td>}
                <td className="whitespace-nowrap px-3 py-2">{nombreConMarca(fila.jinete, esPendienteConfirmacion(fila.observaciones))}</td>
                <td className="px-3 py-2">{fila.ldn}</td>
                <td className="px-3 py-2">{fila.federacionJinete}</td>
                <td className="whitespace-nowrap px-3 py-2">{fila.caballo}</td>
                <td className="px-3 py-2">{fila.lac}</td>
                <td className="px-3 py-2">{fila.federacionCaballo}</td>
                <td className="whitespace-nowrap px-3 py-2">{fila.reprise}</td>
                <td className="px-3 py-2">{fila.observaciones}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <section className="space-y-3 border-t border-[#e4dfd4] pt-4">
        <div>
          <h4 className="font-semibold text-[#173b2f]">Pruebas detectadas por reprise</h4>
          <p className="mt-1 text-xs leading-5 text-gray-500">
            “Equipos” es el nombre de la reprise; no se crea una competición por equipos. La jornada se sugiere solo para los tipos indicados y el resto queda manual.
          </p>
        </div>
        <div className="overflow-auto rounded border border-[#e4dfd4]">
          <table className="min-w-full text-left text-sm">
            <thead className="bg-[#f4f0e6] text-xs uppercase text-[#466257]">
              <tr>
                <th className="px-3 py-2">Reprise</th>
                <th className="px-3 py-2">Jornada sugerida</th>
              </tr>
            </thead>
            <tbody>
              {reprisesUnicas.map((reprise) => (
                <tr key={reprise} className="border-t border-[#eee9df] even:bg-[#fffdfa]">
                  <td className="px-3 py-2">{reprise}</td>
                  <td className="px-3 py-2">
                    <select
                      aria-label={`Jornada para ${reprise}`}
                      value={jornadasPorReprise[reprise] || sugerirJornada(reprise)}
                      onChange={(event) => setJornadasPorReprise((actual) => ({
                        ...actual,
                        [reprise]: event.target.value,
                      }))}
                      className="input min-w-52"
                    >
                      <option value="Sábado · jornada 1">Sábado · jornada 1</option>
                      <option value="Domingo · jornada 2">Domingo · jornada 2</option>
                      <option value="Asignación manual">Asignación manual</option>
                    </select>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>
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
  const [calendarSort, setCalendarSort] = useState<{ campo: CalendarSortKey; direccion: 'asc' | 'desc' }>({
    campo: 'fecha_inicio',
    direccion: 'asc',
  });
  const [calendarFilters, setCalendarFilters] = useState({
    fecha_inicio: '',
    fecha_fin: '',
    categoria: '',
    nombre: '',
    provincia: '',
    sede: '',
  });
  const [urls, setUrls] = useState({ concursoUrl: '', inscritosUrl: '' });
  const [resultado, setResultado] = useState<ExtractionResult | null>(null);
  const [error, setError] = useState('');
  const [cargando, setCargando] = useState(false);

  const cambiarUrlConcurso = (concursoUrl: string) => {
    const inscritosUrl = crearUrlInscritos(concursoUrl);
    setUrls((actuales) => ({
      ...actuales,
      concursoUrl,
      ...(inscritosUrl ? { inscritosUrl } : {}),
    }));
  };

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
      setCalendarFilters({ fecha_inicio: '', fecha_fin: '', categoria: '', nombre: '', provincia: '', sede: '' });
    } catch (err) {
      setCalendarError(err instanceof Error ? err.message : 'Error al cargar el calendario.');
    } finally {
      setLoadingCalendar(false);
    }
  };

  const extraerDatos = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    consultarConcurso(urls);
  };

  // Desde el calendario: rellena las dos URL y carga ya los datos e inscritos.
  const verInscritos = (concursoUrl: string) => {
    const nuevas = { concursoUrl, inscritosUrl: crearUrlInscritos(concursoUrl) || urls.inscritosUrl };
    setUrls(nuevas);
    consultarConcurso(nuevas);
    document.getElementById('datos-concurso')?.scrollIntoView({ behavior: 'smooth', block: 'start' });
  };

  const consultarConcurso = async (urls: { concursoUrl: string; inscritosUrl: string }) => {
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

  const cambiarOrdenCalendario = (campo: CalendarSortKey) => {
    setCalendarSort((actual) => ({
      campo,
      direccion: actual.campo === campo && actual.direccion === 'asc' ? 'desc' : 'asc',
    }));
  };

  const concursosFiltrados = (calendar?.concursos || [])
    .filter((concurso) =>
      formatearFecha(concurso.fecha_inicio).includes(calendarFilters.fecha_inicio.trim()) &&
      formatearFecha(concurso.fecha_fin).includes(calendarFilters.fecha_fin.trim()) &&
      (!calendarFilters.categoria || concurso.categoria === calendarFilters.categoria) &&
      normalizarTexto(concurso.nombre).includes(normalizarTexto(calendarFilters.nombre)) &&
      (!calendarFilters.provincia || concurso.provincia === calendarFilters.provincia) &&
      normalizarTexto(concurso.sede).includes(normalizarTexto(calendarFilters.sede))
    )
    .sort((a, b) => {
      const comparacion = calendarSort.campo === 'fecha_inicio'
        ? compararPorInicio(a, b)
        : calendarSort.campo === 'fecha_fin'
          ? a.fecha_fin.localeCompare(b.fecha_fin) || compararPorInicio(a, b)
          : a[calendarSort.campo].localeCompare(b[calendarSort.campo], 'es', { numeric: true, sensitivity: 'base' });
      return calendarSort.direccion === 'asc' ? comparacion : -comparacion;
    });

  const categoriasCalendario = Array.from(new Set((calendar?.concursos || []).map((concurso) => concurso.categoria)))
    .filter(Boolean)
    .sort((a, b) => a.localeCompare(b, 'es', { numeric: true, sensitivity: 'base' }));
  const provinciasCalendario = Array.from(new Set((calendar?.concursos || []).map((concurso) => concurso.provincia)))
    .filter(Boolean)
    .sort((a, b) => a.localeCompare(b, 'es', { numeric: true, sensitivity: 'base' }));

  const cabeceraCalendario = (campo: CalendarSortKey, titulo: string, className = 'whitespace-nowrap') => (
    <th aria-sort={calendarSort.campo === campo ? (calendarSort.direccion === 'asc' ? 'ascending' : 'descending') : 'none'} className={`${className} px-3 py-2`}>
      <button type="button" onClick={() => cambiarOrdenCalendario(campo)} className="inline-flex items-center gap-1.5 text-left">
        {titulo}
        {calendarSort.campo === campo
          ? calendarSort.direccion === 'asc' ? <ArrowUp className="size-3.5" aria-hidden="true" /> : <ArrowDown className="size-3.5" aria-hidden="true" />
          : <ArrowDownUp className="size-3.5 opacity-50" aria-hidden="true" />}
      </button>
    </th>
  );

  return (
    <div className="space-y-6">
      <header>
        <p className="text-xs font-bold uppercase tracking-[0.2em] text-[#b88746]">Federación Hípica Española</p>
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
            {loadingCalendar ? 'Buscando concursos…' : 'Ver concursos de ese año'}
          </button>
        </form>
        {calendarError && <p role="alert" className="rounded border border-red-200 bg-red-50 p-3 text-sm text-red-700">{calendarError}</p>}
        {calendar && (
          <div className="space-y-3">
            <div className="flex flex-wrap items-baseline justify-between gap-2">
              <div className="min-w-0">
                <h4 className="font-semibold text-[#173b2f]">{calendar.titulo}</h4>
                <p className="mt-1 break-all text-xs text-gray-500">
                  Fuente:{' '}
                  <a href={calendar.url} target="_blank" rel="noopener noreferrer" className="underline hover:text-[#173b2f]">{calendar.url}</a>
                </p>
              </div>
              <span className="text-sm text-gray-600">{concursosFiltrados.length} de {calendar.total} concursos</span>
            </div>
            <div className="max-h-[36rem] overflow-auto rounded border border-[#e4dfd4]">
              <table className="min-w-full text-left text-sm">
                <thead className="sticky top-0 bg-[#f4f0e6] text-xs uppercase text-[#466257]">
                  <tr>
                    {cabeceraCalendario('fecha_inicio', 'Fecha inicio')}
                    {cabeceraCalendario('fecha_fin', 'Fecha fin')}
                    {cabeceraCalendario('categoria', 'Tipo')}
                    {cabeceraCalendario('nombre', 'Concurso', 'min-w-64')}
                    {cabeceraCalendario('provincia', 'Provincia')}
                    {cabeceraCalendario('sede', 'Sede', 'min-w-48')}
                    <th className="px-3 py-2">Acciones</th>
                  </tr>
                  <tr className="border-t border-[#e4dfd4] bg-white">
                    <th className="px-2 py-1.5">
                      <input
                        aria-label="Filtrar por fecha de inicio"
                        type="search"
                        placeholder="dd/mm/aaaa"
                        value={calendarFilters.fecha_inicio}
                        onChange={(event) => setCalendarFilters({ ...calendarFilters, fecha_inicio: event.target.value })}
                        className="input w-32 text-xs font-normal normal-case"
                      />
                    </th>
                    <th className="px-2 py-1.5">
                      <input
                        aria-label="Filtrar por fecha de fin"
                        type="search"
                        placeholder="dd/mm/aaaa"
                        value={calendarFilters.fecha_fin}
                        onChange={(event) => setCalendarFilters({ ...calendarFilters, fecha_fin: event.target.value })}
                        className="input w-32 text-xs font-normal normal-case"
                      />
                    </th>
                    <th className="px-2 py-1.5">
                      <select
                        aria-label="Filtrar por tipo"
                        value={calendarFilters.categoria}
                        onChange={(event) => setCalendarFilters({ ...calendarFilters, categoria: event.target.value })}
                        className="input min-w-32 text-xs font-normal normal-case"
                      >
                        <option value="">Todos</option>
                        {categoriasCalendario.map((categoria) => <option key={categoria} value={categoria}>{categoria}</option>)}
                      </select>
                    </th>
                    <th className="px-2 py-1.5">
                      <input
                        aria-label="Filtrar por concurso"
                        type="search"
                        placeholder="Buscar concurso"
                        value={calendarFilters.nombre}
                        onChange={(event) => setCalendarFilters({ ...calendarFilters, nombre: event.target.value })}
                        className="input min-w-56 text-xs font-normal normal-case"
                      />
                    </th>
                    <th className="px-2 py-1.5">
                      <select
                        aria-label="Filtrar por provincia"
                        value={calendarFilters.provincia}
                        onChange={(event) => setCalendarFilters({ ...calendarFilters, provincia: event.target.value })}
                        className="input min-w-32 text-xs font-normal normal-case"
                      >
                        <option value="">Todas</option>
                        {provinciasCalendario.map((provincia) => <option key={provincia} value={provincia}>{provincia}</option>)}
                      </select>
                    </th>
                    <th className="px-2 py-1.5">
                      <input
                        aria-label="Filtrar por sede"
                        type="search"
                        placeholder="Buscar sede"
                        value={calendarFilters.sede}
                        onChange={(event) => setCalendarFilters({ ...calendarFilters, sede: event.target.value })}
                        className="input min-w-44 text-xs font-normal normal-case"
                      />
                    </th>
                    <th />
                  </tr>
                </thead>
                <tbody>
                  {concursosFiltrados.map((contest, index) => (
                    <tr key={`${contest.urlDetalle}-${index}`} className="border-t border-[#eee9df] even:bg-[#fffdfa]">
                      <td className="whitespace-nowrap px-3 py-2">{formatearFecha(contest.fecha_inicio)}</td>
                      <td className="whitespace-nowrap px-3 py-2">{formatearFecha(contest.fecha_fin)}</td>
                      <td className="whitespace-nowrap px-3 py-2">{contest.categoria}</td>
                      <td className="px-3 py-2 font-medium text-[#173b2f]">{contest.nombre}</td>
                      <td className="whitespace-nowrap px-3 py-2">{contest.provincia}</td>
                      <td className="px-3 py-2">{contest.sede}</td>
                      <td className="whitespace-nowrap px-3 py-2">
                        <div className="flex items-center gap-2">
                          <button
                            type="button"
                            onClick={() => verInscritos(contest.urlDetalle)}
                            className="btn btn-sm btn-outline"
                            title="Muestra abajo los datos del concurso y la lista de jinetes y caballos inscritos"
                          >
                            <Users className="size-4" aria-hidden="true" />
                            Ver inscritos
                          </button>
                          <Link
                            href={`/admin/concursos/nuevo?${new URLSearchParams({
                              nombre: contest.nombre,
                              tipo: contest.categoria,
                              fecha_inicio: contest.fecha_inicio,
                              fecha_fin: contest.fecha_fin,
                              provincia: contest.provincia,
                              ubicacion: contest.sede,
                              rfhe: contest.urlDetalle,
                            })}`}
                            className="btn btn-sm btn-outline"
                            title="Abre el formulario de nuevo concurso con estos datos ya rellenos"
                          >
                            <CalendarPlus className="size-4" aria-hidden="true" />
                            Crear concurso
                          </Link>
                          <a href={contest.urlDetalle} target="_blank" rel="noopener noreferrer" className="btn btn-sm btn-outline" title="Abre la ficha del concurso en la web de la Federación, en otra pestaña">
                            <ExternalLink className="size-4" aria-hidden="true" />
                            Ver en la web de RFHE
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

      <form id="datos-concurso" onSubmit={extraerDatos} className="scroll-mt-24 space-y-4 rounded-lg border border-[#e4dfd4] bg-white p-5">
        <div>
          <h3 className="text-lg font-semibold text-[#173b2f]">Datos e inscritos de un concurso</h3>
          <p className="mt-1 text-sm text-gray-600">
            Pulsa «Ver inscritos» en un concurso del calendario, o pega aquí la dirección de su página en RFHE.
          </p>
        </div>
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
              onChange={(event) => campo.id === 'concursoUrl'
                ? cambiarUrlConcurso(event.target.value)
                : setUrls({ ...urls, [campo.id]: event.target.value })}
              className="input w-full"
            />
          </div>
        ))}

        <div className="flex flex-wrap items-center justify-between gap-3 border-t border-[#eee9df] pt-4">
          <p className="max-w-xl text-xs leading-5 text-gray-500">
            Datos públicos de la web de la RFHE, que cualquiera puede consultar en cualquier momento sin usuario ni contraseña.
            Junto a cada dato se indica la dirección de la que procede. Esta pantalla solo los muestra para revisarlos: no guarda nada.
          </p>
          <button type="submit" disabled={cargando} className="btn btn-primary shrink-0">
            {cargando ? <LoaderCircle className="size-4 animate-spin" /> : <FileSearch className="size-4" />}
            {cargando ? 'Cargando datos…' : 'Ver datos e inscritos'}
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
