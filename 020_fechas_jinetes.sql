-- 020_fechas_jinetes.sql
-- Rellena las fechas de nacimiento de los 12 jinetes (datos de prueba)

UPDATE binomios SET fecha_nacimiento_jinete = '2014-03-15' WHERE nombre_jinete = 'Magui';
UPDATE binomios SET fecha_nacimiento_jinete = '2012-06-20' WHERE nombre_jinete = 'Juan';
UPDATE binomios SET fecha_nacimiento_jinete = '2010-05-10' WHERE nombre_jinete = 'Maria';
UPDATE binomios SET fecha_nacimiento_jinete = '2008-09-22' WHERE nombre_jinete = 'Pedro';
UPDATE binomios SET fecha_nacimiento_jinete = '2005-11-08' WHERE nombre_jinete = 'Sofia';
UPDATE binomios SET fecha_nacimiento_jinete = '2003-04-12' WHERE nombre_jinete = 'Diego';
UPDATE binomios SET fecha_nacimiento_jinete = '2000-07-30' WHERE nombre_jinete = 'Lucia';
UPDATE binomios SET fecha_nacimiento_jinete = '2013-02-14' WHERE nombre_jinete = 'Andres';
UPDATE binomios SET fecha_nacimiento_jinete = '2006-12-05' WHERE nombre_jinete = 'Elena';
UPDATE binomios SET fecha_nacimiento_jinete = '2011-08-17' WHERE nombre_jinete = 'Pablo';
UPDATE binomios SET fecha_nacimiento_jinete = '2009-10-03' WHERE nombre_jinete = 'Carmen';
UPDATE binomios SET fecha_nacimiento_jinete = '2001-01-25' WHERE nombre_jinete = 'Raul';

-- Verificacion
SELECT
  nombre_jinete,
  fecha_nacimiento_jinete,
  EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM fecha_nacimiento_jinete) AS edad,
  calcular_categoria_jinete(fecha_nacimiento_jinete) AS categoria_jinete,
  calcular_categoria_caballo(anio_nacimiento_caballo) AS categoria_caballo,
  COALESCE(
    calcular_categoria_caballo(anio_nacimiento_caballo),
    calcular_categoria_jinete(fecha_nacimiento_jinete)
  ) AS categoria_sugerida
FROM binomios
ORDER BY nombre_jinete;