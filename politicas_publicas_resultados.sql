-- ============================================
-- PRUEBAS: lectura pública
-- ============================================
DROP POLICY IF EXISTS "pruebas_select_public" ON pruebas;
CREATE POLICY "pruebas_select_public" ON pruebas
FOR SELECT TO public USING (true);

-- ============================================
-- PARTICIPACIONES: lectura pública
-- ============================================
DROP POLICY IF EXISTS "participaciones_select_public" ON participaciones;
CREATE POLICY "participaciones_select_public" ON participaciones
FOR SELECT TO public USING (true);

-- ============================================
-- INSCRIPCIONES: lectura pública
-- ============================================
DROP POLICY IF EXISTS "inscripciones_select_public" ON inscripciones;
CREATE POLICY "inscripciones_select_public" ON inscripciones
FOR SELECT TO public USING (true);

-- ============================================
-- Verificar
-- ============================================
SELECT tablename, policyname, cmd, roles::text
FROM pg_policies
WHERE tablename IN ('pruebas', 'participaciones', 'inscripciones')
  AND cmd = 'SELECT'
ORDER BY tablename, policyname;
