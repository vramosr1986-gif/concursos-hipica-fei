-- Ver inscripciones de Otoño 2026 y Primavera 2026
SELECT 
  c.nombre AS concurso,
  i.dorsal,
  b.nombre_jinete || ' / ' || b.nombre_caballo AS binomio,
  COALESCE(i.categoria, '-') AS categoria,
  i.id::text AS inscripcion_id,
  CASE 
    WHEN em.equipo_id IS NULL THEN 'sin equipo'
    ELSE 'en equipo'
  END AS estado
FROM inscripciones i
JOIN concursos c ON c.id = i.concurso_id
JOIN binomios b ON b.id = i.binomio_id
LEFT JOIN equipo_miembros em ON em.inscripcion_id = i.id
WHERE c.nombre IN ('Otono 2026', 'Primavera 2026')
ORDER BY c.nombre, i.dorsal;