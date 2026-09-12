-- ============================================
-- SEED: PERFILES DE USUARIO
-- ============================================
-- IMPORTANTE: Este script solo inserta en `profiles`.
-- Los usuarios en `auth.users` deben existir previamente.
-- Si no existen, créalos desde el panel de Supabase -> Authentication -> Users.
-- ============================================

-- Limpiar perfiles huerfanos (los que no existen en auth.users)
DELETE FROM profiles
WHERE id NOT IN (
  SELECT id FROM auth.users
);

-- Admin principal
INSERT INTO profiles (id, email, nombre, rol)
SELECT 
  au.id,
  au.email,
  'Victor Ramos',
  'admin'
FROM auth.users au
WHERE au.email = 'vramosr1986@gmail.com'
ON CONFLICT (id) DO UPDATE SET
  email = EXCLUDED.email,
  nombre = EXCLUDED.nombre,
  rol = EXCLUDED.rol;

-- Jueces
INSERT INTO profiles (id, email, nombre, rol)
SELECT 
  au.id,
  au.email,
  CASE 
    WHEN au.email = 'juez1@test.com' THEN 'Ana Garcia'
    WHEN au.email = 'juez2@test.com' THEN 'Luis Perez'
    WHEN au.email = 'juez3@test.com' THEN 'Carlos Ruiz'
    WHEN au.email = 'juez4@test.com' THEN 'Marta Lopez'
    WHEN au.email = 'juez5@test.com' THEN 'Pedro Sanchez'
    ELSE au.email
  END,
  'juez'
FROM auth.users au
WHERE au.email IN (
  'juez1@test.com',
  'juez2@test.com',
  'juez3@test.com',
  'juez4@test.com',
  'juez5@test.com'
)
ON CONFLICT (id) DO UPDATE SET
  email = EXCLUDED.email,
  nombre = EXCLUDED.nombre,
  rol = EXCLUDED.rol;

-- Verificar
SELECT email, nombre, rol FROM profiles ORDER BY rol, email;
