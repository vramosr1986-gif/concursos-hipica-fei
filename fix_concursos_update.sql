DROP POLICY IF EXISTS "Admins can update concursos" ON concursos;

CREATE POLICY "concursos_update_owner"
ON concursos
FOR UPDATE
TO authenticated
USING (created_by = auth.uid())
WITH CHECK (created_by = auth.uid());
