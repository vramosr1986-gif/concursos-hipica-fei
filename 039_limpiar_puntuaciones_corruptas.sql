-- 039_limpiar_puntuaciones_corruptas.sql
-- Borra las puntuaciones con prueba_juez_id NULL o nota NULL

-- 1. Ver cuantas hay antes
SELECT COUNT(*) AS corruptas_antes
FROM puntuaciones
WHERE prueba_juez_id IS NULL OR nota IS NULL;

-- 2. Borrar
DELETE FROM puntuaciones
WHERE prueba_juez_id IS NULL OR nota IS NULL;

-- 3. Ver cuantas quedan
SELECT COUNT(*) AS total_restantes FROM puntuaciones;

-- 4. Ver por letra
SELECT letra_juez, COUNT(*) AS total
FROM puntuaciones
GROUP BY letra_juez
ORDER BY letra_juez;