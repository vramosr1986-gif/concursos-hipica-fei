SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public' AND table_type = 'BASE TABLE'
ORDER BY table_name;

SELECT table_name, column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN (
    'concursos','jornadas','binomios','jueces','inscripciones',
    'equipos','equipo_miembros','pruebas','prueba_jueces',
    'participaciones','puntuaciones','reprises','profiles'
  )
ORDER BY table_name, ordinal_position;

SELECT 'concursos' AS tabla, COUNT(*) AS filas FROM concursos
UNION ALL SELECT 'jornadas',         COUNT(*) FROM jornadas
UNION ALL SELECT 'binomios',         COUNT(*) FROM binomios
UNION ALL SELECT 'jueces',           COUNT(*) FROM jueces
UNION ALL SELECT 'inscripciones',    COUNT(*) FROM inscripciones
UNION ALL SELECT 'equipos',          COUNT(*) FROM equipos
UNION ALL SELECT 'equipo_miembros',  COUNT(*) FROM equipo_miembros
UNION ALL SELECT 'pruebas',          COUNT(*) FROM pruebas
UNION ALL SELECT 'prueba_jueces',    COUNT(*) FROM prueba_jueces
UNION ALL SELECT 'participaciones',  COUNT(*) FROM participaciones
UNION ALL SELECT 'puntuaciones',     COUNT(*) FROM puntuaciones
UNION ALL SELECT 'reprises',         COUNT(*) FROM reprises
UNION ALL SELECT 'profiles',         COUNT(*) FROM profiles
ORDER BY tabla;

SELECT id, nombre, fecha_inicio, fecha_fin, ubicacion, organizador
FROM concursos ORDER BY fecha_inicio;

SELECT j.id, c.nombre AS concurso, j.fecha, j.pista, j.hora_inicio, j.hora_fin
FROM jornadas j LEFT JOIN concursos c ON c.id = j.concurso_id
ORDER BY c.nombre, j.fecha;

SELECT id, nombre_jinete, nombre_caballo, licencia
FROM binomios ORDER BY nombre_jinete;

SELECT id, nombre, letra, categoria FROM jueces ORDER BY nombre;

SELECT c.nombre AS concurso, b.nombre_jinete, b.nombre_caballo, i.dorsal, i.categoria
FROM inscripciones i
LEFT JOIN concursos c ON c.id = i.concurso_id
LEFT JOIN binomios  b ON b.id = i.binomio_id
ORDER BY c.nombre, i.dorsal;

SELECT p.id, c.nombre AS concurso, p.nombre, p.nivel, p.categoria, p.tipo, p.estado
FROM pruebas p
LEFT JOIN concursos c ON c.id = p.concurso_id
ORDER BY c.nombre, p.nombre;

SELECT p.nombre AS prueba, b.nombre_jinete,
       COUNT(pt.id) AS num_notas,
       ROUND(AVG(pt.nota)::numeric, 2) AS media
FROM puntuaciones pt
LEFT JOIN participaciones pa ON pa.id = pt.participacion_id
LEFT JOIN pruebas         p  ON p.id  = pa.prueba_id
LEFT JOIN inscripciones   i  ON i.id  = pa.inscripcion_id
LEFT JOIN binomios        b  ON b.id  = i.binomio_id
GROUP BY p.nombre, b.nombre_jinete
ORDER BY p.nombre, b.nombre_jinete;

SELECT id, email, nombre, rol FROM profiles ORDER BY rol, email;
