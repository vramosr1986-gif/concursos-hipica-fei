-- Ver el estado de las puntuaciones por prueba
SELECT
  c.nombre AS concurso,
  p.nombre AS prueba,
  COUNT(DISTINCT pa.id) AS participaciones,
  COUNT(DISTINCT pu.id) AS puntuaciones,
  COUNT(DISTINCT pj.id) AS jueces
FROM concursos c
JOIN pruebas p ON p.concurso_id = c.id
LEFT JOIN participaciones pa ON pa.prueba_id = p.id
LEFT JOIN puntuaciones pu ON pu.participacion_id = pa.id
LEFT JOIN prueba_jueces pj ON pj.prueba_id = p.id
GROUP BY c.nombre, c.fecha_inicio, p.nombre, p.fecha, p.orden
ORDER BY c.fecha_inicio, p.fecha, p.orden;