-- ============================================
-- FUNCIONES AUXILIARES
-- ============================================

-- ============================================
-- is_admin(): true si el usuario actual es admin
-- ============================================
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

-- ============================================
-- is_staff(): true si el usuario actual es admin o juez
-- ============================================
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

-- ============================================
-- get_jueces_con_email(): devuelve los jueces con email
-- ============================================
DROP FUNCTION IF EXISTS get_jueces_con_email();

CREATE OR REPLACE FUNCTION get_jueces_con_email()
RETURNS TABLE (
  id uuid,
  full_name text,
  email text,
  telefono text,
  especialidad text,
  categoria text,
  activo boolean,
  concurso_id uuid,
  letra_oficial text,
  experiencia text,
  created_at timestamptz
)
LANGUAGE sql
SECURITY DEFINER
AS $func$
  SELECT
    j.id,
    j.nombre AS full_name,
    u.email::text AS email,
    NULL::text AS telefono,
    NULL::text AS especialidad,
    NULL::text AS categoria,
    true AS activo,
    j.concurso_id,
    j.letra_oficial,
    j.experiencia,
    j.created_at
  FROM jueces j
  LEFT JOIN auth.users u ON u.id = j.user_id
  ORDER BY j.nombre ASC;
$func$;

SELECT 'Funciones creadas correctamente' AS resultado;
