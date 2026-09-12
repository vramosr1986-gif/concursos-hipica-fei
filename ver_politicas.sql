SELECT 
  tablename, 
  policyname, 
  cmd, 
  roles::text
FROM pg_policies 
WHERE tablename IN ('concursos', 'pruebas', 'participaciones', 'puntuaciones', 'binomios', 'inscripciones')
ORDER BY tablename, cmd;
