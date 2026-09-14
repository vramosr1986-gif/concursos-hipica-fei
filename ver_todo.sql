-- ============================================================
-- Ver concursos, inscripciones y equipos actuales
-- ============================================================

-- 1. Concursos
SELECT 
  id::text,
  nombre,
  fecha_inicio,
  fecha_fin,
  ubicacion
FROM concursos
ORDER BY fecha_inicio;

-- 2. Inscripciones por concurso
SELECT 
  c.nombre AS concurso,
  i.id::text AS inscripcion_id,
  i.dorsal,
  b.nombre_jinete || ' / ' || b.nombre_caballo AS binomio,
  COALESCE(i.categoria, 'sin categoria') AS categoria
FROM inscripciones i
JOIN concursos c ON c.id = i.concurso_id
JOIN binomios b ON b.id = i.binomio_id
ORDER BY c.fecha_inicio, i.dorsal;

-- 3. Equipos existentes
SELECT 
  c.nombre AS concurso,
  e.id::text AS equipo_id,
  e.nombre AS equipo,
  COUNT(em.id) AS num_miembros
FROM equipos e
JOIN concursos c ON c.id = e.concurso_id
LEFT JOIN equipo_miembros em ON em.equipo_id = e.id
GROUP BY c.nombre, c.fecha_inicio, e.id, e.nombre
ORDER BY c.fecha_inicio, e.nombre;