-- 008_pruebas_jornada.sql
-- Anade jornada_id a pruebas y migra los datos existentes

-- PASO 1: Hacer pista y hora_inicio nullable en jornadas
ALTER TABLE jornadas ALTER COLUMN pista DROP NOT NULL;
ALTER TABLE jornadas ALTER COLUMN hora_inicio DROP NOT NULL;

-- PASO 2: Anadir jornada_id a pruebas
ALTER TABLE pruebas
  ADD COLUMN IF NOT EXISTS jornada_id uuid REFERENCES jornadas(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_pruebas_jornada ON pruebas(jornada_id);

-- PASO 3: Crear una jornada por cada (concurso_id, fecha) distinta
-- y asignar las pruebas a su jornada
DO $$
DECLARE
  r RECORD;
  j_id uuid;
  contador int;
BEGIN
  FOR r IN
    SELECT DISTINCT concurso_id, fecha
    FROM pruebas
    WHERE jornada_id IS NULL AND fecha IS NOT NULL
    ORDER BY concurso_id, fecha
  LOOP
    -- Contar jornadas ya existentes en ese concurso
    SELECT COALESCE(MAX(numero), 0) INTO contador
    FROM jornadas WHERE concurso_id = r.concurso_id;

    -- Buscar si ya existe jornada con esa fecha
    SELECT id INTO j_id FROM jornadas
    WHERE concurso_id = r.concurso_id AND fecha = r.fecha
    LIMIT 1;

    -- Si no existe, crearla
    IF j_id IS NULL THEN
      INSERT INTO jornadas (concurso_id, fecha, numero)
      VALUES (r.concurso_id, r.fecha, contador + 1)
      RETURNING id INTO j_id;
    END IF;

    -- Asignar jornada a las pruebas de ese dia
    UPDATE pruebas
    SET jornada_id = j_id
    WHERE concurso_id = r.concurso_id
      AND fecha = r.fecha
      AND jornada_id IS NULL;
  END LOOP;
END $$;

-- PASO 4: Verificacion
SELECT
  c.nombre AS concurso,
  j.numero AS jornada,
  j.fecha AS fecha_jornada,
  COUNT(p.id) AS num_pruebas
FROM pruebas p
JOIN jornadas j ON j.id = p.jornada_id
JOIN concursos c ON c.id = p.concurso_id
GROUP BY c.nombre, j.numero, j.fecha
ORDER BY c.nombre, j.fecha;