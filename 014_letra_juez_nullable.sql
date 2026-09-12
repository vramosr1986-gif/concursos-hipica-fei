-- 014_letra_juez_nullable.sql
ALTER TABLE puntuaciones ALTER COLUMN letra_juez DROP NOT NULL;
SELECT column_name, is_nullable FROM information_schema.columns WHERE table_name = 'puntuaciones' AND column_name = 'letra_juez';