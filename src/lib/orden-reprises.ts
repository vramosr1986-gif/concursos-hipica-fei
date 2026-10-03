// Orden de reprises tal como aparece en https://rfhe.com/doma-clasica/reprises/
const SECCIONES_RFHE: { titulo: string; codigos: string[] }[] = [
  {
    titulo: 'Nivel 0',
    codigos: ['RFHE-AP-FIN', 'RFHE-AP-PRE', 'RFHE-BEN-1', 'RFHE-BEN-2'],
  },
  {
    titulo: 'Nivel 1',
    codigos: [
      'RFHE-2022-CJ4-EXP', 'RFHE-2022-CJ4-FIN', 'RFHE-2022-CJ4-PRE',
      'RFHE-2024-ALE-EQU', 'RFHE-2024-ALE-IND', 'RFHE-2024-ALE-PRE',
      'RFHE-2022-PRO-1',
      'RFHE-2024-RID-1A', 'RFHE-2024-RID-1B', 'RFHE-2024-RID-1C',
    ],
  },
  {
    titulo: 'Nivel 2',
    codigos: [
      'RFHE-2022-CJ5-FIN', 'RFHE-2022-CJ5-PRE',
      'RFHE-2024-INF-EQU', 'RFHE-2024-INF-IND', 'RFHE-2024-INF-PRE-A', 'RFHE-2024-INF-PRE-B',
      'RFHE-2024-PRO-2',
      'RFHE-2024-RID-2A', 'RFHE-2024-RID-2B', 'RFHE-2024-RID-2C',
    ],
  },
  {
    titulo: 'Nivel 3',
    codigos: [
      'RFHE-2022-JUV0-EQU', 'RFHE-2022-JUV0-IND', 'RFHE-2022-JUV0-PRE',
      'RFHE-2022-KUR-JUV0', 'RFHE-2022-KUR-PON',
      'RFHE-2022-PRO-3',
      'RFHE-2024-RID-3A', 'RFHE-2024-RID-3B', 'RFHE-2024-RID-3C',
      'RFHE-2022-PON-EQU', 'RFHE-2022-PON-IND', 'RFHE-2022-PON-PRE',
    ],
  },
  {
    titulo: 'Nivel 4',
    codigos: [
      'RFHE-2022-CJ6-FIN', 'RFHE-2022-CJ6-PRE',
      'RFHE-2023-CLA-1', 'RFHE-2023-CLA-2', 'RFHE-2023-CLA-3',
      'RFHE-2018-JUV-IND', 'RFHE-2022-JUV-PRE', 'RFHE-2022-JUV-EQU',
      'RFHE-2022-KUR-JUV',
      'RFHE-2022-PRO-4',
    ],
  },
  {
    titulo: 'Nivel Gran Premio',
    codigos: [
      'RFHE-2022-CJ8-10', 'RFHE-2022-GPE', 'RFHE-2022-GPU25', 'RFHE-2022-GP', 'RFHE-2022-KUR-GP',
    ],
  },
  { titulo: 'Nivel Intermedia 1', codigos: ['RFHE-2022-INT-I', 'RFHE-2022-KUR-INT-I'] },
  { titulo: 'Nivel Intermedia 2', codigos: ['RFHE-2022-INT-II'] },
  {
    titulo: 'Nivel Intermedia A-B',
    codigos: ['RFHE-2022-INT-A', 'RFHE-2022-INT-B', 'RFHE-2022-KUR-INT-AB'],
  },
  {
    titulo: 'Nivel San Jorge',
    codigos: [
      'RFHE-2022-JJ-EQU', 'RFHE-2022-JJ-IND', 'RFHE-2022-JJ-PRE', 'RFHE-2022-KUR-JJ',
      'RFHE-2022-CJ7-PRE', 'RFHE-2022-SJ', 'RFHE-2022-CJ7-FIN', 'RFHE-2022-CJ7-FIN2',
    ],
  },
];

const ORDEN_RFHE = SECCIONES_RFHE.flatMap((s) => s.codigos);
const EDADES_CABALLOS_JOVENES = ['4 años', '5 años', '6 años', '7 años', '8-10 años'];

export type GrupoReprises<T> = { titulo: string; caballosJovenes: boolean; items: T[] };

const posicion = (codigo: string) => {
  const i = ORDEN_RFHE.indexOf(codigo);
  return i === -1 ? Number.MAX_SAFE_INTEGER : i;
};

const edadCaballoJoven = (codigo: string): string | null => {
  const m = codigo.match(/-CJ(\d+(?:-\d+)?)/);
  return m ? `${m[1]} años` : null;
};

export function compararRfhe(
  a: { codigo: string; nombre: string },
  b: { codigo: string; nombre: string }
): number {
  return posicion(a.codigo) - posicion(b.codigo) || a.nombre.localeCompare(b.nombre);
}

export function ordenarRfhe<T extends { codigo: string; nombre: string }>(reprises: T[]): T[] {
  return [...reprises].sort(compararRfhe);
}

// Primero las reprises por nivel; después las de caballos jóvenes separadas por edad.
export function agruparRfhe<T extends { codigo: string; nombre: string }>(
  reprises: T[]
): GrupoReprises<T>[] {
  const ordenadas = ordenarRfhe(reprises);
  const grupos: GrupoReprises<T>[] = [];

  for (const seccion of SECCIONES_RFHE) {
    const items = ordenadas.filter(
      (r) => seccion.codigos.includes(r.codigo) && !edadCaballoJoven(r.codigo)
    );
    if (items.length) grupos.push({ titulo: seccion.titulo, caballosJovenes: false, items });
  }

  const otras = ordenadas.filter(
    (r) => posicion(r.codigo) === Number.MAX_SAFE_INTEGER && !edadCaballoJoven(r.codigo)
  );
  if (otras.length) grupos.push({ titulo: 'Otras reprises', caballosJovenes: false, items: otras });

  for (const edad of EDADES_CABALLOS_JOVENES) {
    const items = ordenadas.filter((r) => edadCaballoJoven(r.codigo) === edad);
    if (items.length) {
      grupos.push({ titulo: `Caballos jóvenes · ${edad}`, caballosJovenes: true, items });
    }
  }

  return grupos;
}
