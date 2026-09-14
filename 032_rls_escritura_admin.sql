-- =============================================
-- 032_rls_escritura_admin.sql
-- =============================================
-- Refuerza el control de acceso en todas las
-- tablas de gestión (escritura solo admin).
-- Las tablas de lectura pública mantienen el
-- SELECT abierto para resultados y catálogos.
-- =============================================

-- =============================================
-- 0. Funciones auxiliares (si no existieran)
-- =============================================
CREATE OR REPLACE FUNCTION is_admin()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $func$
  SELECT EXISTS (
    SELECT 1 FROM profiles
    WHERE id = auth.uid() AND rol = 'admin'
  );
$func$;

CREATE OR REPLACE FUNCTION is_staff()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $func$
  SELECT EXISTS (
    SELECT 1 FROM profiles
    WHERE id = auth.uid() AND rol IN ('admin', 'juez')
  );
$func$;

-- =============================================
-- 1. CONCURSOS  (lectura pública, escritura solo admin)
-- =============================================
ALTER TABLE concursos ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "concursos_select" ON concursos;
DROP POLICY IF EXISTS "concursos_select_public" ON concursos;
CREATE POLICY "concursos_select_public" ON concursos
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "concursos_insert" ON concursos;
DROP POLICY IF EXISTS "concursos_insert_staff" ON concursos;
DROP POLICY IF EXISTS "concursos_insert_admin" ON concursos;
CREATE POLICY "concursos_insert_admin" ON concursos
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "concursos_update" ON concursos;
DROP POLICY IF EXISTS "concursos_update_staff" ON concursos;
DROP POLICY IF EXISTS "concursos_update_admin" ON concursos;
CREATE POLICY "concursos_update_admin" ON concursos
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

DROP POLICY IF EXISTS "concursos_delete" ON concursos;
DROP POLICY IF EXISTS "concursos_delete_staff" ON concursos;
DROP POLICY IF EXISTS "concursos_delete_admin" ON concursos;
CREATE POLICY "concursos_delete_admin" ON concursos
FOR DELETE TO authenticated USING (is_admin());

-- =============================================
-- 2. BINOMIOS
-- =============================================
ALTER TABLE binomios ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "binomios_select" ON binomios;
DROP POLICY IF EXISTS "binomios_select_public" ON binomios;
CREATE POLICY "binomios_select_public" ON binomios
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "binomios_insert" ON binomios;
DROP POLICY IF EXISTS "binomios_insert_staff" ON binomios;
DROP POLICY IF EXISTS "binomios_insert_admin" ON binomios;
CREATE POLICY "binomios_insert_admin" ON binomios
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "binomios_update" ON binomios;
DROP POLICY IF EXISTS "binomios_update_staff" ON binomios;
DROP POLICY IF EXISTS "binomios_update_admin" ON binomios;
CREATE POLICY "binomios_update_admin" ON binomios
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

DROP POLICY IF EXISTS "binomios_delete" ON binomios;
DROP POLICY IF EXISTS "binomios_delete_staff" ON binomios;
DROP POLICY IF EXISTS "binomios_delete_admin" ON binomios;
CREATE POLICY "binomios_delete_admin" ON binomios
FOR DELETE TO authenticated USING (is_admin());

-- =============================================
-- 3. REPRISES
-- =============================================
ALTER TABLE reprises ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "reprises_select" ON reprises;
DROP POLICY IF EXISTS "reprises_select_public" ON reprises;
CREATE POLICY "reprises_select_public" ON reprises
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "reprises_insert" ON reprises;
DROP POLICY IF EXISTS "reprises_insert_staff" ON reprises;
DROP POLICY IF EXISTS "reprises_insert_admin" ON reprises;
CREATE POLICY "reprises_insert_admin" ON reprises
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "reprises_update" ON reprises;
DROP POLICY IF EXISTS "reprises_update_staff" ON reprises;
DROP POLICY IF EXISTS "reprises_update_admin" ON reprises;
CREATE POLICY "reprises_update_admin" ON reprises
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

