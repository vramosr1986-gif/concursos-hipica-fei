-- Lectura pública de resultados: permisos de SELECT para anon
-- (concursos, puntuaciones, binomios y ejercicios_reprise ya son legibles por anon)

DROP POLICY IF EXISTS "pruebas_select_anon" ON pruebas;
CREATE POLICY "pruebas_select_anon" ON pruebas
  FOR SELECT TO anon USING (true);

DROP POLICY IF EXISTS "participaciones_select_anon" ON participaciones;
CREATE POLICY "participaciones_select_anon" ON participaciones
  FOR SELECT TO anon USING (true);

DROP POLICY IF EXISTS "inscripciones_select_anon" ON inscripciones;
CREATE POLICY "inscripciones_select_anon" ON inscripciones
  FOR SELECT TO anon USING (true);