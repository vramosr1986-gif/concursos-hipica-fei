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
    j.telefono,
    j.especialidad,
    j.categoria,
    COALESCE(j.activo, true) AS activo,
    j.concurso_id,
    j.letra_oficial,
    j.experiencia,
    j.created_at
  FROM jueces j
  LEFT JOIN auth.users u ON u.id = j.user_id
  ORDER BY j.nombre ASC;
$func$;