DROP POLICY IF EXISTS "reprises_delete" ON reprises;
DROP POLICY IF EXISTS "reprises_delete_staff" ON reprises;
DROP POLICY IF EXISTS "reprises_delete_admin" ON reprises;
CREATE POLICY "reprises_delete_admin" ON reprises
FOR DELETE TO authenticated USING (is_admin());

-- =============================================
-- 4. EJERCICIOS_REPRISE
-- =============================================
ALTER TABLE ejercicios_reprise ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "ejercicios_select" ON ejercicios_reprise;
DROP POLICY IF EXISTS "ejercicios_select_public" ON ejercicios_reprise;
CREATE POLICY "ejercicios_select_public" ON ejercicios_reprise
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "ejercicios_insert" ON ejercicios_reprise;
DROP POLICY IF EXISTS "ejercicios_insert_authenticated" ON ejercicios_reprise;
DROP POLICY IF EXISTS "ejercicios_insert_staff" ON ejercicios_reprise;
DROP POLICY IF EXISTS "ejercicios_insert_admin" ON ejercicios_reprise;
CREATE POLICY "ejercicios_insert_admin" ON ejercicios_reprise
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "ejercicios_update" ON ejercicios_reprise;
DROP POLICY IF EXISTS "ejercicios_update_authenticated" ON ejercicios_reprise;
DROP POLICY IF EXISTS "ejercicios_update_staff" ON ejercicios_reprise;
DROP POLICY IF EXISTS "ejercicios_update_admin" ON ejercicios_reprise;
CREATE POLICY "ejercicios_update_admin" ON ejercicios_reprise
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

DROP POLICY IF EXISTS "ejercicios_delete" ON ejercicios_reprise;
DROP POLICY IF EXISTS "ejercicios_delete_authenticated" ON ejercicios_reprise;
DROP POLICY IF EXISTS "ejercicios_delete_staff" ON ejercicios_reprise;
DROP POLICY IF EXISTS "ejercicios_delete_admin" ON ejercicios_reprise;
CREATE POLICY "ejercicios_delete_admin" ON ejercicios_reprise
FOR DELETE TO authenticated USING (is_admin());

-- =============================================
-- 5. INSCRIPCIONES
-- =============================================
ALTER TABLE inscripciones ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "inscripciones_select" ON inscripciones;
DROP POLICY IF EXISTS "inscripciones_select_public" ON inscripciones;
CREATE POLICY "inscripciones_select_public" ON inscripciones
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "inscripciones_insert" ON inscripciones;
DROP POLICY IF EXISTS "inscripciones_insert_authenticated" ON inscripciones;
DROP POLICY IF EXISTS "inscripciones_insert_staff" ON inscripciones;
DROP POLICY IF EXISTS "inscripciones_insert_admin" ON inscripciones;
CREATE POLICY "inscripciones_insert_admin" ON inscripciones
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "inscripciones_update" ON inscripciones;
DROP POLICY IF EXISTS "inscripciones_update_authenticated" ON inscripciones;
DROP POLICY IF EXISTS "inscripciones_update_staff" ON inscripciones;
DROP POLICY IF EXISTS "inscripciones_update_admin" ON inscripciones;
CREATE POLICY "inscripciones_update_admin" ON inscripciones
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

DROP POLICY IF EXISTS "inscripciones_delete" ON inscripciones;
DROP POLICY IF EXISTS "inscripciones_delete_authenticated" ON inscripciones;
DROP POLICY IF EXISTS "inscripciones_delete_staff" ON inscripciones;
DROP POLICY IF EXISTS "inscripciones_delete_admin" ON inscripciones;
CREATE POLICY "inscripciones_delete_admin" ON inscripciones
FOR DELETE TO authenticated USING (is_admin());

