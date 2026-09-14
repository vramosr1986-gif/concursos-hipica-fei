-- Jornadas
SELECT column_name, data_type FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'jornadas'
ORDER BY ordinal_position;

-- Concursos
SELECT column_name, data_type FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'concursos'
ORDER BY ordinal_position;

-- Tablas que podrían contener nivel / tipo / categoría
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
  AND (table_name ILIKE '%nivel%'
    OR table_name ILIKE '%tipo%'
    OR table_name ILIKE '%categoria%')
ORDER BY table_name;
