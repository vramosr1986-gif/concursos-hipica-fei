'use client';

import { useState } from 'react';
import { AlertTriangle, CheckCircle2, LoaderCircle, Search } from 'lucide-react';
import { fetchConSesion } from '@/lib/juez-actual';
import { claveNombre } from '@/lib/binomios';
import { buscarCaballoEnRfhe, buscarJineteEnRfhe } from '@/lib/rfhe-busqueda';

type Resultado = { codigo: string; nombre: string; detalle: string };

type Props = {
  tipo: 'jinete' | 'caballo';
  /** Nombre escrito en el formulario. */
  nombre: string;
  /** LDN (jinete) o LAC (caballo) escrito en el formulario. */
  codigo: string;
  /** Rellena el código y el nombre con los de la RFHE. */
  onUsar: (codigo: string, nombre: string) => void;
};

/** Coincide si todas las palabras de un nombre están en el otro ("Lucía Gonzalez-Sabariegos" ⊂ "Gonzalez-Sabariegos Hdez., Lucía"). */
const mismoNombre = (a: string, b: string) => {
  const pa = claveNombre(a).split(' ').filter(Boolean);
  const pb = claveNombre(b).split(' ').filter(Boolean);
  if (pa.length === 0 || pb.length === 0) return false;
  const [corto, largo] = pa.length <= pb.length ? [pa, new Set(pb)] : [pb, new Set(pa)];
  return corto.every((p) => largo.has(p));
};

/**
 * Consulta la RFHE desde la app, enseña lo que contesta y dice si coincide
 * con el nombre y el código (LDN / LAC) puestos en el formulario.
 */
