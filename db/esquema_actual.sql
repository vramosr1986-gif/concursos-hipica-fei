-- ============================================================
-- ESQUEMA ACTUAL DE LA BASE DE DATOS (generado, no editar a mano)
-- Proyecto: irrdaheiicjnirodcbgu
-- Generado: 2026-10-04 con: node scripts/exportar-esquema.mjs
--
-- Refleja tablas, columnas, tipos, valores por defecto y claves tal como
-- están ahora en Supabase. No incluye políticas RLS, funciones ni el código
-- de las vistas (ver las migraciones numeradas).
-- ============================================================

CREATE TABLE binomios (
  id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
  nombre_jinete text NOT NULL,
  nombre_caballo text NOT NULL,
  anio integer,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  licencia_federativa text,
  anio_nacimiento_caballo integer,
  fecha_nacimiento_jinete date,
  estado_validacion character varying DEFAULT 'pendiente',
  ldn_jinete character varying,
  lac_caballo character varying,
  fh_jinete text,
  fh_caballo text,
  consentimiento_datos_at timestamp with time zone,
  PRIMARY KEY (id)
);

CREATE TABLE concursos (
  id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
  nombre text NOT NULL,
  fecha_inicio date NOT NULL,
  fecha_fin date NOT NULL,
  ubicacion text,
  organizador text,
  created_by uuid,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  licencia_federativa text,
  tipo text,
  federacion text,
  federprovincia text,
  provincia text,
  rfhe_url text,
  PRIMARY KEY (id)
);

CREATE TABLE jornadas (
  id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
  concurso_id uuid REFERENCES concursos(id),
  fecha date NOT NULL,
  numero integer NOT NULL,
  pista text,
  hora_inicio time without time zone,
  hora_fin time without time zone,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  PRIMARY KEY (id)
);

CREATE TABLE reprises (
  id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
  numero text NOT NULL,
  nombre text NOT NULL,
  descripcion text,
  fei_numero text NOT NULL,
  desviacion numeric NOT NULL,
  multiplicador numeric NOT NULL,
  nivel text,
  created_at timestamp with time zone DEFAULT now(),
  codigo text,
  categoria text,
  tipo text,
  anio integer,
  tiempo_orientativo text,
  edad_minima_caballo integer,
  total_maximo integer,
  reprise_oficial text,
  PRIMARY KEY (id)
);

CREATE TABLE jornada_reprises (
  id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
  jornada_id uuid REFERENCES jornadas(id),
  reprise_id uuid REFERENCES reprises(id),
  orden integer NOT NULL,
  hora_salida time without time zone NOT NULL,
  pista text,
  created_at timestamp with time zone DEFAULT now(),
  categoria text,
  PRIMARY KEY (id)
);

CREATE TABLE categorias_edad (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  codigo text NOT NULL,
  nombre text NOT NULL,
  tipo text NOT NULL,
  orden integer,
  PRIMARY KEY (id)
);

CREATE TABLE inscripciones (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  binomio_id uuid NOT NULL REFERENCES binomios(id),
  concurso_id uuid NOT NULL REFERENCES concursos(id),
  dorsal integer NOT NULL,
  orden_salida integer,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  categoria text,
  categoria_edad_id uuid REFERENCES categorias_edad(id),
  PRIMARY KEY (id)
);

CREATE TABLE competencias (
  id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
  jornada_reprise_id uuid REFERENCES jornada_reprises(id),
  inscripcion_id uuid REFERENCES inscripciones(id),
  orden_salida integer NOT NULL,
  hora_salida time without time zone NOT NULL,
  estado text NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  PRIMARY KEY (id)
);

CREATE TABLE profiles (
  id uuid NOT NULL,
  email text,
  nombre text,
  rol text NOT NULL DEFAULT 'juez',
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  fecha_nacimiento date,
  PRIMARY KEY (id)
);

CREATE TABLE jueces (
  id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
  concurso_id uuid REFERENCES concursos(id),
  user_id uuid REFERENCES profiles(id),
  nombre text NOT NULL,
  letra_oficial text NOT NULL,
  experiencia text,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  full_name text,
  email text,
  telefono text,
  especialidad text,
  categoria text,
  activo boolean DEFAULT true,
  PRIMARY KEY (id)
);

CREATE TABLE ejercicios_reprise (
  id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
  reprise_id uuid REFERENCES reprises(id),
  numero_orden integer NOT NULL,
  descripcion text NOT NULL,
  letra text,
  coeficiente numeric NOT NULL DEFAULT 1,
  created_at timestamp with time zone DEFAULT now(),
  puntuacion_max integer NOT NULL DEFAULT 10,
  tipo text NOT NULL DEFAULT 'movimiento',
  PRIMARY KEY (id)
);

CREATE TABLE calificaciones_ejercicio (
  id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
  competencia_id uuid REFERENCES competencias(id),
  juez_id uuid REFERENCES jueces(id),
  ejercicio_id uuid REFERENCES ejercicios_reprise(id),
  nota numeric NOT NULL,
  comentario text,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  PRIMARY KEY (id)
);

