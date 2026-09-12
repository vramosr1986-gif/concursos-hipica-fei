-- ============================================
-- PERMISOS (GRANTS)
-- ============================================

-- Dar uso del esquema public a los 3 roles
GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;

-- Dar permisos a todas las tablas
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated, service_role;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO anon, authenticated, service_role;

-- Permisos automaticos para futuras tablas
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
  GRANT ALL ON TABLES TO anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public 
  GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA public 
  GRANT ALL ON FUNCTIONS TO anon, authenticated, service_role;

-- Permisos explicitos en funciones (para que anon pueda llamarlas si hace falta)
GRANT EXECUTE ON FUNCTION is_admin() TO anon, authenticated, service_role;
GRANT EXECUTE ON FUNCTION is_staff() TO anon, authenticated, service_role;

SELECT 'Permisos otorgados correctamente' AS resultado;
