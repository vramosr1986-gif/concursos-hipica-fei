export const FEI_CRITERIOS = [
  {
    id: 1,
    nombre: 'Andadura',
    descripcion: 'Calidad de la andadura',
    nivel: 'basico',
    puntuacion_max: 10,
    coeficiente: 1,
  },
  {
    id: 2,
    nombre: 'Contacto',
    descripcion: 'Contacto con la boca del caballo',
    nivel: 'basico',
    puntuacion_max: 10,
    coeficiente: 1,
  },
  {
    id: 3,
    nombre: 'Impulsión',
    descripcion: 'Impulsión del movimiento',
    nivel: 'basico',
    puntuacion_max: 10,
    coeficiente: 1,
  },
  {
    id: 4,
    nombre: 'Rectitud',
    descripcion: 'Rectitud en los movimientos',
    nivel: 'basico',
    puntuacion_max: 10,
    coeficiente: 1,
  },
  {
    id: 5,
    nombre: 'Actitud',
    descripcion: 'Actitud general del caballo',
    nivel: 'basico',
    puntuacion_max: 10,
    coeficiente: 1,
  },
];

export const FEI_REPRISES_BASICO = [
  {
    numero: 'A',
    nombre: 'Reprise A - Inicial',
    desviacion: 1.2,
    multiplicador: 1.0,
    fei_numero: 'A',
  },
  {
    numero: '1',
    nombre: 'Reprise 1 - Elemental',
    desviacion: 1.3,
    multiplicador: 1.1,
    fei_numero: '1',
  },
  {
    numero: '2',
    nombre: 'Reprise 2 - Elemental',
    desviacion: 1.3,
    multiplicador: 1.1,
    fei_numero: '2',
  },
  {
    numero: '3',
    nombre: 'Reprise 3 - Elemental',
    desviacion: 1.3,
    multiplicador: 1.1,
    fei_numero: '3',
  },
];

export const LETRAS_JUECES = [
  { letra: 'C', posicion: 'Centro' },
  { letra: 'A', posicion: 'Entrada' },
  { letra: 'K', posicion: 'Esquina' },
  { letra: 'E', posicion: 'Lado' },
  { letra: 'H', posicion: 'Esquina' },
  { letra: 'F', posicion: 'Lado' },
  { letra: 'M', posicion: 'Esquina' },
  { letra: 'B', posicion: 'Lado' },
  { letra: 'P', posicion: 'Esquina' },
  { letra: 'D', posicion: 'Lado' },
  { letra: 'L', posicion: 'Esquina' },
  { letra: 'V', posicion: 'Lado' },
  { letra: 'X', posicion: 'Centro (auxiliar)' },
];

// Escala de puntuación FEI (0-10)
export const ESCALA_PUNTUACION = [
  { valor: 0, descripcion: 'No ejecutado' },
  { valor: 1, descripcion: 'Muy deficiente' },
  { valor: 2, descripcion: 'Deficiente' },
  { valor: 3, descripcion: 'Insuficiente' },
  { valor: 4, descripcion: 'Aceptable' },
  { valor: 5, descripcion: 'Satisfactorio' },
  { valor: 6, descripcion: 'Bien' },
  { valor: 7, descripcion: 'Muy bien' },
  { valor: 8, descripcion: 'Excelente' },
  { valor: 9, descripcion: 'Excepcional' },
  { valor: 10, descripcion: 'Perfecto' },
];
export const ESPECIALIDADES = [
  'Doma clásica (Dressage)',
  'Salto de obstáculos (Jumping)',
  'Concurso completo (Eventing)',
  'Raid / Endurance',
  'Enganches (Driving)',
  'Vaulting / Volteo',
  'Reining',
  'Para Dressage',
  'Para Driving',
  'Horseball',
  'Mounted Games',
  'TREC',
  'Polo',
  'Working Equitation',
  'Otra',
];


// Nota: Para obtener las 67 reprises FEI completas, descargar desde:
// - https://www.fei.org (sitio oficial)
// - https://rfhe.es (Real Federación Hípica Española)
// Incluye reprises de nivel elemental, medium, advanced y grand prix

// Ejercicios/movimientos típicos por nivel, a modo informativo, mientras no se importe
// el catálogo oficial RFHE con los ejercicios reales de cada reprise.
export const EJERCICIOS_POR_NIVEL: Record<string, string[]> = {
  preliminar: ['Círculos de 20m', 'Transiciones entre aires', 'Paradas y reanudaciones'],
  elemental: ['Círculos de 15m', 'Cesiones a la pierna', 'Transiciones dentro del aire'],
  medio: ['Apoyos', 'Contra-cambios de mano al trote', 'Medios pasos'],
  'san jorge': ['Cambios de pie simples', 'Apoyos al galope', 'Piruetas de trabajo'],
  'intermedia i': ['Cambios de pie en serie cada 4 tiempos', 'Piaffe (pasos in situ)', 'Piruetas al galope'],
  'intermedia ii': ['Cambios de pie en serie cada 3 tiempos', 'Passage', 'Piruetas al galope avanzadas'],
  'gran premio': ['Cambios de pie en serie cada 1 tiempo', 'Piaffe', 'Passage', 'Piruetas de galope completas'],
};
