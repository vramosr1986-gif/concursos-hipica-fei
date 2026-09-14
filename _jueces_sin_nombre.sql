SELECT pj.letra, pj.juez_id, pr.nombre, pr.email, pr.rol
FROM prueba_jueces pj
LEFT JOIN profiles pr ON pr.id = pj.juez_id
WHERE pr.nombre IS NULL
   OR pr.nombre = ''
   OR pr.id IS NULL
ORDER BY pj.letra;