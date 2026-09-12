DROP POLICY IF EXISTS "binomios_select_authenticated" ON binomios;
DROP POLICY IF EXISTS "binomios_insert_authenticated" ON binomios;
DROP POLICY IF EXISTS "binomios_update_authenticated" ON binomios;
DROP POLICY IF EXISTS "binomios_delete_authenticated" ON binomios;

CREATE POLICY "binomios_select_authenticated" ON binomios
FOR SELECT TO authenticated USING (true);

CREATE POLICY "binomios_insert_authenticated" ON binomios
FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "binomios_update_authenticated" ON binomios
FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "binomios_delete_authenticated" ON binomios
FOR DELETE TO authenticated USING (true);
