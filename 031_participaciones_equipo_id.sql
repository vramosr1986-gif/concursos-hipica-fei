-- 031_participaciones_equipo_id.sql
-- Anade equipo_id a participaciones para saber a que equipo pertenece cada binomio

-- 1. Anadir columna
ALTER TABLE participaciones 
  ADD COLUMN IF NOT EXISTS equipo_id uuid REFERENCES equipos(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_participaciones_equipo ON participaciones(equipo_id);

-- 2. Migrar participaciones existentes: asignar el equipo del binomio si esta en uno
UPDATE participaciones p
SET equipo_id = em.equipo_id
FROM equipo_miembros em
JOIN inscripciones i ON i.id = em.inscripcion_id
WHERE p.inscripcion_id = i.id 
  AND p.equipo_id IS NULL;

-- 3. Verificacion
SELECT 
  p.id,
  p.prueba_id,
  p.inscripcion_id,
  p.equipo_id,
  e.nombre AS equipo_nombre
FROM participaciones p
LEFT JOIN equipos e ON e.id = p.equipo_id
LIMIT 10;