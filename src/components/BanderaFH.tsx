// Bandera (simplificada) de la comunidad autónoma según el código de federación
// territorial que usa la RFHE (columna "FH" de las listas de inscritos).
import type { ReactNode } from 'react';

type Federacion = { nombre: string; dibujo: ReactNode };

const ROJO = '#c8102e';
const AMARILLO = '#fcdd09';
const VERDE = '#007a33';

/** Barras de la senyera (Cataluña, Valencia, Aragón, Baleares): 9 franjas. */
const senyera = (
  <>
    <rect width="24" height="16" fill={AMARILLO} />
    {[1, 3, 5, 7].map((i) => <rect key={i} y={(i * 16) / 9} width="24" height={16 / 9} fill={ROJO} />)}
  </>
);

export const FEDERACIONES: Record<string, Federacion> = {
  AN: {
    nombre: 'Andalucía',
    dibujo: <><rect width="24" height="16" fill="#fff" /><rect width="24" height="5.33" fill={VERDE} /><rect y="10.67" width="24" height="5.33" fill={VERDE} /></>,
  },
  AR: {
    nombre: 'Aragón',
    dibujo: <>{senyera}<rect x="5" y="4.5" width="5" height="7" rx="1" fill="#fff" stroke={ROJO} strokeWidth="0.6" /></>,
  },
  AS: {
    nombre: 'Asturias',
    dibujo: <><rect width="24" height="16" fill="#0066b3" /><rect x="11" y="3" width="2" height="10" fill={AMARILLO} /><rect x="8.5" y="5.5" width="7" height="2" fill={AMARILLO} /></>,
  },
  BA: {
    nombre: 'Illes Balears',
    dibujo: <>{senyera}<rect width="11" height="8" fill="#5f2167" /><rect x="4" y="2.5" width="3" height="3.5" fill="#fff" /></>,
  },
  CB: {
    nombre: 'Cantabria',
    dibujo: <><rect width="24" height="16" fill="#fff" /><rect y="8" width="24" height="8" fill={ROJO} /></>,
  },
  CL: {
    nombre: 'Castilla y León',
    dibujo: (
      <>
        <rect width="12" height="8" fill={ROJO} /><rect x="12" width="12" height="8" fill="#fff" />
        <rect y="8" width="12" height="8" fill="#fff" /><rect x="12" y="8" width="12" height="8" fill={ROJO} />
        <rect x="4" y="2" width="4" height="4" fill={AMARILLO} /><rect x="16" y="10" width="4" height="4" fill={AMARILLO} />
        <circle cx="18" cy="4" r="2" fill="#6b2c91" /><circle cx="6" cy="12" r="2" fill="#6b2c91" />
      </>
    ),
  },
  CM: {
    nombre: 'Castilla-La Mancha',
    dibujo: <><rect width="12" height="16" fill="#9b1b30" /><rect x="12" width="12" height="16" fill="#fff" /><rect x="4" y="5" width="4" height="5" fill={AMARILLO} /></>,
  },
  CN: {
    nombre: 'Canarias',
    dibujo: <><rect width="8" height="16" fill="#fff" /><rect x="8" width="8" height="16" fill="#0768a9" /><rect x="16" width="8" height="16" fill={AMARILLO} /></>,
  },
  CT: { nombre: 'Cataluña', dibujo: senyera },
  EX: {
    nombre: 'Extremadura',
    dibujo: <><rect width="24" height="16" fill="#fff" /><rect width="24" height="5.33" fill={VERDE} /><rect y="10.67" width="24" height="5.33" fill="#000" /></>,
  },
  GA: {
    nombre: 'Galicia',
    dibujo: <><rect width="24" height="16" fill="#fff" /><path d="M0 0 L5 0 L24 13 L24 16 L19 16 L0 3 Z" fill="#0099cc" /></>,
  },
  MA: {
    nombre: 'Comunidad de Madrid',
    dibujo: (
      <>
        <rect width="24" height="16" fill={ROJO} />
        {[[6, 6], [10, 6], [14, 6], [18, 6], [8, 10], [12, 10], [16, 10]].map(([x, y]) => <circle key={`${x}-${y}`} cx={x} cy={y} r="1.2" fill="#fff" />)}
      </>
    ),
  },
  MU: {
    nombre: 'Región de Murcia',
    dibujo: (
      <>
        <rect width="24" height="16" fill="#9b1b30" />
        {[[2, 2], [6, 2], [2, 6], [6, 6]].map(([x, y]) => <rect key={`${x}-${y}`} x={x} y={y} width="2.5" height="2.5" fill={AMARILLO} />)}
        {[[14, 11], [18, 11], [16, 7]].map(([x, y]) => <rect key={`${x}-${y}`} x={x} y={y} width="3" height="2" fill={AMARILLO} />)}
      </>
    ),
  },
  NA: {
    nombre: 'Navarra',
    dibujo: <><rect width="24" height="16" fill={ROJO} /><rect x="7" y="4" width="10" height="8" fill="none" stroke={AMARILLO} strokeWidth="1.2" /><path d="M7 4 L17 12 M17 4 L7 12 M12 4 V12 M7 8 H17" stroke={AMARILLO} strokeWidth="0.8" /></>,
  },
  RI: {
    nombre: 'La Rioja',
    dibujo: <><rect width="24" height="4" fill={ROJO} /><rect y="4" width="24" height="4" fill="#fff" /><rect y="8" width="24" height="4" fill={VERDE} /><rect y="12" width="24" height="4" fill={AMARILLO} /></>,
  },
  VA: {
    nombre: 'Comunitat Valenciana',
    dibujo: <>{senyera}<rect width="6" height="16" fill="#0060a8" /></>,
  },
  VS: {
    nombre: 'País Vasco',
    dibujo: <><rect width="24" height="16" fill="#d52b1e" /><path d="M0 0 L24 16 M24 0 L0 16" stroke={VERDE} strokeWidth="2.6" /><path d="M12 0 V16 M0 8 H24" stroke="#fff" strokeWidth="2.6" /></>,
  },
};

