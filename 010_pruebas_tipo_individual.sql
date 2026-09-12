-- 010_pruebas_tipo_individual.sql
-- Rellena tipo_prueba_id = Individual para las pruebas que no lo tengan

UPDATE pruebas p
SET tipo_prueba_id = (SELECT id FROM tipos_prueba WHERE codigo = 'IND')
WHERE p.tipo_prueba_id IS NULL;

-- Verificacion
SELECT
  c.nombre AS concurso,
  p.nombre AS prueba,
  n.codigo AS nivel,
  tp.nombre AS tipo_prueba
FROM pruebas p
LEFT JOIN concursos c ON c.id = p.concurso_id
LEFT JOIN niveles n ON n.id = p.nivel_id
LEFT JOIN tipos_prueba tp ON tp.id = p.tipo_prueba_id
ORDER BY c.nombre, p.fecha, p.orden;