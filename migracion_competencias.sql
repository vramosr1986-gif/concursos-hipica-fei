-- ============================================
-- PASO 3: Apuntar competencias a inscripciones
-- ============================================

ALTER TABLE competencias DROP CONSTRAINT IF EXISTS competencias_binomio_id_fkey;
ALTER TABLE competencias RENAME COLUMN binomio_id TO inscripcion_id;

-- Migrar los valores: cada competencia ahora apunta a la inscripción correspondiente
UPDATE competencias c
SET inscripcion_id = i.id
FROM inscripciones i
WHERE c.inscripcion_id = i.binomio_id;

ALTER TABLE competencias ADD CONSTRAINT competencias_inscripcion_id_fkey
  FOREIGN KEY (inscripcion_id) REFERENCES inscripciones(id) ON DELETE CASCADE;
