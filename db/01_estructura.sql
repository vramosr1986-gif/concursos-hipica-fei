-- ============================================
-- ESTRUCTURA DE LA BASE DE DATOS
-- ============================================

-- ============================================
-- PROFILES (perfiles de usuario)
-- ============================================
CREATE TABLE IF NOT EXISTS profiles (
  id uuid PRIMARY KEY,
  email text NOT NULL,
  nombre text,
  rol text NOT NULL DEFAULT 'juez' CHECK (rol IN ('admin', 'juez')),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_profiles_rol ON profiles(rol);

-- ============================================
-- REPRISES (catálogo de reprises)
-- ============================================
CREATE TABLE IF NOT EXISTS reprises (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  numero text,
  nombre text NOT NULL,
  codigo text UNIQUE NOT NULL,
  categoria text,
  nivel text,
  tipo text,
  anio int,
  tiempo_orientativo text,
  edad_minima_caballo int,
  total_maximo int,
  reprise_oficial text,
  descripcion text,
  multiplicador numeric DEFAULT 1,
  desviacion numeric DEFAULT 0,
  fei_numero text UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_reprises_categoria ON reprises(categoria);
CREATE INDEX IF NOT EXISTS idx_reprises_codigo ON reprises(codigo);

-- ============================================
-- EJERCICIOS_REPRISE
-- ============================================
CREATE TABLE IF NOT EXISTS ejercicios_reprise (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  reprise_id uuid NOT NULL REFERENCES reprises(id) ON DELETE CASCADE,
  numero_orden int NOT NULL,
  letra text,
  descripcion text NOT NULL,
  coeficiente numeric NOT NULL DEFAULT 1,
  puntuacion_max int NOT NULL DEFAULT 10,
  tipo text NOT NULL DEFAULT 'movimiento',
  created_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_ejercicios_reprise ON ejercicios_reprise(reprise_id, numero_orden);

-- ============================================
-- BINOMIOS (catálogo de jinetes+caballos)
-- ============================================
CREATE TABLE IF NOT EXISTS binomios (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre_jinete text NOT NULL,
  nombre_caballo text NOT NULL,
  anio int,
  licencia_federativa text UNIQUE,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- ============================================
-- CONCURSOS
-- ============================================
CREATE TABLE IF NOT EXISTS concursos (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre text NOT NULL,
  fecha_inicio date NOT NULL,
  fecha_fin date NOT NULL,
  ubicacion text,
  organizador text,
  created_by uuid REFERENCES profiles(id),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_concursos_fecha ON concursos(fecha_inicio);

-- ============================================
-- INSCRIPCIONES (binomios inscritos a concursos)
-- ============================================
CREATE TABLE IF NOT EXISTS inscripciones (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  binomio_id uuid NOT NULL REFERENCES binomios(id) ON DELETE CASCADE,
  concurso_id uuid NOT NULL REFERENCES concursos(id) ON DELETE CASCADE,
  dorsal int NOT NULL,
  categoria text,
  equipo text,
  orden_salida int,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE (concurso_id, dorsal)
);

CREATE INDEX IF NOT EXISTS idx_inscripciones_concurso ON inscripciones(concurso_id);
CREATE INDEX IF NOT EXISTS idx_inscripciones_binomio ON inscripciones(binomio_id);

-- ============================================
-- PRUEBAS (una prueba dentro de un concurso)
-- ============================================
CREATE TABLE IF NOT EXISTS pruebas (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  concurso_id uuid NOT NULL REFERENCES concursos(id) ON DELETE CASCADE,
  reprise_id uuid REFERENCES reprises(id) ON DELETE SET NULL,
  nombre text NOT NULL,
  categoria text,
  fecha date NOT NULL,
  hora_inicio time NOT NULL,
  pista text,
  orden int DEFAULT 1,
  estado text DEFAULT 'programada',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_pruebas_concurso ON pruebas(concurso_id);
CREATE INDEX IF NOT EXISTS idx_pruebas_fecha ON pruebas(fecha);

-- ============================================
-- PRUEBA_JUECES (jueces asignados a una prueba)
-- ============================================
CREATE TABLE IF NOT EXISTS prueba_jueces (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  prueba_id uuid NOT NULL REFERENCES pruebas(id) ON DELETE CASCADE,
  juez_id uuid NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  letra text NOT NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE (prueba_id, letra)
);

CREATE INDEX IF NOT EXISTS idx_prueba_jueces_prueba ON prueba_jueces(prueba_id);

-- ============================================
-- PARTICIPACIONES (binomios participantes en pruebas)
-- ============================================
CREATE TABLE IF NOT EXISTS participaciones (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  prueba_id uuid NOT NULL REFERENCES pruebas(id) ON DELETE CASCADE,
  inscripcion_id uuid NOT NULL REFERENCES inscripciones(id) ON DELETE CASCADE,
  orden_salida int NOT NULL,
  hora_salida time,
  estado text DEFAULT 'pendiente',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE (prueba_id, inscripcion_id)
);

CREATE INDEX IF NOT EXISTS idx_participaciones_prueba ON participaciones(prueba_id);
CREATE INDEX IF NOT EXISTS idx_participaciones_inscripcion ON participaciones(inscripcion_id);

-- ============================================
-- PUNTUACIONES (puntuaciones de los jueces)
-- ============================================
CREATE TABLE IF NOT EXISTS puntuaciones (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  participacion_id uuid NOT NULL REFERENCES participaciones(id) ON DELETE CASCADE,
  juez_id uuid NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  letra_juez text NOT NULL,
  notas jsonb,
  puntuacion_final numeric,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE (participacion_id, juez_id)
);

CREATE INDEX IF NOT EXISTS idx_puntuaciones_participacion ON puntuaciones(participacion_id);
CREATE INDEX IF NOT EXISTS idx_puntuaciones_juez ON puntuaciones(juez_id);

SELECT 'Estructura creada correctamente' AS resultado;
