-- 009_pruebas_nivel.sql
-- Anade nivel, categoria y tipo de prueba a pruebas

-- PASO 1: Anadir columnas
ALTER TABLE pruebas
  ADD COLUMN IF NOT EXISTS nivel_id uuid REFERENCES niveles(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS categoria_edad_id uuid REFERENCES categorias_edad(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS tipo_prueba_id uuid REFERENCES tipos_prueba(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS coeficiente numeric(4,2) DEFAULT 1.0;

CREATE INDEX IF NOT EXISTS idx_pruebas_nivel ON pruebas(nivel_id);
CREATE INDEX IF NOT EXISTS idx_pruebas_categoria_edad ON pruebas(categoria_edad_id);
CREATE INDEX IF NOT EXISTS idx_pruebas_tipo ON pruebas(tipo_prueba_id);

-- PASO 2: Rellenar nivel_id desde la reprise asignada
UPDATE pruebas p
SET nivel_id = sub.nivel_id
FROM (
  SELECT DISTINCT ON (reprise_id) reprise_id, nivel_id
  FROM niveles_reprises
  ORDER BY reprise_id, nivel_id
) sub
WHERE p.reprise_id = sub.reprise_id
  AND p.nivel_id IS NULL;

-- PASO 3: Rellenar tipo_prueba_id desde el codigo de la reprise
UPDATE pruebas p
SET tipo_prueba_id = tp.id
FROM reprises r
JOIN tipos_prueba tp ON (
  (r.codigo LIKE '%-PRE%' AND tp.codigo = 'PRE') OR
  (r.codigo LIKE '%-EQU%' AND tp.codigo = 'EQU') OR
  (r.codigo LIKE '%-IND%' AND tp.codigo = 'IND') OR
  (r.codigo LIKE '%-FIN%' AND tp.codigo = 'FIN') OR
  (r.codigo LIKE '%-EXP%' AND tp.codigo = 'EXP') OR
  (r.codigo LIKE '%-KUR%' AND tp.codigo = 'KUR') OR
  (r.codigo LIKE 'RFHE-AP-%' AND tp.codigo = 'AP')
)
WHERE p.reprise_id = r.id
  AND p.tipo_prueba_id IS NULL;

-- PASO 4: Verificacion
SELECT
  c.nombre AS concurso,
  p.nombre AS prueba,
  n.codigo AS nivel,
  ce.nombre AS categoria_edad,
  tp.nombre AS tipo_prueba,
  p.coeficiente
FROM pruebas p
LEFT JOIN concursos c ON c.id = p.concurso_id
LEFT JOIN niveles n ON n.id = p.nivel_id
LEFT JOIN categorias_edad ce ON ce.id = p.categoria_edad_id
LEFT JOIN tipos_prueba tp ON tp.id = p.tipo_prueba_id
ORDER BY c.nombre, p.fecha, p.orden;