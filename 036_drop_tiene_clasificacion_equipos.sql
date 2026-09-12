-- 036_drop_tiene_clasificacion_equipos.sql
-- Elimina la columna obsoleta (ahora es automatico por la vista)

ALTER TABLE pruebas DROP COLUMN IF EXISTS tiene_clasificacion_equipos;

-- Verificacion
SELECT column_name FROM information_schema.columns 
WHERE table_schema = 'public' AND table_name = 'pruebas' 
ORDER BY ordinal_position;