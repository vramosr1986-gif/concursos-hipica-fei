-- 1. Renombrar columna
ALTER TABLE puntuaciones RENAME COLUMN competencia_id TO participacion_id;

-- 2. Cambiar FK
ALTER TABLE puntuaciones DROP CONSTRAINT IF EXISTS puntuaciones_competencia_id_fkey;
ALTER TABLE puntuaciones ADD CONSTRAINT puntuaciones_participacion_id_fkey
  FOREIGN KEY (participacion_id) REFERENCES participaciones(id) ON DELETE CASCADE;

-- 3. Añadir políticas UPDATE y DELETE
DROP POLICY IF EXISTS "Jueces can update own puntuaciones" ON puntuaciones;
CREATE POLICY "Jueces can update own puntuaciones" ON puntuaciones
FOR UPDATE TO authenticated
USING (juez_id = auth.uid() OR EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'))
WITH CHECK (juez_id = auth.uid() OR EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'));

DROP POLICY IF EXISTS "Admins can delete puntuaciones" ON puntuaciones;
CREATE POLICY "Admins can delete puntuaciones" ON puntuaciones
FOR DELETE TO authenticated
USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND rol = 'admin'));
