DROP POLICY IF EXISTS "profiles_public_read" ON profiles;

CREATE POLICY "profiles_public_read"
ON profiles
FOR SELECT
TO public
USING (true);

SELECT policyname, cmd, roles, qual
FROM pg_policies
WHERE tablename = 'profiles';