-- 1. Jueces reales (en profiles) y cuántas pruebas tienen asignadas
SELECT p.nombre, p.email, p.rol, COUNT(pj.id) AS pruebas_asignadas
FROM profiles p
LEFT JOIN prueba_jueces pj ON pj.juez_id = p.id
WHERE p.rol IN ('juez', 'admin')
GROUP BY p.nombre, p.email, p.rol
ORDER BY p.rol, p.nombre;

-- 2. ¿Hay alguna prueba_jueces huérfana (juez_id sin profile)?
SELECT COUNT(*) AS huerfanas
FROM prueba_jueces pj
LEFT JOIN profiles p ON p.id = pj.juez_id
WHERE p.id IS NULL;

-- 3. Concursos con su estado
SELECT c.nombre,
       COUNT(DISTINCT i.id) AS inscripciones,
       COUNT(DISTINCT p.id) AS pruebas,
       COUNT(DISTINCT e.id) AS equipos,
       COUNT(DISTINCT pu.id) AS puntuaciones
FROM concursos c
LEFT JOIN inscripciones i ON i.concurso_id = c.id
LEFT JOIN pruebas p ON p.concurso_id = c.id
LEFT JOIN equipos e ON e.concurso_id = c.id
LEFT JOIN puntuaciones pu ON pu.participacion_id IN (
  SELECT pa.id FROM participaciones pa WHERE pa.prueba_id = p.id
)
GROUP BY c.nombre
ORDER BY c.nombre;

-- 4. Detalle de jueces por prueba (para ver si la web puede mostrarlos)
SELECT c.nombre AS concurso,
       p.nombre AS prueba,
       COUNT(pj.id) AS num_jueces,
       STRING_AGG(pr.nombre || ' (' || pj.letra || ')', ', ' ORDER BY pj.letra) AS jueces
FROM pruebas p
JOIN concursos c ON c.id = p.concurso_id
LEFT JOIN prueba_jueces pj ON pj.prueba_id = p.id
LEFT JOIN profiles pr ON pr.id = pj.juez_id
GROUP BY c.nombre, p.nombre
ORDER BY c.nombre, p.nombre;
