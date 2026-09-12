
export interface LicenciaFederativa {
  id: string;
  concurso_id: string;
  // Puedes agregar mÃƒÂ¡s campos segÃƒÂºn tu modelo, pero este debe existir en la interfaz.
  // Ejemplo:
  // numero_licencia: string;
  // fecha_expedicion: string;
  // Ã¢â‚¬Â¦
  // Muy importante que el nombre sea exactamente "licencia_federativa?: string"
  // para que el compilador lo acepte como propiedad opcional.
}
export interface EjercicioReprise {
  id: string;
  reprise_id: string;
  numero_orden: number;
  descripcion: string;
  letra?: string;
  coeficiente: number;
  created_at: string;
}

export interface JornadaRepriseJuez {
  id: string;
  jornada_reprise_id: string;
  juez_id: string;
  letra: string;
  created_at: string;
}

export interface CalificacionEjercicio {
  id: string;
  competencia_id: string;
  juez_id: string;
  ejercicio_id: string;
  nota: number;
  comentario?: string;
  created_at: string;
  updated_at: string;
}

// Tipos para la aplicaciÃƒÂ³n

export interface User {
  id: string;
  email: string;
  nombre: string;
  role: 'admin' | 'judge';
  created_at: string;
}

export interface Concurso {
  id: string;
  nombre: string;
  fecha_inicio: string;
  fecha_fin: string;
  ubicacion: string;
  organizador: string;
  created_at: string;
  created_by: string;
}

export interface Jornada {
  id: string;
  concurso_id: string;
  fecha: string;
  numero: number;
  pista: string;
  hora_inicio: string;
  hora_fin?: string;
  created_at: string;
}

export interface Reprise {
  id: string;
  numero: string;
  nombre: string;
  descripcion?: string;
  fei_numero: string;
  desviacion: number; // desviaciÃƒÂ³n estÃƒÂ¡ndar FEI
  multiplicador: number; // multiplicador por reprise
  nivel?: string;
  created_at: string;
}

export interface JornadaReprise {
  id: string;
  jornada_id: string;
  reprise_id: string;
  orden: number;
  hora_salida: string;
  pista: string;
  created_at: string;
}

export interface Binomio {
  id: string;
  concurso_id: string;
  dorsal: number;
  anio: number | null;
  licencia_federativa: string | null;
  nombre_jinete: string;
  nombre_caballo: string;
  equipo: string;
  orden_salida?: number;
  created_at: string;
}

export interface Competencia {
  id: string;
  jornada_reprise_id: string;
  binomio_id: string;
  orden_salida: number;
  hora_salida: string;
  estado: 'pendiente' | 'en_curso' | 'completado' | 'retirado';
  created_at: string;
}

export interface Puntuacion {
  id: string;
  competencia_id: string;
  juez_id: string;
  letra_juez: string;
  notas: Array<{
    criterio: number;
    puntuacion: number;
    coeficiente: number;
  }>;
  puntuacion_final: number;
  created_at: string;
  updated_at: string;
}

export interface Juez {
  id: string;
  concurso_id: string;
  user_id: string;
  nombre: string;
  letra_oficial: string; // A, B, C, D, E, etc.
  experiencia?: string;
  created_at: string;
}

export interface CriterioFEI {
  id: number;
  nombre: string;
  descripcion: string;
  nivel: string;
  puntuacion_max: number;
  coeficiente: number;
}