-- =============================================
-- 6. PRUEBAS
-- =============================================
ALTER TABLE pruebas ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "pruebas_select" ON pruebas;
DROP POLICY IF EXISTS "pruebas_select_public" ON pruebas;
CREATE POLICY "pruebas_select_public" ON pruebas
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "pruebas_insert" ON pruebas;
DROP POLICY IF EXISTS "pruebas_insert_authenticated" ON pruebas;
DROP POLICY IF EXISTS "pruebas_insert_staff" ON pruebas;
DROP POLICY IF EXISTS "pruebas_insert_admin" ON pruebas;
CREATE POLICY "pruebas_insert_admin" ON pruebas
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "pruebas_update" ON pruebas;
DROP POLICY IF EXISTS "pruebas_update_authenticated" ON pruebas;
DROP POLICY IF EXISTS "pruebas_update_staff" ON pruebas;
DROP POLICY IF EXISTS "pruebas_update_admin" ON pruebas;
CREATE POLICY "pruebas_update_admin" ON pruebas
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

DROP POLICY IF EXISTS "pruebas_delete" ON pruebas;
DROP POLICY IF EXISTS "pruebas_delete_authenticated" ON pruebas;
DROP POLICY IF EXISTS "pruebas_delete_staff" ON pruebas;
DROP POLICY IF EXISTS "pruebas_delete_admin" ON pruebas;
CREATE POLICY "pruebas_delete_admin" ON pruebas
FOR DELETE TO authenticated USING (is_admin());

-- =============================================
-- 7. PRUEBA_JUECES
-- =============================================
ALTER TABLE prueba_jueces ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "prueba_jueces_select" ON prueba_jueces;
DROP POLICY IF EXISTS "prueba_jueces_select_public" ON prueba_jueces;
CREATE POLICY "prueba_jueces_select_public" ON prueba_jueces
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "prueba_jueces_insert" ON prueba_jueces;
DROP POLICY IF EXISTS "prueba_jueces_insert_authenticated" ON prueba_jueces;
DROP POLICY IF EXISTS "prueba_jueces_insert_staff" ON prueba_jueces;
DROP POLICY IF EXISTS "prueba_jueces_insert_admin" ON prueba_jueces;
CREATE POLICY "prueba_jueces_insert_admin" ON prueba_jueces
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "prueba_jueces_update" ON prueba_jueces;
DROP POLICY IF EXISTS "prueba_jueces_update_authenticated" ON prueba_jueces;
DROP POLICY IF EXISTS "prueba_jueces_update_staff" ON prueba_jueces;
DROP POLICY IF EXISTS "prueba_jueces_update_admin" ON prueba_jueces;
CREATE POLICY "prueba_jueces_update_admin" ON prueba_jueces
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

DROP POLICY IF EXISTS "prueba_jueces_delete" ON prueba_jueces;
DROP POLICY IF EXISTS "prueba_jueces_delete_authenticated" ON prueba_jueces;
DROP POLICY IF EXISTS "prueba_jueces_delete_staff" ON prueba_jueces;
DROP POLICY IF EXISTS "prueba_jueces_delete_admin" ON prueba_jueces;
CREATE POLICY "prueba_jueces_delete_admin" ON prueba_jueces
FOR DELETE TO authenticated USING (is_admin());

-- =============================================
-- 8. PARTICIPACIONES
-- =============================================
ALTER TABLE participaciones ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "participaciones_select" ON participaciones;
DROP POLICY IF EXISTS "participaciones_select_public" ON participaciones;
CREATE POLICY "participaciones_select_public" ON participaciones
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "participaciones_insert" ON participaciones;
DROP POLICY IF EXISTS "participaciones_insert_authenticated" ON participaciones;
DROP POLICY IF EXISTS "participaciones_insert_staff" ON participaciones;
DROP POLICY IF EXISTS "participaciones_insert_admin" ON participaciones;
CREATE POLICY "participaciones_insert_admin" ON participaciones
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "participaciones_update" ON participaciones;
DROP POLICY IF EXISTS "participaciones_update_authenticated" ON participaciones;
DROP POLICY IF EXISTS "participaciones_update_staff" ON participaciones;
DROP POLICY IF EXISTS "participaciones_update_admin" ON participaciones;
CREATE POLICY "participaciones_update_admin" ON participaciones
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

