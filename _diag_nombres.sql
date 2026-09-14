-- A) Jueces que aparecen en la prueba "Promocion 3 - Jovenes Jinetes"
SELECT
  pj.letra,
  pj.juez_id,
  p.nombre   AS nombre_en_profiles,
  p.email    AS email_en_profiles,
  p.rol      AS rol_en_profiles
FROM prueba_jueces pj
LEFT JOIN profiles p ON p.id = pj.juez_id
WHERE pj.prueba_id = (
  SELECT id FROM pruebas WHERE nombre = 'Promocion 3 - Jovenes Jinetes' LIMIT 1
)
ORDER BY pj.letra;

-- B) Todos los jueces en profiles
SELECT id, email, nombre, rol
FROM profiles
WHERE rol = 'juez'
ORDER BY email;

-- C) ¿Cuántos prueba_jueces apuntan a profiles inexistentes?
SELECT
  COUNT(*)                                                      AS total_prueba_jueces,
  COUNT(p.id)                                                   AS coinciden,
  COUNT(*) - COUNT(p.id)                                        AS huerfanos
FROM prueba_jueces pj
LEFT JOIN profiles p ON p.id = pj.juez_id;