-- 021_vista_categorias_separadas.sql
-- Vista con categoria de jinete y de caballo SEPARADAS para filtrar

DROP VIEW IF EXISTS v_binomios_categorias;

CREATE OR REPLACE VIEW v_binomios_categorias AS
SELECT
  b.id AS binomio_id,
  b.nombre_jinete,
  b.nombre_caballo,
  b.fecha_nacimiento_jinete,
  b.anio_nacimiento_caballo,
  EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM b.fecha_nacimiento_jinete) AS edad_jinete,
  EXTRACT(YEAR FROM CURRENT_DATE) - b.anio_nacimiento_caballo AS edad_caballo,
  calcular_categoria_jinete(b.fecha_nacimiento_jinete) AS categoria_jinete,
  calcular_categoria_caballo(b.anio_nacimiento_caballo) AS categoria_caballo,
  COALESCE(
    calcular_categoria_caballo(b.anio_nacimiento_caballo),
    calcular_categoria_jinete(b.fecha_nacimiento_jinete)
  ) AS categoria_principal
FROM binomios b
ORDER BY b.nombre_jinete;

-- Verificacion
SELECT
  nombre_jinete,
  categoria_jinete,
  categoria_caballo,
  categoria_principal
FROM v_binomios_categorias
ORDER BY nombre_jinete;