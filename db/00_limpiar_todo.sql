-- ============================================
-- LIMPIAR TODA LA BASE DE DATOS
-- ============================================
-- Borra todas las tablas del esquema public
-- ADVERTENCIA: Esto elimina TODOS los datos
-- ============================================

-- Desactivar RLS temporalmente
ALTER TABLE IF EXISTS puntuaciones DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS participaciones DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS prueba_jueces DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS pruebas DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS inscripciones DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS binomios DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS concursos DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS profiles DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS ejercicios_reprise DISABLE ROW LEVEL SECURITY;
ALTER TABLE IF EXISTS reprises DISABLE ROW LEVEL SECURITY;

-- Borrar en orden inverso a las dependencias
DROP TABLE IF EXISTS puntuaciones CASCADE;
DROP TABLE IF EXISTS participaciones CASCADE;
DROP TABLE IF EXISTS prueba_jueces CASCADE;
DROP TABLE IF EXISTS pruebas CASCADE;
DROP TABLE IF EXISTS inscripciones CASCADE;
DROP TABLE IF EXISTS binomios CASCADE;
DROP TABLE IF EXISTS concursos CASCADE;
DROP TABLE IF EXISTS profiles CASCADE;
DROP TABLE IF EXISTS ejercicios_reprise CASCADE;
DROP TABLE IF EXISTS reprises CASCADE;

-- Tablas obsoletas (por si acaso)
DROP TABLE IF EXISTS competencias CASCADE;
DROP TABLE IF EXISTS jornada_reprise_jueces CASCADE;
DROP TABLE IF EXISTS jornada_reprises CASCADE;
DROP TABLE IF EXISTS jornadas CASCADE;
DROP TABLE IF EXISTS jueces CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Funciones obsoletas
DROP FUNCTION IF EXISTS is_admin() CASCADE;
DROP FUNCTION IF EXISTS is_staff() CASCADE;
DROP FUNCTION IF EXISTS get_jueces_con_email() CASCADE;

SELECT 'Base de datos limpiada' AS resultado;
