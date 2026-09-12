-- 027_pruebas_es_caballos_jovenes.sql
-- Anade flag es_caballos_jovenes a pruebas y lo rellena automaticamente

-- 1. Anadir columna
ALTER TABLE pruebas 
  ADD COLUMN IF NOT EXISTS es_caballos_jovenes boolean DEFAULT false;

CREATE INDEX IF NOT EXISTS idx_pruebas_es_cj ON pruebas(es_caballos_jovenes);

-- 2. Rellenar las pruebas existentes segun el codigo de la reprise
UPDATE pruebas p
SET es_caballos_jovenes = true
FROM reprises r
WHERE p.reprise_id = r.id
  AND (
    r.codigo LIKE '%CJ4%' OR
    r.codigo LIKE '%CJ5%' OR
    r.codigo LIKE '%CJ6%' OR
    r.codigo LIKE '%CJ7%' OR
    r.codigo LIKE '%CJ8%'
  );

-- 3. Verificacion
SELECT 
  p.nombre AS prueba,
  r.codigo AS reprise,
  p.es_caballos_jovenes
FROM pruebas p
LEFT JOIN reprises r ON r.id = p.reprise_id
WHERE p.concurso_id = (SELECT id FROM concursos WHERE nombre LIKE 'Primavera%' LIMIT 1)
ORDER BY p.fecha, p.orden;