CREATE TABLE criterios_fei (
  id integer NOT NULL,
  nombre text NOT NULL,
  descripcion text,
  nivel text,
  puntuacion_max integer DEFAULT 10,
  coeficiente numeric DEFAULT 1,
  created_at timestamp with time zone DEFAULT now(),
  PRIMARY KEY (id)
);

CREATE TABLE equipos (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  concurso_id uuid NOT NULL REFERENCES concursos(id),
  nombre text NOT NULL,
  club text,
  categoria_edad_id uuid REFERENCES categorias_edad(id),
  created_at timestamp with time zone DEFAULT now(),
  PRIMARY KEY (id)
);

CREATE TABLE equipo_miembros (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  equipo_id uuid NOT NULL REFERENCES equipos(id),
  inscripcion_id uuid NOT NULL REFERENCES inscripciones(id),
  orden integer DEFAULT 1,
  created_at timestamp with time zone DEFAULT now(),
  PRIMARY KEY (id)
);

CREATE TABLE jornada_reprise_jueces (
  id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
  jornada_reprise_id uuid REFERENCES jornada_reprises(id),
  juez_id uuid REFERENCES jueces(id),
  letra text NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  PRIMARY KEY (id)
);

CREATE TABLE keep_alive (
  id smallint NOT NULL DEFAULT 1,
  pinged_at timestamp with time zone NOT NULL DEFAULT now(),
  PRIMARY KEY (id)
);

CREATE TABLE niveles (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  codigo text NOT NULL,
  nombre text NOT NULL,
  orden integer NOT NULL,
  color text,
  descripcion text,
  PRIMARY KEY (id)
);

CREATE TABLE niveles_reprises (
  nivel_id uuid NOT NULL REFERENCES niveles(id),
  reprise_id uuid NOT NULL REFERENCES reprises(id),
  PRIMARY KEY (nivel_id, reprise_id)
);

CREATE TABLE tipos_prueba (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  codigo text NOT NULL,
  nombre text NOT NULL,
  coeficiente numeric DEFAULT 1,
  orden integer,
  PRIMARY KEY (id)
);

CREATE TABLE pruebas (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  concurso_id uuid NOT NULL REFERENCES concursos(id),
  reprise_id uuid REFERENCES reprises(id),
  nombre text NOT NULL,
  categoria text,
  fecha date NOT NULL,
  hora_inicio time without time zone NOT NULL,
  pista text,
  orden integer DEFAULT 1,
  estado text DEFAULT 'programada',
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  jornada_id uuid REFERENCES jornadas(id),
  nivel_id uuid REFERENCES niveles(id),
  categoria_edad_id uuid REFERENCES categorias_edad(id),
  tipo_prueba_id uuid REFERENCES tipos_prueba(id),
  coeficiente numeric DEFAULT 1,
  es_caballos_jovenes boolean DEFAULT false,
  PRIMARY KEY (id)
);

CREATE TABLE participaciones (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  prueba_id uuid NOT NULL REFERENCES pruebas(id),
  inscripcion_id uuid NOT NULL REFERENCES inscripciones(id),
  orden_salida integer NOT NULL,
  hora_salida time without time zone,
  estado text DEFAULT 'pendiente',
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  equipo_id uuid REFERENCES equipos(id),
  observaciones text,
  PRIMARY KEY (id)
);

CREATE TABLE prueba_jueces (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  prueba_id uuid NOT NULL REFERENCES pruebas(id),
  juez_id uuid NOT NULL REFERENCES profiles(id),
  letra text NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  PRIMARY KEY (id)
);

CREATE TABLE puntuaciones (
  id uuid NOT NULL DEFAULT public.uuid_generate_v4(),
  participacion_id uuid REFERENCES participaciones(id),
  juez_id uuid REFERENCES profiles(id),
  letra_juez text,
  notas jsonb,
  puntuacion_final numeric,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  prueba_juez_id uuid REFERENCES prueba_jueces(id),
  ejercicio_reprise_id uuid REFERENCES ejercicios_reprise(id),
  nota numeric,
  comentario text,
  PRIMARY KEY (id)
);

-- ------------------------------------------------------------
-- VISTAS (solo columnas; su definición está en las migraciones)
-- ------------------------------------------------------------
-- VIEW v_binomios_categorias
--   binomio_id text
--   nombre_jinete text
--   nombre_caballo text
--   fecha_nacimiento_jinete text
--   anio_nacimiento_caballo integer
--   edad_jinete integer
--   edad_caballo integer
--   categoria_jinete text
--   categoria_caballo text
--   categoria_principal text

-- VIEW v_clasificacion_equipos
--   equipo_id uuid
--   equipo_nombre text
--   prueba_id uuid
--   puntuacion_equipo numeric
--   posicion_equipo bigint
--   posicion_miembro bigint
--   dorsal integer
--   nombre_jinete text
--   nombre_caballo text
--   porcentaje numeric
