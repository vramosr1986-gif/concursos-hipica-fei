-- 017_funciones_categorias.sql
-- Crea las funciones de calculo de categoria

CREATE OR REPLACE FUNCTION calcular_categoria_jinete(fecha_nac date)
RETURNS text
LANGUAGE plpgsql
IMMUTABLE
AS $func$
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
$func$;

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
  ELSE RETURN NULL;
  END IF;
END;
$func$;

-- Verificacion
SELECT
  calcular_categoria_jinete('2015-06-15'::date) AS alevin,
  calcular_categoria_jinete('2010-06-15'::date) AS juvenil,
  calcular_categoria_jinete('2000-06-15'::date) AS adulto,
  calcular_categoria_caballo(2021) AS cj4,
  calcular_categoria_caballo(2018) AS cj7,
  calcular_categoria_caballo(2010) AS no_joven;