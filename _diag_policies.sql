SELECT tablename, policyname, cmd, roles
FROM pg_policies
WHERE tablename IN ('concursos','jornadas','pruebas','binomios','inscripciones','equipos')
ORDER BY tablename, cmd;