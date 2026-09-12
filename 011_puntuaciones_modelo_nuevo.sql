-- 011_puntuaciones_modelo_nuevo.sql
-- Anade las columnas del modelo nuevo a puntuaciones

-- 1. Anadir columnas nuevas (nullable al principio)
ALTER TABLE puntuaciones
  ADD COLUMN IF NOT EXISTS prueba_juez_id uuid REFERENCES prueba_jueces(id) ON DELETE CASCADE,
  ADD COLUMN IF NOT EXISTS ejercicio_reprise_id uuid REFERENCES ejercicios_reprise(id) ON DELETE CASCADE,
  ADD COLUMN IF NOT EXISTS nota numeric(4,2) CHECK (nota >= 0 AND nota <= 10),
  ADD COLUMN IF NOT EXISTS comentario text;

-- 2. Indices
CREATE INDEX IF NOT EXISTS idx_puntuaciones_participacion ON puntuaciones(participacion_id);
CREATE INDEX IF NOT EXISTS idx_puntuaciones_prueba_juez ON puntuaciones(prueba_juez_id);
CREATE INDEX IF NOT EXISTS idx_puntuaciones_ejercicio ON puntuaciones(ejercicio_reprise_id);

-- 3. Constraint unico para que no se dupliquen notas por (participacion, juez, ejercicio)
ALTER TABLE puntuaciones
  DROP CONSTRAINT IF EXISTS puntuaciones_unica_por_ejercicio;
ALTER TABLE puntuaciones
  ADD CONSTRAINT puntuaciones_unica_por_ejercicio
  UNIQUE (participacion_id, prueba_juez_id, ejercicio_reprise_id);

-- 4. Verificacion
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'puntuaciones'
ORDER BY ordinal_position;