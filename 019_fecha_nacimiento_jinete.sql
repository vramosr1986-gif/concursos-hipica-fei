-- 019_fecha_nacimiento_jinete.sql
-- Anade fecha de nacimiento del jinete al catalogo de binomios

-- ============================================================
-- 1. ANADIR COLUMNA
-- ============================================================
ALTER TABLE binomios ADD COLUMN IF NOT EXISTS fecha_nacimiento_jinete date;

CREATE INDEX IF NOT EXISTS idx_binomios_fecha_nac_jinete ON binomios(fecha_nacimiento_jinete);

-- ============================================================
-- 2. ACTUALIZAR LA VISTA CON LA CATEGORIA DEL JINETE
-- ============================================================
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
  ) AS categoria_sugerida
FROM binomios b
ORDER BY b.nombre_jinete;

-- ============================================================
-- 3. VERIFICACION
-- ============================================================
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_schema = 'public' AND table_name = 'binomios' 
ORDER BY ordinal_position;

SELECT * FROM v_binomios_categorias;