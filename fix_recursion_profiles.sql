-- Eliminar políticas viejas
DROP POLICY IF EXISTS "profiles_select_own_or_admin" ON profiles;
DROP POLICY IF EXISTS "profiles_select_staff" ON profiles;
DROP POLICY IF EXISTS "profiles_insert_admin" ON profiles;
DROP POLICY IF EXISTS "profiles_update_admin" ON profiles;
DROP POLICY IF EXISTS "profiles_update_own" ON profiles;
DROP POLICY IF EXISTS "profiles_delete_admin" ON profiles;

-- SELECT: cada usuario ve su perfil, admins ven todos (sin recursión)
CREATE POLICY "profiles_select_own_or_admin" ON profiles
FOR SELECT TO authenticated
USING (id = auth.uid() OR is_admin());

-- INSERT: solo admins
CREATE POLICY "profiles_insert_admin" ON profiles
FOR INSERT TO authenticated
WITH CHECK (is_admin());

-- UPDATE: solo admins (sin recursión)
CREATE POLICY "profiles_update_admin" ON profiles
FOR UPDATE TO authenticated
USING (is_admin())
WITH CHECK (is_admin());

-- DELETE: solo admins
CREATE POLICY "profiles_delete_admin" ON profiles
FOR DELETE TO authenticated
USING (is_admin());
