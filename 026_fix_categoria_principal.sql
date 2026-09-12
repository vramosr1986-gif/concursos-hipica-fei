-- 026_fix_categoria_principal.sql
-- La categoria principal es SIEMPRE la del jinete (no la del caballo joven)

DROP VIEW IF EXISTS v_binomios_categorias;

CREATE OR REPLACE VIEW v_binomios_categorias AS
SELECT
  b.id::text AS binomio_id,
  b.nombre_jinete::text AS nombre_jinete,
  b.nombre_caballo::text AS nombre_caballo,
  b.fecha_nacimiento_jinete::text AS fecha_nacimiento_jinete,
  b.anio_nacimiento_caballo::int AS anio_nacimiento_caballo,
  (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM b.fecha_nacimiento_jinete))::int AS edad_jinete,
  (EXTRACT(YEAR FROM CURRENT_DATE) - b.anio_nacimiento_caballo)::int AS edad_caballo,
  calcular_categoria_jinete(b.fecha_nacimiento_jinete)::text AS categoria_jinete,
  calcular_categoria_caballo(b.anio_nacimiento_caballo)::text AS categoria_caballo,
  -- La categoria principal es SIEMPRE la del jinete
  CASE
    WHEN calcular_categoria_jinete(b.fecha_nacimiento_jinete) IS NOT NULL
      THEN calcular_categoria_jinete(b.fecha_nacimiento_jinete)
    ELSE 'ADULTO'
  END::text AS categoria_principal
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