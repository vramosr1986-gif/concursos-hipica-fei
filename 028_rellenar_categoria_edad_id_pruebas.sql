-- 028_rellenar_categoria_edad_id_pruebas.sql
-- Rellena categoria_edad_id de las pruebas segun su texto 'categoria'

-- 1. Rellenar las pruebas que tienen texto pero no FK
UPDATE pruebas p
SET categoria_edad_id = ce.id
FROM categorias_edad ce
WHERE p.categoria_edad_id IS NULL
  AND p.categoria IS NOT NULL
  AND LOWER(ce.nombre) = LOWER(p.categoria);

-- 2. Verificacion
SELECT 
  p.id,
  p.nombre,
  p.categoria,
  p.categoria_edad_id,
  ce.nombre AS categoria_fk
FROM pruebas p
LEFT JOIN categorias_edad ce ON ce.id = p.categoria_edad_id
WHERE p.concurso_id = (SELECT id FROM concursos WHERE nombre LIKE 'Primavera%' LIMIT 1)
ORDER BY p.fecha, p.orden;