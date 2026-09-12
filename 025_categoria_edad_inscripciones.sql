-- 025_categoria_edad_inscripciones.sql
-- Anade categoria_edad_id a inscripciones (para guardar tambien la FK)

ALTER TABLE inscripciones 
  ADD COLUMN IF NOT EXISTS categoria_edad_id uuid REFERENCES categorias_edad(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_inscripciones_categoria_edad ON inscripciones(categoria_edad_id);

-- Migrar los datos existentes: mapear el texto 'categoria' a su uuid
UPDATE inscripciones i
SET categoria_edad_id = ce.id
FROM categorias_edad ce
WHERE i.categoria_edad_id IS NULL
  AND i.categoria IS NOT NULL
  AND LOWER(ce.nombre) = LOWER(i.categoria);

-- Verificacion
SELECT 
  COUNT(*) AS total_inscripciones,
  COUNT(categoria_edad_id) AS con_categoria_fk,
  COUNT(categoria) AS con_categoria_texto
FROM inscripciones;