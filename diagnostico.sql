-- ============================================================
-- DIAGNOSTICO: por que no se ven las puntuaciones
-- ============================================================

-- 1. Estado GENERAL de cada concurso
SELECT 
  c.nombre AS concurso,
  COUNT(DISTINCT i.id) AS inscripciones,
  COUNT(DISTINCT p.id) AS pruebas,
  COUNT(DISTINCT pa.id) AS participaciones,
  COUNT(DISTINCT pu.id) AS puntuaciones,
  COUNT(DISTINCT pj.id) AS jueces_asignados
FROM concursos c
LEFT JOIN inscripciones i ON i.concurso_id = c.id
LEFT JOIN pruebas p ON p.concurso_id = c.id
LEFT JOIN participaciones pa ON pa.prueba_id = p.id
LEFT JOIN puntuaciones pu ON pu.participacion_id = pa.id
LEFT JOIN prueba_jueces pj ON pj.prueba_id = p.id
GROUP BY c.nombre, c.fecha_inicio
ORDER BY c.fecha_inicio;

-- 2. Detalle de Primavera 2026 por prueba
SELECT 
  p.nombre AS prueba,
  COUNT(DISTINCT pa.id) AS participaciones,
  COUNT(DISTINCT pu.id) AS puntuaciones,
  COUNT(DISTINCT pj.id) AS jueces,
  COUNT(DISTINCT pu.prueba_juez_id) AS jueces_puntuando
FROM pruebas p
LEFT JOIN participaciones pa ON pa.prueba_id = p.id
LEFT JOIN puntuaciones pu ON pu.participacion_id = pa.id
LEFT JOIN prueba_jueces pj ON pj.prueba_id = p.id
WHERE p.concurso_id = (SELECT id FROM concursos WHERE nombre = 'Primavera 2026')
GROUP BY p.id, p.nombre, p.orden
ORDER BY p.orden;

-- 3. Ver si hay puntuaciones con problema (nota null, prueba_juez_id null)
SELECT 
  'Puntuaciones con prueba_juez_id NULL' AS problema,
  COUNT(*) AS total
FROM puntuaciones WHERE prueba_juez_id IS NULL
UNION ALL
SELECT 
  'Puntuaciones con nota NULL',
  COUNT(*)
FROM puntuaciones WHERE nota IS NULL
UNION ALL
SELECT 
  'Puntuaciones con letra_juez NULL',
  COUNT(*)
FROM puntuaciones WHERE letra_juez IS NULL
UNION ALL
SELECT 
  'Total puntuaciones',
  COUNT(*)
FROM puntuaciones;