DROP POLICY IF EXISTS "participaciones_delete" ON participaciones;
DROP POLICY IF EXISTS "participaciones_delete_authenticated" ON participaciones;
DROP POLICY IF EXISTS "participaciones_delete_staff" ON participaciones;
DROP POLICY IF EXISTS "participaciones_delete_admin" ON participaciones;
CREATE POLICY "participaciones_delete_admin" ON participaciones
FOR DELETE TO authenticated USING (is_admin());

-- =============================================
-- 9. PUNTUACIONES (lectura pública,
--    insert/update: juez o admin, delete: admin)
-- =============================================
ALTER TABLE puntuaciones ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "puntuaciones_select" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_select_public" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_select_authenticated" ON puntuaciones;
CREATE POLICY "puntuaciones_select_public" ON puntuaciones
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "puntuaciones_insert" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_insert_authenticated" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_insert_staff" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_insert_juez" ON puntuaciones;
CREATE POLICY "puntuaciones_insert_juez_or_admin" ON puntuaciones
FOR INSERT TO authenticated
WITH CHECK (
  is_admin()
  OR EXISTS (
    SELECT 1 FROM prueba_jueces pj
    WHERE pj.id = puntuaciones.prueba_juez_id
      AND pj.juez_id = auth.uid()
  )
);

DROP POLICY IF EXISTS "puntuaciones_update" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_update_authenticated" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_update_own_or_admin" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_update_juez" ON puntuaciones;
CREATE POLICY "puntuaciones_update_juez_or_admin" ON puntuaciones
FOR UPDATE TO authenticated
USING (
  is_admin()
  OR EXISTS (
    SELECT 1 FROM prueba_jueces pj
    WHERE pj.id = puntuaciones.prueba_juez_id
      AND pj.juez_id = auth.uid()
  )
)
WITH CHECK (
  is_admin()
  OR EXISTS (
    SELECT 1 FROM prueba_jueces pj
    WHERE pj.id = puntuaciones.prueba_juez_id
      AND pj.juez_id = auth.uid()
  )
);

DROP POLICY IF EXISTS "puntuaciones_delete" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_delete_authenticated" ON puntuaciones;
DROP POLICY IF EXISTS "puntuaciones_delete_admin" ON puntuaciones;
CREATE POLICY "puntuaciones_delete_admin" ON puntuaciones
FOR DELETE TO authenticated USING (is_admin());

-- =============================================
-- 10. EQUIPOS + EQUIPO_MIEMBROS
-- =============================================
ALTER TABLE equipos ENABLE ROW LEVEL SECURITY;
ALTER TABLE equipo_miembros ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "equipos_select" ON equipos;
DROP POLICY IF EXISTS "equipos_select_public" ON equipos;
CREATE POLICY "equipos_select_public" ON equipos
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "equipos_write" ON equipos;
DROP POLICY IF EXISTS "equipos_insert" ON equipos;
DROP POLICY IF EXISTS "equipos_insert_staff" ON equipos;
DROP POLICY IF EXISTS "equipos_insert_admin" ON equipos;
CREATE POLICY "equipos_insert_admin" ON equipos
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "equipos_update" ON equipos;
DROP POLICY IF EXISTS "equipos_update_staff" ON equipos;
DROP POLICY IF EXISTS "equipos_update_admin" ON equipos;
CREATE POLICY "equipos_update_admin" ON equipos
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

DROP POLICY IF EXISTS "equipos_delete" ON equipos;
DROP POLICY IF EXISTS "equipos_delete_staff" ON equipos;
DROP POLICY IF EXISTS "equipos_delete_admin" ON equipos;
CREATE POLICY "equipos_delete_admin" ON equipos
FOR DELETE TO authenticated USING (is_admin());

