-- Asegurar RLS activo
ALTER TABLE concursos ENABLE ROW LEVEL SECURITY;
ALTER TABLE jornadas ENABLE ROW LEVEL SECURITY;
ALTER TABLE pruebas ENABLE ROW LEVEL SECURITY;
ALTER TABLE binomios ENABLE ROW LEVEL SECURITY;
ALTER TABLE inscripciones ENABLE ROW LEVEL SECURITY;
ALTER TABLE equipos ENABLE ROW LEVEL SECURITY;

-- SELECT público en todas
DROP POLICY IF EXISTS "public_read_concursos" ON concursos;
CREATE POLICY "public_read_concursos" ON concursos FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "public_read_jornadas" ON jornadas;
CREATE POLICY "public_read_jornadas" ON jornadas FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "public_read_pruebas" ON pruebas;
CREATE POLICY "public_read_pruebas" ON pruebas FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "public_read_binomios" ON binomios;
CREATE POLICY "public_read_binomios" ON binomios FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "public_read_inscripciones" ON inscripciones;
CREATE POLICY "public_read_inscripciones" ON inscripciones FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "public_read_equipos" ON equipos;
CREATE POLICY "public_read_equipos" ON equipos FOR SELECT TO public USING (true);

-- Escritura solo admins
DROP POLICY IF EXISTS "admin_write_concursos" ON concursos;
CREATE POLICY "admin_write_concursos" ON concursos FOR ALL TO authenticated
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'))
WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'));

DROP POLICY IF EXISTS "admin_write_jornadas" ON jornadas;
CREATE POLICY "admin_write_jornadas" ON jornadas FOR ALL TO authenticated
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'))
WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'));

DROP POLICY IF EXISTS "admin_write_pruebas" ON pruebas;
CREATE POLICY "admin_write_pruebas" ON pruebas FOR ALL TO authenticated
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'))
WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'));

DROP POLICY IF EXISTS "admin_write_binomios" ON binomios;
CREATE POLICY "admin_write_binomios" ON binomios FOR ALL TO authenticated
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'))
WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'));

DROP POLICY IF EXISTS "admin_write_inscripciones" ON inscripciones;
CREATE POLICY "admin_write_inscripciones" ON inscripciones FOR ALL TO authenticated
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'))
WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'));

DROP POLICY IF EXISTS "admin_write_equipos" ON equipos;
CREATE POLICY "admin_write_equipos" ON equipos FOR ALL TO authenticated
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'))
WITH CHECK (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'));

-- Verificación final
SELECT tablename, policyname, cmd, roles
FROM pg_policies
WHERE tablename IN ('concursos','jornadas','pruebas','binomios','inscripciones','equipos')
ORDER BY tablename, cmd;