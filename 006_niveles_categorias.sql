-- 006_niveles_categorias.sql
-- Tablas de referencia para clasificar reprises segun RFHE 2026

CREATE TABLE IF NOT EXISTS niveles (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  codigo text UNIQUE NOT NULL,
  nombre text NOT NULL,
  orden int NOT NULL,
  color text,
  descripcion text
);

CREATE TABLE IF NOT EXISTS categorias_edad (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  codigo text UNIQUE NOT NULL,
  nombre text NOT NULL,
  tipo text NOT NULL,
  orden int
);

CREATE TABLE IF NOT EXISTS tipos_prueba (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  codigo text UNIQUE NOT NULL,
  nombre text NOT NULL,
  coeficiente numeric(4,2) DEFAULT 1.0,
  orden int
);

-- Cargar niveles oficiales RFHE (Art. 421)
INSERT INTO niveles (codigo, nombre, orden, color) VALUES
  ('N0',     'Nivel 0 - Acceso a competicion', 0, 'gray'),
  ('N1',     'Nivel 1 - Iniciacion',           1, 'blue'),
  ('N2',     'Nivel 2 - Elemental',            2, 'green'),
  ('N3',     'Nivel 3 - Basico',               3, 'yellow'),
  ('N4',     'Nivel 4 - Medio',                4, 'orange'),
  ('SJ',     'San Jorge - Medio Avanzado',     5, 'purple'),
  ('INT_I',  'Intermedia I',                   6, 'red'),
  ('INT_II', 'Intermedia II',                  7, 'red'),
  ('GP',     'Gran Premio',                    8, 'brown'),
  ('KUR',    'Kur - Estilo libre',             9, 'pink')
ON CONFLICT (codigo) DO NOTHING;

-- Cargar categorias de edad
INSERT INTO categorias_edad (codigo, nombre, tipo, orden) VALUES
  ('ALEVIN',      'Alevines',                 'EDAD',           1),
  ('BENJAMIN',    'Benjamines',               'EDAD',           2),
  ('INFANTIL',    'Infantiles',               'EDAD',           3),
  ('JUVENIL_0',   'Juveniles 0*',             'EDAD',           4),
  ('JUVENIL',     'Juveniles',                'EDAD',           5),
  ('JOVEN_JINETE','Jovenes Jinetes',          'EDAD',           6),
  ('ADULTO',      'Adultos',                  'ADULTO',         7),
  ('PONI',        'Ponis',                    'PONI',           8),
  ('RIDER',       'Rider',                    'FORMACION',      9),
  ('CJ4',         'Caballos Jovenes 4 anos',  'CABALLO_JOVEN', 10),
  ('CJ5',         'Caballos Jovenes 5 anos',  'CABALLO_JOVEN', 11),
  ('CJ6',         'Caballos Jovenes 6 anos',  'CABALLO_JOVEN', 12),
  ('CJ7',         'Caballos Jovenes 7 anos',  'CABALLO_JOVEN', 13),
  ('CJ8_10',      'Caballos Jovenes 8-10 anos','CABALLO_JOVEN',14)
ON CONFLICT (codigo) DO NOTHING;

-- Cargar tipos de prueba
INSERT INTO tipos_prueba (codigo, nombre, coeficiente, orden) VALUES
  ('PRE',  'Preliminar',    1.0, 1),
  ('EQU',  'Equipos',       1.5, 2),
  ('IND',  'Individual',    1.0, 3),
  ('FIN',  'Final',         1.0, 4),
  ('EXP',  'Experimental',  1.0, 5),
  ('KUR',  'Kur',           1.0, 6),
  ('AP',   'Asiento y Posicion',1.0, 7)
ON CONFLICT (codigo) DO NOTHING;

-- Verificacion
SELECT 'niveles' AS tabla, COUNT(*) AS registros FROM niveles
UNION ALL SELECT 'categorias_edad', COUNT(*) FROM categorias_edad
UNION ALL SELECT 'tipos_prueba', COUNT(*) FROM tipos_prueba;