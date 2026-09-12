-- 016b_fix_vista_binomios.sql
-- Rehace la vista sin la parte del jinete (que no existe todavia)

DROP VIEW IF EXISTS v_binomios_categorias;

CREATE OR REPLACE VIEW v_binomios_categorias AS
SELECT
  b.id AS binomio_id,
  b.nombre_jinete,
  b.nombre_caballo,
  b.anio_nacimiento_caballo,
  EXTRACT(YEAR FROM CURRENT_DATE) - b.anio_nacimiento_caballo AS edad_caballo,
  calcular_categoria_caballo(b.anio_nacimiento_caballo) AS categoria_caballo
FROM binomios b;

-- Verificacion
SELECT * FROM v_binomios_categorias ORDER BY nombre_jinete LIMIT 12;