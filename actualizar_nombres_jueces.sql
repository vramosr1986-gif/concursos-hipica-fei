UPDATE profiles
SET nombre = CASE email
  WHEN 'juez1@test.com' THEN 'Ana García'
  WHEN 'juez2@test.com' THEN 'Luis Pérez'
  WHEN 'juez3@test.com' THEN 'Carlos Ruiz'
  WHEN 'juez4@test.com' THEN 'Marta López'
  WHEN 'juez5@test.com' THEN 'Pedro Sánchez'
  ELSE nombre
END
WHERE rol = 'juez';

SELECT email, nombre, rol FROM profiles WHERE rol = 'juez' ORDER BY email;