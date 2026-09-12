-- 016_categorias_automaticas.sql
-- Anade fecha_nacimiento a profiles y anio_nacimiento_caballo a binomios
-- Ademas crea funciones para calcular la categoria automaticamente

-- ============================================================
-- 1. ANADIR CAMPOS
-- ============================================================
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS fecha_nacimiento date;
ALTER TABLE binomios ADD COLUMN IF NOT EXISTS anio_nacimiento_caballo integer;

-- Migrar los datos existentes de binomios (columna anio -> anio_nacimiento_caballo)
UPDATE binomios 
SET anio_nacimiento_caballo = anio 
WHERE anio_nacimiento_caballo IS NULL AND anio IS NOT NULL;

-- Indices
CREATE INDEX IF NOT EXISTS idx_binomios_anio_nac ON binomios(anio_nacimiento_caballo);

-- ============================================================
-- 2. FUNCION: Calcular categoria del jinete por edad
-- Reglas RFHE (año en curso):
--   <= 12 años  -> ALEVIN
--   <= 14 años  -> INFANTIL
--   <= 18 años  -> JUVENIL
--   <= 21 años  -> JOVEN_JINETE
--   >  21 años  -> ADULTO
-- ============================================================
CREATE OR REPLACE FUNCTION calcular_categoria_jinete(fecha_nac date)
RETURNS text
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  edad int;
BEGIN
  IF fecha_nac IS NULL THEN
    RETURN NULL;
  END IF;
  
  edad := EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM fecha_nac);
  
  IF edad <= 12 THEN RETURN 'ALEVIN';
  ELSIF edad <= 14 THEN RETURN 'INFANTIL';
  ELSIF edad <= 18 THEN RETURN 'JUVENIL';
  ELSIF edad <= 21 THEN RETURN 'JOVEN_JINETE';
  ELSE RETURN 'ADULTO';
  END IF;
END;
$$;

-- ============================================================
-- 3. FUNCION: Calcular categoria del caballo por edad
-- Reglas RFHE:
--   4 años -> CJ4
--   5 años -> CJ5
--   6 años -> CJ6
--   7 años -> CJ7
--   8-10 años -> CJ8_10
--   resto -> NULL (no es caballo joven)
-- ============================================================
CREATE OR REPLACE FUNCTION calcular_categoria_caballo(anio_nac int)
RETURNS text
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  edad int;
BEGIN
  IF anio_nac IS NULL THEN
    RETURN NULL;
  END IF;
  
  edad := EXTRACT(YEAR FROM CURRENT_DATE) - anio_nac;
  
  IF edad = 4 THEN RETURN 'CJ4';
  ELSIF edad = 5 THEN RETURN 'CJ5';
  ELSIF edad = 6 THEN RETURN 'CJ6';
  ELSIF edad = 7 THEN RETURN 'CJ7';
  ELSIF edad BETWEEN 8 AND 10 THEN RETURN 'CJ8_10';
  ELSE RETURN NULL;
  END IF;
END;
$$;

-- ============================================================
-- 4. FUNCION: Calcular categoria de la INSCRIPCION
-- Decide si es categoria por jinete o por caballo joven
-- (los caballos jovenes tienen prioridad)
-- ============================================================
CREATE OR REPLACE FUNCTION calcular_categoria_inscripcion(
  p_binomio_id uuid
)
RETURNS text
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
  v_anio_caballo int;
  v_categoria_caballo text;
BEGIN
  -- Leer el año de nacimiento del caballo
  SELECT anio_nacimiento_caballo INTO v_anio_caballo
  FROM binomios
  WHERE id = p_binomio_id;
  
  -- Calcular categoria del caballo
  v_categoria_caballo := calcular_categoria_caballo(v_anio_caballo);
  
  -- Si es caballo joven, devolver su categoria
  IF v_categoria_caballo IS NOT NULL THEN
    RETURN v_categoria_caballo;
  END IF;
  
  -- Si no, devolver NULL (el jinete tendrá que elegir la categoria)
  RETURN NULL;
END;
$$;

-- ============================================================
-- 5. VISTA: Estado de los binomios con su categoria actual
-- ============================================================
CREATE OR REPLACE VIEW v_binomios_categorias AS
SELECT
  b.id AS binomio_id,
  b.nombre_jinete,
  b.nombre_caballo,
  b.anio_nacimiento_caballo,
  EXTRACT(YEAR FROM CURRENT_DATE) - b.anio_nacimiento_caballo AS edad_caballo,
  calcular_categoria_caballo(b.anio_nacimiento_caballo) AS categoria_caballo,
  (SELECT calcular_categoria_jinete(p.fecha_nacimiento)
   FROM profiles p
   WHERE p.id = b.user_id_jinete) AS categoria_jinete
FROM binomios b;

-- ============================================================
-- 6. VERIFICACION
-- ============================================================
SELECT 'profiles con fecha_nacimiento' AS metrica, COUNT(*) AS total
FROM profiles WHERE fecha_nacimiento IS NOT NULL
UNION ALL
SELECT 'binomios con anio_nacimiento_caballo', COUNT(*)
FROM binomios WHERE anio_nacimiento_caballo IS NOT NULL;

-- Probar las funciones con datos de ejemplo
SELECT 
  'Jinete nacido 2015' AS caso,
  calcular_categoria_jinete('2015-06-15'::date) AS categoria
UNION ALL
SELECT 'Jinete nacido 2010', calcular_categoria_jinete('2010-06-15'::date)
UNION ALL
SELECT 'Jinete nacido 2005', calcular_categoria_jinete('2005-06-15'::date)
UNION ALL
SELECT 'Jinete nacido 2000', calcular_categoria_jinete('2000-06-15'::date)
UNION ALL
SELECT 'Caballo nacido 2021 (4 años)', calcular_categoria_caballo(2021)
UNION ALL
SELECT 'Caballo nacido 2018 (7 años)', calcular_categoria_caballo(2018)
UNION ALL
SELECT 'Caballo nacido 2015 (10 años)', calcular_categoria_caballo(2015)
UNION ALL
SELECT 'Caballo nacido 2010 (15 años)', calcular_categoria_caballo(2010);