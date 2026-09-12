-- Ver puntuaciones por participacion
SELECT 
  c.nombre AS concurso,
  p.nombre AS prueba,
  b.nombre_jinete || ' / ' || b.nombre_caballo AS binomio,
  COUNT(pu.id) AS num_jueces,
  ROUND(AVG(pu.puntuacion_final), 2) AS media_puntos
FROM puntuaciones pu
LEFT JOIN participaciones pa ON pa.id = pu.participacion_id
LEFT JOIN inscripciones i ON i.id = pa.inscripcion_id
LEFT JOIN binomios b ON b.id = i.binomio_id
LEFT JOIN pruebas p ON p.id = pa.prueba_id
LEFT JOIN concursos c ON c.id = p.concurso_id
GROUP BY c.nombre, p.nombre, b.nombre_jinete, b.nombre_caballo
ORDER BY c.nombre, p.nombre, media_puntos DESC;
