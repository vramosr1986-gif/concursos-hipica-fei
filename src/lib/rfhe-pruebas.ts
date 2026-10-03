// Reglas para convertir la relación de inscritos de la RFHE en pruebas del concurso.
// Sin dependencias de Node: se usa tanto en el navegador como en la API.

export type Jornada = 'Sábado · jornada 1' | 'Domingo · jornada 2' | 'Asignación manual';

const sinAcentos = (texto: string) => texto.normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();

/** Jornada en la que se suele montar cada reprise. */
export function sugerirJornada(reprise: string): Jornada {
  const nombre = sinAcentos(reprise);
  const domingo = /\b(final(?:es)?|individual(?:es)?|kur|san\s*jorge|intermedia|gran\s*premio|grand\s*prix|sj|int[\s._-]*(?:i{1,2}|[12])|gp)\b/;
  const sabado = /\b(preliminar(?:es)?|equipos|promocion|infantil(?:es)?|alevin(?:es)?|benjamin(?:es)?|n[0-4]|rider\s*[1-3]|ponis?\s*[abc])\b/;

  // Clásica 1 se monta el sábado y Clásica 2 el domingo.
  if (/\bclasica\s*1\b/.test(nombre)) return 'Sábado · jornada 1';
  if (/\bclasica\s*2\b/.test(nombre)) return 'Domingo · jornada 2';
  if (domingo.test(nombre)) return 'Domingo · jornada 2';
  if (sabado.test(nombre)) return 'Sábado · jornada 1';
  return 'Asignación manual';
}

/** Fecha ISO de la jornada: sábado = primer día, domingo = segundo (sin pasar del último). */
export function fechaDeJornada(jornada: Jornada, fechaInicio: string, fechaFin: string): string {
  if (jornada !== 'Domingo · jornada 2') return fechaInicio;
  const [a, m, d] = fechaInicio.split('-').map(Number);
  const siguiente = new Date(Date.UTC(a, m - 1, d + 1)).toISOString().slice(0, 10);
  return siguiente > fechaFin ? fechaFin : siguiente;
}

// Abreviaturas de la RFHE → palabras del catálogo de reprises.
const EQUIVALENCIAS: Record<string, string[]> = {
  yr: ['jovenes', 'jinetes'],
  j: ['juveniles'],
  junior: ['juveniles'],
  juniors: ['juveniles'],
  juvenil: ['juveniles'],
  '0e': ['0'],
  gp: ['gran', 'premio'],
  intermediate: ['intermedia'],
  rider: ['r'],
  benjamin: ['benjamines'],
  alevin: ['alevines'],
  infantil: ['infantiles'],
  poni: ['ponis'],
};

/** Clave comparable de un nombre de reprise: palabras normalizadas y ordenadas. */
export function claveReprise(nombre: string): string {
  let texto = sinAcentos(nombre)
    .replace(/\*/g, '')
    .replace(/([a-z])(\d)/g, '$1 $2') // "jovenes7" → "jovenes 7"
    .replace(/\bcaballos\s+jovenes\b/g, ' ');
  texto = texto.replace(/[^a-z0-9]+/g, ' ').trim();
  const palabras = texto.split(' ').filter(Boolean).flatMap((p) => EQUIVALENCIAS[p] || [p]);
  return palabras.filter((p) => p !== 'de').sort().join(' ');
}

export function emparejarReprise<T extends { nombre: string }>(nombreRfhe: string, catalogo: T[]): T | null {
  const clave = claveReprise(nombreRfhe);
  return catalogo.find((r) => claveReprise(r.nombre) === clave) || null;
}

/** A partir del enlace de un concurso RFHE, el de su relación de inscritos/admitidos. */
export function crearUrlInscritos(concursoUrl: string): string | null {
  try {
    const url = new URL(concursoUrl);
    const programa = url.searchParams.get('PRGNAME');
    if (!programa || !['RFHECALCON', 'RFHECONADM', 'RFHECONLISINS'].includes(programa)) return null;
    url.searchParams.set('PRGNAME', 'RFHECONLISINS');
    return url.toString();
  } catch {
    return null;
  }
}
