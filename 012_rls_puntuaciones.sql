-- 012_rls_puntuaciones.sql
-- Politicas RLS para el modelo nuevo de puntuaciones

-- 1. Quitar politicas viejas
DROP POLICY IF EXISTS "puntuaciones_insert" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_update" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_delete" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_select" ON puntuaciones;

-- 2. Asegurar que RLS esta activado
ALTER TABLE puntuaciones ENABLE ROW LEVEL SECURITY;

-- 3. SELECT: cualquier usuario autenticado puede leer
CREATE POLICY "puntuaciones_select_authenticated" ON puntuaciones
FOR SELECT TO authenticated USING (true);

-- 4. INSERT: un juez solo puede insertar si la prueba_juez_id le pertenece
CREATE POLICY "puntuaciones_insert_juez" ON puntuaciones
FOR INSERT TO authenticated
WITH CHECK (
  EXISTS (
    SELECT 1 FROM prueba_jueces pj
    WHERE pj.id = puntuaciones.prueba_juez_id
      AND pj.juez_id = auth.uid()
  )
  OR is_admin()
);

-- 5. UPDATE: mismo criterio que INSERT
CREATE POLICY "puntuaciones_update_juez" ON puntuaciones
FOR UPDATE TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM prueba_jueces pj
    WHERE pj.id = puntuaciones.prueba_juez_id
      AND pj.juez_id = auth.uid()
  )
  OR is_admin()
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM prueba_jueces pj
    WHERE pj.id = puntuaciones.prueba_juez_id
      AND pj.juez_id = auth.uid()
  )
  OR is_admin()
);

-- 6. DELETE: solo admin
CREATE POLICY "puntuaciones_delete_admin" ON puntuaciones
FOR DELETE TO authenticated
USING (is_admin());

-- 7. Verificacion
SELECT policyname, cmd, roles::text
FROM pg_policies
WHERE tablename = 'puntuaciones'
ORDER BY cmd, policyname;