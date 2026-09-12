-- Borrar FK antigua
ALTER TABLE puntuaciones DROP CONSTRAINT IF EXISTS puntuaciones_juez_id_fkey;

-- Añadir FK nueva apuntando a profiles
ALTER TABLE puntuaciones 
ADD CONSTRAINT puntuaciones_juez_id_fkey 
FOREIGN KEY (juez_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- Verificar
SELECT conname, pg_get_constraintdef(oid) AS definicion 
FROM pg_constraint 
WHERE conname = 'puntuaciones_juez_id_fkey';
