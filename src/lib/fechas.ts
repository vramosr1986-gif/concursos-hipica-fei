export type RangoFechas = {
  fecha_inicio: string;
  fecha_fin: string;
};

const MESES: Record<string, number> = {
  ene: 1, feb: 2, mar: 3, abr: 4, may: 5, jun: 6,
  jul: 7, ago: 8, sep: 9, set: 9, oct: 10, nov: 11, dic: 12,
};

function aIso(anio: number, mes: number, dia: number): string | null {
  const fecha = new Date(Date.UTC(anio, mes - 1, dia));
  if (fecha.getUTCFullYear() !== anio || fecha.getUTCMonth() !== mes - 1 || fecha.getUTCDate() !== dia) return null;
  return `${anio}-${String(mes).padStart(2, '0')}-${String(dia).padStart(2, '0')}`;
}

function partesIso(iso: string): [number, number, number] {
  const [anio, mes, dia] = iso.split('-').map(Number);
  return [anio, mes, dia];
}

/**
 * Convierte los textos de fecha del calendario RFHE a un rango ISO (aaaa-mm-dd).
 * Formatos admitidos:
 *  - "14/02/2026"            → un solo día
 *  - "14-15"                 → mes tomado de `fechaInicio` (dd/mm/aaaa de la otra tabla RFHE)
 *  - "28-01 Mar."            → el mes indicado es el del día final; si fin < inicio, el inicio es del mes anterior
 * `fechaInicio` (dd/mm/aaaa), cuando existe, manda sobre el inicio deducido.
 */
export function parsearRangoRFHE(textoFecha: string, anio: number, fechaInicio?: string): RangoFechas | null {
  const texto = textoFecha.replace(/\s+/g, ' ').trim();

  const completa = (valor?: string) => {
    const m = valor?.trim().match(/^(\d{1,2})\/(\d{1,2})\/(\d{2,4})$/);
    if (!m) return null;
    const a = Number(m[3]) < 100 ? 2000 + Number(m[3]) : Number(m[3]);
    return aIso(a, Number(m[2]), Number(m[1]));
  };

  const inicioConocido = completa(fechaInicio);
  const unica = completa(texto);
  if (unica) return { fecha_inicio: inicioConocido || unica, fecha_fin: unica };

  const rango = texto.match(/^(\d{1,2})\s*-\s*(\d{1,2})(?:\s+([a-záéíóú]{3})[a-záéíóú]*\.?)?$/i);
  if (!rango) return inicioConocido ? { fecha_inicio: inicioConocido, fecha_fin: inicioConocido } : null;

  const diaInicio = Number(rango[1]);
  const diaFin = Number(rango[2]);
  const mesTexto = rango[3] ? MESES[rango[3].normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase()] : undefined;

  let inicio: string | null;
  if (inicioConocido) {
    inicio = inicioConocido;
  } else if (mesTexto) {
    const mesIni = diaFin < diaInicio ? (mesTexto === 1 ? 12 : mesTexto - 1) : mesTexto;
    inicio = aIso(diaFin < diaInicio && mesTexto === 1 ? anio - 1 : anio, mesIni, diaInicio);
  } else {
    return null;
  }
  if (!inicio) return null;

  const [anioIni, mesIni] = partesIso(inicio);
  let anioFin = anioIni;
  let mesFin = mesTexto ?? mesIni;
  if (!mesTexto && diaFin < diaInicio) mesFin = mesIni + 1;
  if (mesFin > 12) { mesFin = 1; anioFin += 1; }
  if (mesTexto && mesFin < mesIni) anioFin += 1;

  const fin = aIso(anioFin, mesFin, diaFin);
  if (!fin || fin < inicio) return null;
  return { fecha_inicio: inicio, fecha_fin: fin };
}

/** "14–15/02/2026", "28/02–01/03/2026", "30/12/2026–02/01/2027" o "17/03/2026". */
export function formatearRango(fechaInicio: string, fechaFin?: string | null): string {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(fechaInicio || '')) return '—';
  const fin = fechaFin && /^\d{4}-\d{2}-\d{2}$/.test(fechaFin) ? fechaFin : fechaInicio;
  const [ai, mi, di] = fechaInicio.split('-');
  const [af, mf, df] = fin.split('-');

  if (fin === fechaInicio) return `${di}/${mi}/${ai}`;
  if (ai !== af) return `${di}/${mi}/${ai}–${df}/${mf}/${af}`;
  if (mi !== mf) return `${di}/${mi}–${df}/${mf}/${af}`;
  return `${di}–${df}/${mf}/${af}`;
}

export function compararPorInicio<T extends { fecha_inicio: string; fecha_fin?: string | null }>(a: T, b: T): number {
  return a.fecha_inicio.localeCompare(b.fecha_inicio) ||
    (a.fecha_fin || a.fecha_inicio).localeCompare(b.fecha_fin || b.fecha_inicio);
}
