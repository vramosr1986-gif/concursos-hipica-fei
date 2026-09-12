-- 018_vista_binomios_categorias.sql
DROP VIEW IF EXISTS v_binomios_categorias;

CREATE OR REPLACE VIEW v_binomios_categorias AS
SELECT
  b.id AS binomio_id,
  b.nombre_jinete,
  b.nombre_caballo,
  b.anio_nacimiento_caballo,
  EXTRACT(YEAR FROM CURRENT_DATE) - b.anio_nacimiento_caballo AS edad_caballo,
  calcular_categoria_caballo(b.anio_nacimiento_caballo) AS categoria_caballo
FROM binomios b
ORDER BY b.nombre_jinete;

-- Verificacion
SELECT * FROM v_binomios_categorias LIMIT 12;