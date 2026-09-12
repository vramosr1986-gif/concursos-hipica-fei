-- 015_equipos.sql (v2)
-- Sistema de equipos: tablas, migracion y flag en pruebas

-- ============================================================
-- 1. TABLA EQUIPOS
-- ============================================================
CREATE TABLE IF NOT EXISTS equipos (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  concurso_id uuid NOT NULL REFERENCES concursos(id) ON DELETE CASCADE,
  nombre text NOT NULL,
  club text,
  categoria_edad_id uuid REFERENCES categorias_edad(id) ON DELETE SET NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE (concurso_id, nombre)
);

CREATE INDEX IF NOT EXISTS idx_equipos_concurso ON equipos(concurso_id);

-- ============================================================
-- 2. TABLA EQUIPO_MIEMBROS
-- ============================================================
CREATE TABLE IF NOT EXISTS equipo_miembros (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  equipo_id uuid NOT NULL REFERENCES equipos(id) ON DELETE CASCADE,
  inscripcion_id uuid NOT NULL REFERENCES inscripciones(id) ON DELETE CASCADE,
  orden int DEFAULT 1,
  created_at timestamptz DEFAULT now(),
  UNIQUE (equipo_id, inscripcion_id)
);

CREATE INDEX IF NOT EXISTS idx_equipo_miembros_equipo ON equipo_miembros(equipo_id);
CREATE INDEX IF NOT EXISTS idx_equipo_miembros_inscripcion ON equipo_miembros(inscripcion_id);

-- ============================================================
-- 3. FLAG EN PRUEBAS
-- ============================================================
ALTER TABLE pruebas
  ADD COLUMN IF NOT EXISTS tiene_clasificacion_equipos boolean DEFAULT false;

-- ============================================================
-- 4. RLS
-- ============================================================
ALTER TABLE equipos ENABLE ROW LEVEL SECURITY;
ALTER TABLE equipo_miembros ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "equipos_select" ON equipos;
CREATE POLICY "equipos_select" ON equipos FOR SELECT TO authenticated USING (true);

DROP POLICY IF EXISTS "equipos_write" ON equipos;
CREATE POLICY "equipos_write" ON equipos FOR ALL TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "equipo_miembros_select" ON equipo_miembros;
CREATE POLICY "equipo_miembros_select" ON equipo_miembros FOR SELECT TO authenticated USING (true);

DROP POLICY IF EXISTS "equipo_miembros_write" ON equipo_miembros;
CREATE POLICY "equipo_miembros_write" ON equipo_miembros FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- ============================================================
-- 5. MIGRAR inscripciones.equipo (texto libre) a equipos reales
-- ============================================================
DO $$
DECLARE
  r RECORD;
  v_equipo_id uuid;
BEGIN
  FOR r IN
    SELECT DISTINCT concurso_id, equipo
    FROM inscripciones
    WHERE equipo IS NOT NULL AND TRIM(equipo) <> ''
  LOOP
    SELECT e.id INTO v_equipo_id
    FROM equipos e
    WHERE e.concurso_id = r.concurso_id AND e.nombre = TRIM(r.equipo)
    LIMIT 1;

    IF v_equipo_id IS NULL THEN
      INSERT INTO equipos (concurso_id, nombre)
      VALUES (r.concurso_id, TRIM(r.equipo))
      RETURNING id INTO v_equipo_id;
    END IF;
  END LOOP;

  INSERT INTO equipo_miembros (equipo_id, inscripcion_id)
  SELECT e.id, i.id
  FROM inscripciones i
  JOIN equipos e ON e.concurso_id = i.concurso_id AND e.nombre = TRIM(i.equipo)
  WHERE i.equipo IS NOT NULL AND TRIM(i.equipo) <> ''
  ON CONFLICT DO NOTHING;
END $$;

-- ============================================================
-- 6. BORRAR COLUMNA VIEJA
-- ============================================================
ALTER TABLE inscripciones DROP COLUMN IF EXISTS equipo;

-- ============================================================
-- 7. VERIFICACION
-- ============================================================
SELECT 'equipos' AS tabla, COUNT(*) AS total FROM equipos
UNION ALL
SELECT 'equipo_miembros', COUNT(*) FROM equipo_miembros;

SELECT 
  c.nombre AS concurso,
  e.nombre AS equipo,
  COUNT(em.id) AS num_miembros
FROM equipos e
LEFT JOIN equipo_miembros em ON em.equipo_id = e.id
LEFT JOIN concursos c ON c.id = e.concurso_id
GROUP BY c.nombre, e.nombre
ORDER BY c.nombre, e.nombre;