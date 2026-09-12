-- 013_limpiar_politicas_viejas_puntuaciones.sql
-- Eliminar politicas viejas que bloquean el INSERT

-- Politicas a eliminar (viejas, no coinciden con el modelo nuevo)
DROP POLICY IF EXISTS "Judges can insert puntuaciones" ON puntuaciones;
DROP POLICY IF EXISTS "Admins can delete puntuaciones" ON puntuaciones;
DROP POLICY IF EXISTS "Jueces can update own puntuaciones" ON puntuaciones;
DROP POLICY IF EXISTS "Users can view puntuaciones" ON puntuaciones;

-- Verificar politicas restantes
SELECT policyname, cmd, roles::text
FROM pg_policies
WHERE tablename = 'puntuaciones'
ORDER BY cmd, policyname;