export function nombreFederacion(codigo: string | null | undefined): string | null {
  return codigo ? FEDERACIONES[codigo.toUpperCase()]?.nombre || null : null;
}

/**
 * Bandera pequeña de la comunidad con su código (VA, AR, CT...) al lado:
 * varias banderas se parecen mucho en pequeño. Si el código no se conoce, solo el código.
 */
export function BanderaFH({ codigo, conCodigo = true, className = '' }: {
  codigo: string | null | undefined;
  conCodigo?: boolean;
  className?: string;
}) {
  if (!codigo) return null;
  const cod = codigo.toUpperCase();
  const fed = FEDERACIONES[cod];
  if (!fed) {
    return <span className={`inline-block rounded border border-gray-300 px-1 text-[0.65rem] font-semibold text-gray-600 ${className}`} title={`Federación ${cod}`}>{cod}</span>;
  }
  return (
    <span className={`inline-flex shrink-0 items-center gap-1 ${className}`} title={fed.nombre}>
      <svg
        viewBox="0 0 24 16"
        width="21"
        height="14"
        role="img"
        aria-label={fed.nombre}
        className="inline-block shrink-0 rounded-[2px] ring-1 ring-black/15"
      >
        {fed.dibujo}
      </svg>
      {conCodigo && <span className="text-[0.7rem] font-semibold leading-none opacity-70" aria-hidden="true">{cod}</span>}
    </span>
  );
}

/** Desplegable de federaciones autonómicas, con la bandera de la elegida al lado. */
export function SelectorFederacion({ id, etiqueta, valor, onChange }: {
  id: string;
  etiqueta: string;
  valor: string;
  onChange: (codigo: string) => void;
}) {
  const opciones = Object.entries(FEDERACIONES).sort((a, b) => a[1].nombre.localeCompare(b[1].nombre, 'es'));
  return (
    <div>
      <label htmlFor={id} className="mb-2 block text-sm font-bold">{etiqueta}</label>
      <div className="flex items-center gap-2">
        <select id={id} value={valor} onChange={(e) => onChange(e.target.value)} className="input w-full">
          <option value="">-- Sin indicar --</option>
          {opciones.map(([codigo, f]) => <option key={codigo} value={codigo}>{f.nombre} ({codigo})</option>)}
        </select>
        <BanderaFH codigo={valor} conCodigo={false} />
      </div>
    </div>
  );
}

/** Nombre del caballo con la bandera de su comunidad delante. */
export function CaballoConBandera({ nombre, fh }: { nombre: string; fh: string | null | undefined }) {
  return (
    <span className="inline-flex items-center gap-1.5">
      <BanderaFH codigo={fh} />
      <span>{nombre}</span>
    </span>
  );
}
