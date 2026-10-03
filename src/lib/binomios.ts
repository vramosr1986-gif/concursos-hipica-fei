// Reconocer un binomio que ya existe para no duplicarlo: mismo LDN y LAC, misma
// licencia o mismos nombres (sin importar el orden "Apellidos, Nombre", tildes
// ni mayúsculas).

export type DatosBinomio = {
  id?: string;
  nombre_jinete: string;
  nombre_caballo: string;
  ldn_jinete?: string | null;
  lac_caballo?: string | null;
  licencia_federativa?: string | null;
};

/** Palabras del nombre normalizadas y ordenadas: "Abollo Fontela, Alba" = "Alba Abollo Fontela". */
export function claveNombre(nombre: string | null | undefined): string {
  return (nombre || '')
    .normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase()
    .replace(/\b(d|dna|dona|don)\b\.?/g, ' ') // "D." / "Dña." de las listas de admitidos
    .split(/[^a-z0-9]+/).filter(Boolean).sort().join(' ');
}

export function esMismoBinomio(a: DatosBinomio, b: DatosBinomio): boolean {
  if (a.ldn_jinete && b.ldn_jinete && a.lac_caballo && b.lac_caballo) {
    return a.ldn_jinete === b.ldn_jinete && a.lac_caballo === b.lac_caballo;
  }
  if (a.licencia_federativa && b.licencia_federativa && a.licencia_federativa === b.licencia_federativa) return true;
  const mismoCaballo = a.lac_caballo && b.lac_caballo
    ? a.lac_caballo === b.lac_caballo
    : claveNombre(a.nombre_caballo) === claveNombre(b.nombre_caballo);
  const mismoJinete = a.ldn_jinete && b.ldn_jinete
    ? a.ldn_jinete === b.ldn_jinete
    : claveNombre(a.nombre_jinete) === claveNombre(b.nombre_jinete);
  return mismoCaballo && mismoJinete;
}

/** Campos que el binomio existente tiene vacíos y el nuevo trae: solo se rellenan, nunca se pisan. */
export function datosQueFaltan<T extends Record<string, unknown>>(existente: T, nuevo: Partial<T>): Partial<T> {
  const cambios: Partial<T> = {};
  for (const [campo, valor] of Object.entries(nuevo) as [keyof T, unknown][]) {
    const actual = existente[campo];
    const vacio = actual === null || actual === undefined || actual === '';
    if (vacio && valor !== null && valor !== undefined && valor !== '') cambios[campo] = valor as T[keyof T];
  }
  return cambios;
}
