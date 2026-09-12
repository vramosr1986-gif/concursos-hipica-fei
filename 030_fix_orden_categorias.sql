-- 030_fix_orden_categorias.sql
-- Corrige el orden de las categorias para que no haya empates

UPDATE categorias_edad SET orden = 1  WHERE codigo = 'ALEVIN';
UPDATE categorias_edad SET orden = 2  WHERE codigo = 'BENJAMIN';
UPDATE categorias_edad SET orden = 3  WHERE codigo = 'INFANTIL';
UPDATE categorias_edad SET orden = 4  WHERE codigo = 'JUVENIL_0';
UPDATE categorias_edad SET orden = 5  WHERE codigo = 'JUVENIL';
UPDATE categorias_edad SET orden = 6  WHERE codigo = 'JOVEN_JINETE';
UPDATE categorias_edad SET orden = 7  WHERE codigo = 'JUNIOR';
UPDATE categorias_edad SET orden = 8  WHERE codigo = 'ADULTO';
UPDATE categorias_edad SET orden = 9  WHERE codigo = 'PONI';
UPDATE categorias_edad SET orden = 10 WHERE codigo = 'RIDER';
UPDATE categorias_edad SET orden = 11 WHERE codigo = 'CJ4';
UPDATE categorias_edad SET orden = 12 WHERE codigo = 'CJ5';
UPDATE categorias_edad SET orden = 13 WHERE codigo = 'CJ6';
UPDATE categorias_edad SET orden = 14 WHERE codigo = 'CJ7';
UPDATE categorias_edad SET orden = 15 WHERE codigo = 'CJ8_10';
UPDATE categorias_edad SET orden = 16 WHERE codigo = 'VETERANO';

-- Verificacion
SELECT codigo, nombre, orden FROM categorias_edad ORDER BY orden;