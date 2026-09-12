-- 023_categoria_caballo_adulto.sql
-- Anade categoria CABALLO_ADULTO para caballos de 11+ anos

-- 1. Actualizar la funcion
CREATE OR REPLACE FUNCTION calcular_categoria_caballo(anio_nac int)
RETURNS text
LANGUAGE plpgsql
IMMUTABLE
AS $func$
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
  ELSIF edad >= 11 THEN RETURN 'CABALLO_ADULTO';
  ELSE RETURN NULL;
  END IF;
END;
$func$;

-- 2. Verificacion
SELECT
  calcular_categoria_caballo(2022) AS edad_4,
  calcular_categoria_caballo(2019) AS edad_7,
  calcular_categoria_caballo(2017) AS edad_9,
  calcular_categoria_caballo(2015) AS edad_11,
  calcular_categoria_caballo(2013) AS edad_13;

-- 3. Ver la vista actualizada
SELECT nombre_jinete, nombre_caballo, edad_caballo, categoria_caballo, categoria_principal
FROM v_binomios_categorias
ORDER BY nombre_jinete;