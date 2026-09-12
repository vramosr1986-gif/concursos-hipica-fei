-- 022_vista_binomios_cast.sql
-- Recrea la vista con CAST explicitos para que PostgREST devuelva los tipos correctos

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
  COALESCE(
    calcular_categoria_caballo(b.anio_nacimiento_caballo),
    calcular_categoria_jinete(b.fecha_nacimiento_jinete)
  )::text AS categoria_principal
FROM binomios b
ORDER BY b.nombre_jinete;

-- Verificacion
SELECT * FROM v_binomios_categorias LIMIT 3;