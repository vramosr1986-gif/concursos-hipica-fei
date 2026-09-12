-- ============================================
-- ASIGNAR JUECES A TODAS LAS PRUEBAS (A, B, C)
-- ============================================
DO $$
DECLARE
  v_prueba RECORD;
  v_juez1 uuid;
  v_juez2 uuid;
  v_juez3 uuid;
  v_juez4 uuid;
  v_juez5 uuid;
BEGIN
  -- Obtener los UUIDs de los jueces
  SELECT id INTO v_juez1 FROM profiles WHERE email = 'juez1@test.com';
  SELECT id INTO v_juez2 FROM profiles WHERE email = 'juez2@test.com';
  SELECT id INTO v_juez3 FROM profiles WHERE email = 'juez3@test.com';
  SELECT id INTO v_juez4 FROM profiles WHERE email = 'juez4@test.com';
  SELECT id INTO v_juez5 FROM profiles WHERE email = 'juez5@test.com';

  -- Iterar todas las pruebas y asignar A, B, C
  FOR v_prueba IN SELECT id FROM pruebas LOOP
    INSERT INTO prueba_jueces (prueba_id, juez_id, letra) VALUES
      (v_prueba.id, v_juez1, 'A'),
      (v_prueba.id, v_juez2, 'B'),
      (v_prueba.id, v_juez3, 'C')
    ON CONFLICT (prueba_id, letra) DO NOTHING;
  END LOOP;

  -- Añadir D y E a las pruebas de Verano (Intermedia I y Gran Premio)
  FOR v_prueba IN 
    SELECT p.id FROM pruebas p 
    LEFT JOIN concursos c ON c.id = p.concurso_id 
    WHERE c.nombre = 'Verano 2026'
  LOOP
    INSERT INTO prueba_jueces (prueba_id, juez_id, letra) VALUES
      (v_prueba.id, v_juez4, 'D'),
      (v_prueba.id, v_juez5, 'E')
    ON CONFLICT (prueba_id, letra) DO NOTHING;
  END LOOP;
END $$;

-- Verificar
SELECT 
  c.nombre AS concurso,
  p.nombre AS prueba,
  COUNT(pj.id) AS num_jueces,
  STRING_AGG(pj.letra, ', ' ORDER BY pj.letra) AS letras
FROM pruebas p
LEFT JOIN concursos c ON c.id = p.concurso_id
LEFT JOIN prueba_jueces pj ON pj.prueba_id = p.id
GROUP BY c.nombre, p.nombre
ORDER BY c.nombre, p.nombre;
