-- Rellenar con nombre genérico los que estén vacíos
UPDATE profiles
SET nombre = 'Juez ' || SUBSTRING(email, 1, POSITION('@' IN email) - 1)
WHERE rol = 'juez'
  AND (nombre IS NULL OR nombre = '');

-- Ver todos los jueces
SELECT email, nombre, rol FROM profiles WHERE rol = 'juez' ORDER BY email;