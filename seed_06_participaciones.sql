-- ============================================
-- ASIGNAR BINOMIOS A CADA PRUEBA
-- ============================================
DO $$
DECLARE
  v_prueba_id uuid;
  v_inscripcion RECORD;
  v_orden int;
BEGIN
  -- Iterar TODAS las pruebas
  FOR v_prueba_id IN SELECT id FROM pruebas LOOP
    v_orden := 1;

    -- Para cada prueba, buscar las inscripciones de la MISMA categoría
    FOR v_inscripcion IN
      SELECT i.id 
      FROM inscripciones i
      LEFT JOIN pruebas p ON p.id = v_prueba_id
      WHERE i.concurso_id = p.concurso_id
        AND i.categoria = p.categoria
      ORDER BY i.dorsal
    LOOP
      INSERT INTO participaciones (prueba_id, inscripcion_id, orden_salida, estado)
      VALUES (v_prueba_id, v_inscripcion.id, v_orden, 'pendiente')
      ON CONFLICT (prueba_id, inscripcion_id) DO NOTHING;

      v_orden := v_orden + 1;
    END LOOP;
  END LOOP;
END $$;

-- Verificar
SELECT 
  c.nombre AS concurso,
  p.nombre AS prueba,
  p.categoria,
  COUNT(pa.id) AS num_binomios
FROM pruebas p
LEFT JOIN concursos c ON c.id = p.concurso_id
LEFT JOIN participaciones pa ON pa.prueba_id = p.id
GROUP BY c.nombre, p.nombre, p.categoria
ORDER BY c.nombre, p.nombre;
