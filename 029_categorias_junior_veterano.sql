-- 029_categorias_junior_veterano.sql
-- Anade las categorias JUNIOR y VETERANO a la tabla categorias_edad

INSERT INTO categorias_edad (codigo, nombre, tipo, orden) VALUES
  ('JUNIOR', 'Juniors (Juveniles 1*)', 'EDAD', 6),
  ('VETERANO', 'Veteranos (+45 anos)', 'EDAD', 15)
ON CONFLICT (codigo) DO NOTHING;

-- Verificacion: todas las categorias ordenadas
SELECT id, codigo, nombre, tipo, orden FROM categorias_edad ORDER BY orden;