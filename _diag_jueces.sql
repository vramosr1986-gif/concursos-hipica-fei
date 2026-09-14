-- ¿Qué hay en prueba_jueces? ¿A qué juez_id apuntan?
SELECT pj.id, pj.prueba_id, pj.juez_id, pj.letra,
       j.nombre AS juez_nombre
FROM prueba_jueces pj
LEFT JOIN jueces j ON j.id = pj.juez_id
LIMIT 20;

-- ¿Existe la tabla jueces? ¿O es una vista?
SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'public' AND table_name = 'jueces';

-- Columnas de la tabla jueces
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'jueces'
ORDER BY ordinal_position;

-- ¿Hay otra tabla con jueces? (por si se llama distinto)
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND (table_name ILIKE '%juez%' OR table_name ILIKE '%judge%' OR table_name ILIKE '%staff%')
ORDER BY table_name;
