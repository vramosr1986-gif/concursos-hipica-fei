-- Eliminar políticas viejas si existen
DROP POLICY IF EXISTS "jueces_select_staff" ON jueces;
DROP POLICY IF EXISTS "jueces_insert_staff" ON jueces;
DROP POLICY IF EXISTS "jueces_update_staff" ON jueces;
DROP POLICY IF EXISTS "jueces_delete_staff" ON jueces;
DROP POLICY IF EXISTS "jueces_select_authenticated" ON jueces;
DROP POLICY IF EXISTS "jueces_insert_authenticated" ON jueces;
DROP POLICY IF EXISTS "jueces_update_authenticated" ON jueces;
DROP POLICY IF EXISTS "jueces_delete_authenticated" ON jueces;

-- SELECT: cualquier usuario autenticado puede leer
CREATE POLICY "jueces_select_authenticated" ON jueces
FOR SELECT TO authenticated USING (true);

-- INSERT: cualquier usuario autenticado puede crear
CREATE POLICY "jueces_insert_authenticated" ON jueces
FOR INSERT TO authenticated WITH CHECK (true);

-- UPDATE: cualquier usuario autenticado puede editar
CREATE POLICY "jueces_update_authenticated" ON jueces
FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

-- DELETE: cualquier usuario autenticado puede borrar
CREATE POLICY "jueces_delete_authenticated" ON jueces
FOR DELETE TO authenticated USING (true);
