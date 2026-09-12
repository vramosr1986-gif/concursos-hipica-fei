-- ============================================
-- POLITICAS RLS
-- ============================================

-- ============================================
-- PROFILES
-- ============================================
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "profiles_select_own_or_admin" ON profiles;
CREATE POLICY "profiles_select_own_or_admin" ON profiles
FOR SELECT TO authenticated
USING (id = auth.uid() OR is_admin());

DROP POLICY IF EXISTS "profiles_insert_admin" ON profiles;
CREATE POLICY "profiles_insert_admin" ON profiles
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "profiles_update_admin" ON profiles;
CREATE POLICY "profiles_update_admin" ON profiles
FOR UPDATE TO authenticated
USING (is_admin())
WITH CHECK (is_admin());

DROP POLICY IF EXISTS "profiles_delete_admin" ON profiles;
CREATE POLICY "profiles_delete_admin" ON profiles
FOR DELETE TO authenticated USING (is_admin());

-- ============================================
-- REPRISES (lectura pública, escritura staff)
-- ============================================
ALTER TABLE reprises ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "reprises_select_public" ON reprises;
CREATE POLICY "reprises_select_public" ON reprises
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "reprises_insert_staff" ON reprises;
CREATE POLICY "reprises_insert_staff" ON reprises
FOR INSERT TO authenticated WITH CHECK (is_staff());

DROP POLICY IF EXISTS "reprises_update_staff" ON reprises;
CREATE POLICY "reprises_update_staff" ON reprises
FOR UPDATE TO authenticated USING (is_staff()) WITH CHECK (is_staff());

DROP POLICY IF EXISTS "reprises_delete_staff" ON reprises;
CREATE POLICY "reprises_delete_staff" ON reprises
FOR DELETE TO authenticated USING (is_staff());

-- ============================================
-- EJERCICIOS_REPRISE (lectura pública, escritura staff)
-- ============================================
ALTER TABLE ejercicios_reprise ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "ejercicios_select_public" ON ejercicios_reprise;
CREATE POLICY "ejercicios_select_public" ON ejercicios_reprise
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "ejercicios_insert_staff" ON ejercicios_reprise;
CREATE POLICY "ejercicios_insert_staff" ON ejercicios_reprise
FOR INSERT TO authenticated WITH CHECK (is_staff());

DROP POLICY IF EXISTS "ejercicios_update_staff" ON ejercicios_reprise;
CREATE POLICY "ejercicios_update_staff" ON ejercicios_reprise
FOR UPDATE TO authenticated USING (is_staff()) WITH CHECK (is_staff());

DROP POLICY IF EXISTS "ejercicios_delete_staff" ON ejercicios_reprise;
CREATE POLICY "ejercicios_delete_staff" ON ejercicios_reprise
FOR DELETE TO authenticated USING (is_staff());

-- ============================================
-- BINOMIOS (lectura pública, escritura staff)
-- ============================================
ALTER TABLE binomios ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "binomios_select_public" ON binomios;
CREATE POLICY "binomios_select_public" ON binomios
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "binomios_insert_staff" ON binomios;
CREATE POLICY "binomios_insert_staff" ON binomios
FOR INSERT TO authenticated WITH CHECK (is_staff());

DROP POLICY IF EXISTS "binomios_update_staff" ON binomios;
CREATE POLICY "binomios_update_staff" ON binomios
FOR UPDATE TO authenticated USING (is_staff()) WITH CHECK (is_staff());

DROP POLICY IF EXISTS "binomios_delete_staff" ON binomios;
CREATE POLICY "binomios_delete_staff" ON binomios
FOR DELETE TO authenticated USING (is_staff());

-- ============================================
-- CONCURSOS (lectura pública, escritura staff)
-- ============================================
ALTER TABLE concursos ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "concursos_select_public" ON concursos;
CREATE POLICY "concursos_select_public" ON concursos
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "concursos_insert_staff" ON concursos;
CREATE POLICY "concursos_insert_staff" ON concursos
FOR INSERT TO authenticated WITH CHECK (is_staff());

DROP POLICY IF EXISTS "concursos_update_staff" ON concursos;
CREATE POLICY "concursos_update_staff" ON concursos
FOR UPDATE TO authenticated USING (is_staff()) WITH CHECK (is_staff());

DROP POLICY IF EXISTS "concursos_delete_staff" ON concursos;
CREATE POLICY "concursos_delete_staff" ON concursos
FOR DELETE TO authenticated USING (is_staff());