export function ComprobarRfhe({ tipo, nombre, codigo, onUsar }: Props) {
  const etiqueta = tipo === 'jinete' ? 'LDN' : 'LAC';
  const [cargando, setCargando] = useState(false);
  const [error, setError] = useState('');
  const [busqueda, setBusqueda] = useState<string | null>(null);
  const [resultados, setResultados] = useState<Resultado[] | null>(null);

  const comprobar = async () => {
    setError('');
    if (!nombre.trim()) {
      setError(`Escribe el nombre del ${tipo} para poder comprobarlo.`);
      return;
    }
    setCargando(true);
    try {
      const res = await fetchConSesion('/api/admin/rfhe-buscar', { method: 'POST', body: JSON.stringify({ tipo, nombre }) });
      const data = await res.json().catch(() => ({}));
      if (!res.ok) throw new Error(data.error || 'No se pudo consultar la RFHE');
      setBusqueda(data.busqueda);
      setResultados((data.resultados || []).map((r: Record<string, string>) => tipo === 'jinete'
        ? { codigo: r.ldn, nombre: r.nombre, detalle: [r.categoria, r.anio && `licencia ${r.anio}`].filter(Boolean).join(' · ') }
        : { codigo: r.lac, nombre: r.nombre, detalle: [r.edad && `${r.edad} años`, r.raza, r.capa, r.sexo].filter(Boolean).join(' · ') }));
    } catch (err) {
      setError(err instanceof Error ? err.message : 'No se pudo consultar la RFHE');
      setResultados(null);
    } finally {
      setCargando(false);
    }
  };

  // Veredicto (se recalcula si se cambia el código después de buscar).
  let veredicto: { ok: boolean; texto: string } | null = null;
  if (resultados) {
    const cod = codigo.trim();
    const porCodigo = cod ? resultados.find((r) => r.codigo === cod) : undefined;
    const porNombre = resultados.filter((r) => mismoNombre(r.nombre, nombre));
    if (cod && porCodigo && mismoNombre(porCodigo.nombre, nombre)) {
      veredicto = { ok: true, texto: `Coincide con la RFHE: ${porCodigo.nombre} · ${etiqueta} ${porCodigo.codigo}` };
    } else if (cod && porCodigo) {
      veredicto = { ok: false, texto: `El ${etiqueta} ${cod} existe en la RFHE, pero a nombre de «${porCodigo.nombre}», no de «${nombre}».` };
    } else if (cod && porNombre.length > 0) {
      veredicto = { ok: false, texto: `No coincide: en la RFHE «${porNombre[0].nombre}» tiene el ${etiqueta} ${porNombre[0].codigo}, no el ${cod}.` };
    } else if (cod) {
      veredicto = { ok: false, texto: `No coincide: la RFHE no devuelve el ${etiqueta} ${cod} al buscar «${busqueda}».` };
    } else if (porNombre.length === 1) {
      veredicto = { ok: true, texto: `Encontrado en la RFHE: ${porNombre[0].nombre} · ${etiqueta} ${porNombre[0].codigo}. Pulsa «Usar estos datos» para ponerlo en el formulario.` };
    } else if (resultados.length === 0) {
      veredicto = { ok: false, texto: `La RFHE no tiene ningún ${tipo} al buscar «${busqueda}». Revisa cómo está escrito.` };
    }
  }

  return (
    <div className="mt-2">
      <div className="flex flex-wrap items-center gap-2">
        <button type="button" onClick={comprobar} disabled={cargando} className="btn btn-outline btn-sm">
          {cargando ? <LoaderCircle className="size-3.5 animate-spin" aria-hidden="true" /> : <Search className="size-3.5" aria-hidden="true" />}
          {cargando ? 'Consultando…' : 'Comprobar en la RFHE'}
        </button>
        <button
          type="button"
          onClick={() => (tipo === 'jinete' ? buscarJineteEnRfhe(nombre) : buscarCaballoEnRfhe(nombre))}
          className="text-xs text-primary hover:underline"
          title="Abre la búsqueda en la web de la RFHE, en otra pestaña"
        >
          Ver en la web de la RFHE
        </button>
      </div>

      {error && <p role="alert" className="mt-2 text-xs text-red-700">{error}</p>}

      {veredicto && (
        <p role="status" className={`mt-2 flex items-start gap-1.5 rounded p-2 text-sm ${veredicto.ok ? 'bg-green-50 text-green-800' : 'bg-amber-50 text-amber-900'}`}>
          {veredicto.ok
            ? <CheckCircle2 className="mt-0.5 size-4 shrink-0 text-green-600" aria-hidden="true" />
            : <AlertTriangle className="mt-0.5 size-4 shrink-0 text-amber-600" aria-hidden="true" />}
          <span>{veredicto.texto}</span>
        </p>
      )}

      {resultados && resultados.length > 0 && (
        <div className="mt-2 rounded border border-[#e4dfd4]">
          <p className="border-b bg-[#f8f7f3] px-2 py-1 text-xs text-gray-600">
            La RFHE contesta ({resultados.length}) al buscar «{busqueda}»:
          </p>
          <ul className="max-h-48 divide-y overflow-auto text-sm">
            {resultados.map((r) => {
              const elegido = r.codigo === codigo.trim();
              return (
                <li key={r.codigo} className={`flex flex-wrap items-center justify-between gap-2 px-2 py-1.5 ${elegido ? 'bg-green-50' : ''}`}>
                  <span>
                    <strong className="font-mono">{r.codigo}</strong> · {r.nombre}
                    {r.detalle && <span className="block text-xs text-gray-500">{r.detalle}</span>}
                  </span>
                  {elegido && r.nombre === nombre.trim() ? (
                    <span className="flex items-center gap-1 text-xs text-green-700"><CheckCircle2 className="size-3.5" aria-hidden="true" /> El puesto</span>
                  ) : (
                    <button type="button" onClick={() => onUsar(r.codigo, r.nombre)} className="btn btn-outline btn-sm whitespace-nowrap" title={`Pone el ${etiqueta} ${r.codigo} y el nombre «${r.nombre}» en el formulario`}>
                      Usar estos datos
                    </button>
                  )}
                </li>
              );
            })}
          </ul>
        </div>
      )}
    </div>
  );
}
