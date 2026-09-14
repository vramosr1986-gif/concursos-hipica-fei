-- ============================================================
-- Policies públicas de lectura para /resultados
-- Permite que CUALQUIERA (anon) lea las tablas del panel público
-- ============================================================

-- Concursos
DROP POLICY IF EXISTS "public_read_concursos" ON concursos;
CREATE POLICY "public_read_concursos" ON concursos
FOR SELECT TO public USING (true);

-- Jornadas
DROP POLICY IF EXISTS "public_read_jornadas" ON jornadas;
CREATE POLICY "public_read_jornadas" ON jornadas
FOR SELECT TO public USING (true);

-- Pruebas
DROP POLICY IF EXISTS "public_read_pruebas" ON pruebas;
CREATE POLICY "public_read_pruebas" ON pruebas
FOR SELECT TO public USING (true);

-- Prueba_jueces
DROP POLICY IF EXISTS "public_read_prueba_jueces" ON prueba_jueces;
CREATE POLICY "public_read_prueba_jueces" ON prueba_jueces
FOR SELECT TO public USING (true);

-- Reprises
DROP POLICY IF EXISTS "public_read_reprises" ON reprises;
CREATE POLICY "public_read_reprises" ON reprises
FOR SELECT TO public USING (true);

-- Ejercicios de reprise
DROP POLICY IF EXISTS "public_read_ejercicios_reprise" ON ejercicios_reprise;
CREATE POLICY "public_read_ejercicios_reprise" ON ejercicios_reprise
FOR SELECT TO public USING (true);

-- Binomios
DROP POLICY IF EXISTS "public_read_binomios" ON binomios;
CREATE POLICY "public_read_binomios" ON binomios
FOR SELECT TO public USING (true);

-- Inscripciones
DROP POLICY IF EXISTS "public_read_inscripciones" ON inscripciones;
CREATE POLICY "public_read_inscripciones" ON inscripciones
FOR SELECT TO public USING (true);

-- Participaciones
DROP POLICY IF EXISTS "public_read_participaciones" ON participaciones;
CREATE POLICY "public_read_participaciones" ON participaciones
FOR SELECT TO public USING (true);

-- Puntuaciones
DROP POLICY IF EXISTS "public_read_puntuaciones" ON puntuaciones;
CREATE POLICY "public_read_puntuaciones" ON puntuaciones
FOR SELECT TO public USING (true);

-- Equipos
DROP POLICY IF EXISTS "public_read_equipos" ON equipos;
CREATE POLICY "public_read_equipos" ON equipos
FOR SELECT TO public USING (true);

-- Miembros de equipos
DROP POLICY IF EXISTS "public_read_equipo_miembros" ON equipo_miembros;
CREATE POLICY "public_read_equipo_miembros" ON equipo_miembros
FOR SELECT TO public USING (true);

-- Profiles (solo lectura, para mostrar nombres de jueces)
DROP POLICY IF EXISTS "public_read_profiles" ON profiles;
CREATE POLICY "public_read_profiles" ON profiles
FOR SELECT TO public USING (true);

-- ============================================================
-- Verificar
-- ============================================================
SELECT tablename, policyname, cmd, roles
FROM pg_policies
WHERE schemaname = 'public'
  AND policyname LIKE 'public_read_%'
ORDER BY tablename;