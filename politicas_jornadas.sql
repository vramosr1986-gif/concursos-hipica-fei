DROP POLICY IF EXISTS "jornadas_insert_authenticated" ON jornadas;
CREATE POLICY "jornadas_insert_authenticated" ON jornadas FOR INSERT TO authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "jornadas_update_authenticated" ON jornadas;
CREATE POLICY "jornadas_update_authenticated" ON jornadas FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "jornadas_delete_authenticated" ON jornadas;
CREATE POLICY "jornadas_delete_authenticated" ON jornadas FOR DELETE TO authenticated USING (true);

DROP POLICY IF EXISTS "jornada_reprises_select_authenticated" ON jornada_reprises;
CREATE POLICY "jornada_reprises_select_authenticated" ON jornada_reprises FOR SELECT TO authenticated USING (true);
DROP POLICY IF EXISTS "jornada_reprises_insert_authenticated" ON jornada_reprises;
CREATE POLICY "jornada_reprises_insert_authenticated" ON jornada_reprises FOR INSERT TO authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "jornada_reprises_update_authenticated" ON jornada_reprises;
CREATE POLICY "jornada_reprises_update_authenticated" ON jornada_reprises FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "jornada_reprises_delete_authenticated" ON jornada_reprises;
CREATE POLICY "jornada_reprises_delete_authenticated" ON jornada_reprises FOR DELETE TO authenticated USING (true);

DROP POLICY IF EXISTS "jornada_reprise_jueces_insert_authenticated" ON jornada_reprise_jueces;
CREATE POLICY "jornada_reprise_jueces_insert_authenticated" ON jornada_reprise_jueces FOR INSERT TO authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "jornada_reprise_jueces_update_authenticated" ON jornada_reprise_jueces;
CREATE POLICY "jornada_reprise_jueces_update_authenticated" ON jornada_reprise_jueces FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "jornada_reprise_jueces_delete_authenticated" ON jornada_reprise_jueces;
CREATE POLICY "jornada_reprise_jueces_delete_authenticated" ON jornada_reprise_jueces FOR DELETE TO authenticated USING (true);

DROP POLICY IF EXISTS "competencias_insert_authenticated" ON competencias;
CREATE POLICY "competencias_insert_authenticated" ON competencias FOR INSERT TO authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "competencias_update_authenticated" ON competencias;
CREATE POLICY "competencias_update_authenticated" ON competencias FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "competencias_delete_authenticated" ON competencias;
CREATE POLICY "competencias_delete_authenticated" ON competencias FOR DELETE TO authenticated USING (true);
