-- 037_puntuaciones_ficticias.sql
-- Genera puntuaciones ficticias para todas las participaciones sin puntuaciones

-- Primero ver el estado actual
SELECT 
  p.id AS prueba_id,
  p.nombre AS prueba,
  COUNT(DISTINCT pa.id) AS participaciones,
  COUNT(DISTINCT pu.id) AS puntuaciones
FROM pruebas p
LEFT JOIN participaciones pa ON pa.prueba_id = p.id
LEFT JOIN puntuaciones pu ON pu.participacion_id = pa.id
WHERE p.concurso_id = '7994f61f-525e-41db-a920-106b5ee99f38'
GROUP BY p.id, p.nombre
ORDER BY p.nombre;