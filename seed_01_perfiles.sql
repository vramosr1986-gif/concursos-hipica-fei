-- Borrar perfiles huerfanos
DELETE FROM profiles
WHERE id NOT IN (
  '4445e7b3-c029-422f-a9fd-c68e3b601ce9',
  '7bacf290-e3f3-45e2-95a4-95925c4400eb',
  'ca5d48e6-4a56-4484-af07-1d7beee39d69',
  '2a735db4-684f-4241-82b4-d1a387a8602b',
  'ebd0b0f1-d5fb-4b66-9376-b48674f3d7d7',
  '7b96181b-afb3-4529-9af0-5adc722be7f9'
);

-- Crear perfiles
INSERT INTO profiles (id, email, nombre, rol) VALUES
  ('4445e7b3-c029-422f-a9fd-c68e3b601ce9', 'juez1@test.com', 'Ana Garcia', 'juez'),
  ('7bacf290-e3f3-45e2-95a4-95925c4400eb', 'juez2@test.com', 'Luis Perez', 'juez'),
  ('ca5d48e6-4a56-4484-af07-1d7beee39d69', 'juez3@test.com', 'Carlos Ruiz', 'juez'),
  ('2a735db4-684f-4241-82b4-d1a387a8602b', 'juez4@test.com', 'Marta Lopez', 'juez'),
  ('ebd0b0f1-d5fb-4b66-9376-b48674f3d7d7', 'juez5@test.com', 'Pedro Sanchez', 'juez'),
  ('7b96181b-afb3-4529-9af0-5adc722be7f9', 'vramosr1986@gmail.com', 'Victor Ramos', 'admin')
ON CONFLICT (id) DO UPDATE SET
  email = EXCLUDED.email,
  nombre = EXCLUDED.nombre,
  rol = EXCLUDED.rol;

-- Verificar
SELECT email, nombre, rol FROM profiles ORDER BY rol, email;
