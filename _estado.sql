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
