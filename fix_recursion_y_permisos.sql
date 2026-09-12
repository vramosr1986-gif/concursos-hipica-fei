CREATE OR REPLACE FUNCTION is_admin()
RETURNS boolean LANGUAGE sql SECURITY DEFINER STABLE AS $func$
  SELECT EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin');
$func$;

CREATE OR REPLACE FUNCTION is_staff()
RETURNS boolean LANGUAGE sql SECURITY DEFINER STABLE AS $func$
  SELECT EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol IN ('admin', 'juez'));
$func$;

GRANT EXECUTE ON FUNCTION is_admin() TO authenticated, anon, service_role;
GRANT EXECUTE ON FUNCTION is_staff() TO authenticated, anon, service_role;

DROP POLICY IF EXISTS "profiles_select_own_or_admin" ON profiles;
DROP POLICY IF EXISTS "profiles_insert_admin" ON profiles;
DROP POLICY IF EXISTS "profiles_update_admin" ON profiles;
DROP POLICY IF EXISTS "profiles_delete_admin" ON profiles;

CREATE POLICY "profiles_select_own_or_admin" ON profiles
FOR SELECT TO authenticated USING (id = auth.uid() OR is_admin());

CREATE POLICY "profiles_insert_admin" ON profiles
FOR INSERT TO authenticated WITH CHECK (is_admin());

CREATE POLICY "profiles_update_admin" ON profiles
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

CREATE POLICY "profiles_delete_admin" ON profiles
FOR DELETE TO authenticated USING (is_admin());