DROP POLICY IF EXISTS "equipo_miembros_select" ON equipo_miembros;
DROP POLICY IF EXISTS "equipo_miembros_select_public" ON equipo_miembros;
CREATE POLICY "equipo_miembros_select_public" ON equipo_miembros
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "equipo_miembros_write" ON equipo_miembros;
DROP POLICY IF EXISTS "equipo_miembros_insert" ON equipo_miembros;
DROP POLICY IF EXISTS "equipo_miembros_insert_admin" ON equipo_miembros;
CREATE POLICY "equipo_miembros_insert_admin" ON equipo_miembros
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "equipo_miembros_update" ON equipo_miembros;
DROP POLICY IF EXISTS "equipo_miembros_update_admin" ON equipo_miembros;
CREATE POLICY "equipo_miembros_update_admin" ON equipo_miembros
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

DROP POLICY IF EXISTS "equipo_miembros_delete" ON equipo_miembros;
DROP POLICY IF EXISTS "equipo_miembros_delete_admin" ON equipo_miembros;
CREATE POLICY "equipo_miembros_delete_admin" ON equipo_miembros
FOR DELETE TO authenticated USING (is_admin());

-- =============================================
-- 11. JORNADAS + JORNADA_REPRISES
-- =============================================
ALTER TABLE jornadas ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "jornadas_select" ON jornadas;
DROP POLICY IF EXISTS "jornadas_select_public" ON jornadas;
CREATE POLICY "jornadas_select_public" ON jornadas
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "jornadas_insert" ON jornadas;
DROP POLICY IF EXISTS "jornadas_insert_staff" ON jornadas;
DROP POLICY IF EXISTS "jornadas_insert_admin" ON jornadas;
CREATE POLICY "jornadas_insert_admin" ON jornadas
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "jornadas_update" ON jornadas;
DROP POLICY IF EXISTS "jornadas_update_staff" ON jornadas;
DROP POLICY IF EXISTS "jornadas_update_admin" ON jornadas;
CREATE POLICY "jornadas_update_admin" ON jornadas
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

DROP POLICY IF EXISTS "jornadas_delete" ON jornadas;
DROP POLICY IF EXISTS "jornadas_delete_staff" ON jornadas;
DROP POLICY IF EXISTS "jornadas_delete_admin" ON jornadas;
CREATE POLICY "jornadas_delete_admin" ON jornadas
FOR DELETE TO authenticated USING (is_admin());

DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM pg_tables WHERE tablename = 'jornada_reprises'
  ) THEN
    EXECUTE 'ALTER TABLE jornada_reprises ENABLE ROW LEVEL SECURITY';

    EXECUTE 'DROP POLICY IF EXISTS "jornada_reprises_select" ON jornada_reprises';
    EXECUTE 'DROP POLICY IF EXISTS "jornada_reprises_select_public" ON jornada_reprises';
    EXECUTE 'CREATE POLICY "jornada_reprises_select_public" ON jornada_reprises
             FOR SELECT TO public USING (true)';

    EXECUTE 'DROP POLICY IF EXISTS "jornada_reprises_insert" ON jornada_reprises';
    EXECUTE 'DROP POLICY IF EXISTS "jornada_reprises_insert_staff" ON jornada_reprises';
    EXECUTE 'DROP POLICY IF EXISTS "jornada_reprises_insert_admin" ON jornada_reprises';
    EXECUTE 'CREATE POLICY "jornada_reprises_insert_admin" ON jornada_reprises
             FOR INSERT TO authenticated WITH CHECK (is_admin())';

    EXECUTE 'DROP POLICY IF EXISTS "jornada_reprises_update" ON jornada_reprises';
    EXECUTE 'DROP POLICY IF EXISTS "jornada_reprises_update_admin" ON jornada_reprises';
    EXECUTE 'CREATE POLICY "jornada_reprises_update_admin" ON jornada_reprises
             FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin())';

    EXECUTE 'DROP POLICY IF EXISTS "jornada_reprises_delete" ON jornada_reprises';
    EXECUTE 'DROP POLICY IF EXISTS "jornada_reprises_delete_staff" ON jornada_reprises';
    EXECUTE 'DROP POLICY IF EXISTS "jornada_reprises_delete_admin" ON jornada_reprises';
    EXECUTE 'CREATE POLICY "jornada_reprises_delete_admin" ON jornada_reprises
             FOR DELETE TO authenticated USING (is_admin())';
  END IF;
