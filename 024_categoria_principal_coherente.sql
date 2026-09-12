-- 024_categoria_principal_coherente.sql
-- Cambia la logica de categoria_principal:
--   - Caballo joven (4-10) -> categoria del caballo
--   - Caballo adulto (11+) -> categoria del jinete
--   - Si no hay jinete con fecha -> fallback a CABALLO_ADULTO

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
  CASE
    -- Caballo joven: manda el caballo
    WHEN calcular_categoria_caballo(b.anio_nacimiento_caballo) IN ('CJ4','CJ5','CJ6','CJ7','CJ8_10')
      THEN calcular_categoria_caballo(b.anio_nacimiento_caballo)
    -- Caballo adulto con jinete: manda el jinete
    WHEN calcular_categoria_jinete(b.fecha_nacimiento_jinete) IS NOT NULL
      THEN calcular_categoria_jinete(b.fecha_nacimiento_jinete)
    -- Caballo adulto sin jinete: CABALLO_ADULTO
    ELSE calcular_categoria_caballo(b.anio_nacimiento_caballo)
  END::text AS categoria_principal
FROM binomios b
ORDER BY b.nombre_jinete;

-- Verificacion
SELECT
  nombre_jinete,
  nombre_caballo,
  edad_jinete,
  categoria_jinete,
  edad_caballo,
  categoria_caballo,
  categoria_principal
FROM v_binomios_categorias
ORDER BY nombre_jinete;