-- ============================================
-- INSCRIPCIONES (lectura pública, escritura staff)
-- ============================================
ALTER TABLE inscripciones ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "inscripciones_select_public" ON inscripciones;
CREATE POLICY "inscripciones_select_public" ON inscripciones
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "inscripciones_insert_staff" ON inscripciones;
CREATE POLICY "inscripciones_insert_staff" ON inscripciones
FOR INSERT TO authenticated WITH CHECK (is_staff());

DROP POLICY IF EXISTS "inscripciones_update_staff" ON inscripciones;
CREATE POLICY "inscripciones_update_staff" ON inscripciones
FOR UPDATE TO authenticated USING (is_staff()) WITH CHECK (is_staff());

DROP POLICY IF EXISTS "inscripciones_delete_staff" ON inscripciones;
CREATE POLICY "inscripciones_delete_staff" ON inscripciones
FOR DELETE TO authenticated USING (is_staff());

-- ============================================
-- PRUEBAS (lectura pública, escritura staff)
-- ============================================
ALTER TABLE pruebas ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "pruebas_select_public" ON pruebas;
CREATE POLICY "pruebas_select_public" ON pruebas
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "pruebas_insert_staff" ON pruebas;
CREATE POLICY "pruebas_insert_staff" ON pruebas
FOR INSERT TO authenticated WITH CHECK (is_staff());

DROP POLICY IF EXISTS "pruebas_update_staff" ON pruebas;
CREATE POLICY "pruebas_update_staff" ON pruebas
FOR UPDATE TO authenticated USING (is_staff()) WITH CHECK (is_staff());

DROP POLICY IF EXISTS "pruebas_delete_staff" ON pruebas;
CREATE POLICY "pruebas_delete_staff" ON pruebas
FOR DELETE TO authenticated USING (is_staff());

-- ============================================
-- PRUEBA_JUECES (lectura pública, escritura staff)
-- ============================================
ALTER TABLE prueba_jueces ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "prueba_jueces_select_public" ON prueba_jueces;
CREATE POLICY "prueba_jueces_select_public" ON prueba_jueces
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "prueba_jueces_insert_staff" ON prueba_jueces;
CREATE POLICY "prueba_jueces_insert_staff" ON prueba_jueces
FOR INSERT TO authenticated WITH CHECK (is_staff());

DROP POLICY IF EXISTS "prueba_jueces_update_staff" ON prueba_jueces;
CREATE POLICY "prueba_jueces_update_staff" ON prueba_jueces
FOR UPDATE TO authenticated USING (is_staff()) WITH CHECK (is_staff());

DROP POLICY IF EXISTS "prueba_jueces_delete_staff" ON prueba_jueces;
CREATE POLICY "prueba_jueces_delete_staff" ON prueba_jueces
FOR DELETE TO authenticated USING (is_staff());

-- ============================================
-- PARTICIPACIONES (lectura pública, escritura staff)
-- ============================================
ALTER TABLE participaciones ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "participaciones_select_public" ON participaciones;
CREATE POLICY "participaciones_select_public" ON participaciones
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "participaciones_insert_staff" ON participaciones;
CREATE POLICY "participaciones_insert_staff" ON participaciones
FOR INSERT TO authenticated WITH CHECK (is_staff());

DROP POLICY IF EXISTS "participaciones_update_staff" ON participaciones;
CREATE POLICY "participaciones_update_staff" ON participaciones
FOR UPDATE TO authenticated USING (is_staff()) WITH CHECK (is_staff());

DROP POLICY IF EXISTS "participaciones_delete_staff" ON participaciones;
CREATE POLICY "participaciones_delete_staff" ON participaciones
FOR DELETE TO authenticated USING (is_staff());

-- ============================================
-- PUNTUACIONES (lectura pública, escritura jueces)
-- ============================================
ALTER TABLE puntuaciones ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "puntuaciones_select_public" ON puntuaciones;
CREATE POLICY "puntuaciones_select_public" ON puntuaciones
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "puntuaciones_insert_staff" ON puntuaciones;
CREATE POLICY "puntuaciones_insert_staff" ON puntuaciones
FOR INSERT TO authenticated WITH CHECK (is_staff());

DROP POLICY IF EXISTS "puntuaciones_update_own_or_admin" ON puntuaciones;
CREATE POLICY "puntuaciones_update_own_or_admin" ON puntuaciones
FOR UPDATE TO authenticated
USING (juez_id = auth.uid() OR is_admin())
WITH CHECK (juez_id = auth.uid() OR is_admin());

DROP POLICY IF EXISTS "puntuaciones_delete_admin" ON puntuaciones;
CREATE POLICY "puntuaciones_delete_admin" ON puntuaciones
FOR DELETE TO authenticated USING (is_admin());

SELECT 'Politicas RLS creadas correctamente' AS resultado;