END $$;

-- =============================================
-- 12. JUECES (tabla de asignación, no profiles)
-- =============================================
ALTER TABLE jueces ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "jueces_select" ON jueces;
DROP POLICY IF EXISTS "jueces_select_public" ON jueces;
CREATE POLICY "jueces_select_public" ON jueces
FOR SELECT TO public USING (true);

DROP POLICY IF EXISTS "jueces_insert" ON jueces;
DROP POLICY IF EXISTS "jueces_insert_staff" ON jueces;
DROP POLICY IF EXISTS "jueces_insert_admin" ON jueces;
CREATE POLICY "jueces_insert_admin" ON jueces
FOR INSERT TO authenticated WITH CHECK (is_admin());

DROP POLICY IF EXISTS "jueces_update" ON jueces;
DROP POLICY IF EXISTS "jueces_update_staff" ON jueces;
DROP POLICY IF EXISTS "jueces_update_admin" ON jueces;
CREATE POLICY "jueces_update_admin" ON jueces
FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin());

DROP POLICY IF EXISTS "jueces_delete" ON jueces;
DROP POLICY IF EXISTS "jueces_delete_staff" ON jueces;
DROP POLICY IF EXISTS "jueces_delete_admin" ON jueces;
CREATE POLICY "jueces_delete_admin" ON jueces
FOR DELETE TO authenticated USING (is_admin());

-- =============================================
-- 13. NIVELES, CATEGORIAS_EDAD, TIPOS_PRUEBA, NIVELES_REPRISES
-- =============================================
DO $$
DECLARE
  tabla text;
  tablas constant text[] := ARRAY[
    'niveles', 'categorias_edad', 'tipos_prueba', 'niveles_reprises'
  ];
BEGIN
  FOREACH tabla IN ARRAY tablas LOOP
    IF EXISTS (SELECT 1 FROM pg_tables WHERE tablename = tabla) THEN
      EXECUTE format('ALTER TABLE %I ENABLE ROW LEVEL SECURITY', tabla);

      EXECUTE format(
        'DROP POLICY IF EXISTS %I ON %I',
        tabla || '_select', tabla
      );
      EXECUTE format(
        'CREATE POLICY %I ON %I FOR SELECT TO public USING (true)',
        tabla || '_select_public', tabla
      );

      EXECUTE format(
        'DROP POLICY IF EXISTS %I ON %I',
        tabla || '_insert', tabla
      );
      EXECUTE format(
        'DROP POLICY IF EXISTS %I ON %I',
        tabla || '_insert_staff', tabla
      );
      EXECUTE format(
        'CREATE POLICY %I ON %I FOR INSERT TO authenticated WITH CHECK (is_admin())',
        tabla || '_insert_admin', tabla
      );

      EXECUTE format(
        'DROP POLICY IF EXISTS %I ON %I',
        tabla || '_update', tabla
      );
      EXECUTE format(
        'DROP POLICY IF EXISTS %I ON %I',
        tabla || '_update_staff', tabla
      );
      EXECUTE format(
        'CREATE POLICY %I ON %I FOR UPDATE TO authenticated USING (is_admin()) WITH CHECK (is_admin())',
        tabla || '_update_admin', tabla
      );

      EXECUTE format(
        'DROP POLICY IF EXISTS %I ON %I',
        tabla || '_delete', tabla
      );
      EXECUTE format(
        'DROP POLICY IF EXISTS %I ON %I',
        tabla || '_delete_staff', tabla
      );
      EXECUTE format(
        'CREATE POLICY %I ON %I FOR DELETE TO authenticated USING (is_admin())',
        tabla || '_delete_admin', tabla
      );
    END IF;
  END LOOP;
END $$;

-- =============================================
-- 14. PROFILES (mantener: solo admin puede
--    insertar/eliminar/actualizar otros usuarios)
-- =============================================
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

-- =============================================
-- Verificación
-- =============================================
SELECT
  tablename,
  policyname,
  cmd
FROM pg_policies
WHERE schemaname = 'public'
ORDER BY tablename, cmd, policyname;