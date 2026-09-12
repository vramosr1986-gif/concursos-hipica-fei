-- ============================================
-- SEED: JUECES ASIGNADOS, PARTICIPACIONES Y PUNTUACIONES
-- ============================================

-- ============================================
-- JUECES ASIGNADOS A PRUEBAS (A, B, C)
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
  SELECT id INTO v_juez1 FROM profiles WHERE email = 'juez1@test.com';
  SELECT id INTO v_juez2 FROM profiles WHERE email = 'juez2@test.com';
  SELECT id INTO v_juez3 FROM profiles WHERE email = 'juez3@test.com';
  SELECT id INTO v_juez4 FROM profiles WHERE email = 'juez4@test.com';
  SELECT id INTO v_juez5 FROM profiles WHERE email = 'juez5@test.com';

  -- Asignar A, B, C a TODAS las pruebas
  FOR v_prueba IN SELECT id FROM pruebas LOOP
    INSERT INTO prueba_jueces (prueba_id, juez_id, letra) VALUES
      (v_prueba.id, v_juez1, 'A'),
      (v_prueba.id, v_juez2, 'B'),
      (v_prueba.id, v_juez3, 'C')
    ON CONFLICT (prueba_id, letra) DO NOTHING;
  END LOOP;

  -- Añadir D y E a las pruebas de Verano
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

-- ============================================
-- PARTICIPACIONES (binomios por prueba segun categoria)
-- ============================================
DO $$
DECLARE
  v_prueba_id uuid;
  v_inscripcion RECORD;
  v_orden int;
BEGIN
  FOR v_prueba_id IN SELECT id FROM pruebas LOOP
    v_orden := 1;

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

-- ============================================
-- PUNTUACIONES DE EJEMPLO
-- ============================================
DO $$
DECLARE
  v_participacion RECORD;
  v_juez RECORD;
  v_ejercicio RECORD;
  v_notas jsonb;
  v_total numeric;
  v_importe numeric;
  v_prueba_id uuid;
  v_reprise_id uuid;
BEGIN
  -- Solo para pruebas especificas
  FOR v_prueba_id IN
    SELECT id FROM pruebas 
    WHERE nombre IN ('Clasica 1 - Alevines', 'Clasica 3 - Adultos')
  LOOP
    SELECT reprise_id INTO v_reprise_id FROM pruebas WHERE id = v_prueba_id;

    FOR v_participacion IN
      SELECT id FROM participaciones WHERE prueba_id = v_prueba_id
    LOOP
      FOR v_juez IN
        SELECT juez_id, letra FROM prueba_jueces WHERE prueba_id = v_prueba_id
      LOOP
        v_notas := '[]'::jsonb;
        v_total := 0;

        FOR v_ejercicio IN
          SELECT id, numero_orden, coeficiente, puntuacion_max 
          FROM ejercicios_reprise 
          WHERE reprise_id = v_reprise_id
        LOOP
          v_importe := ROUND((6.0 + random() * 2.5)::numeric, 1);
          v_notas := v_notas || jsonb_build_object(
            'ejercicio_id', v_ejercicio.id,
            'numero_orden', v_ejercicio.numero_orden,
            'puntuacion', v_importe
          );
          v_total := v_total + (v_importe * v_ejercicio.coeficiente);
        END LOOP;

        INSERT INTO puntuaciones (participacion_id, juez_id, letra_juez, notas, puntuacion_final)
        VALUES (v_participacion.id, v_juez.juez_id, v_juez.letra, v_notas, v_total)
        ON CONFLICT (participacion_id, juez_id) DO NOTHING;
      END LOOP;
    END LOOP;
  END LOOP;
END $$;

-- ============================================
-- VERIFICACION
-- ============================================
SELECT 
  c.nombre AS concurso,
  p.nombre AS prueba,
  p.categoria,
  COUNT(DISTINCT pj.id) AS num_jueces,
  COUNT(DISTINCT pa.id) AS num_binomios
FROM pruebas p
LEFT JOIN concursos c ON c.id = p.concurso_id
LEFT JOIN prueba_jueces pj ON pj.prueba_id = p.id
LEFT JOIN participaciones pa ON pa.prueba_id = p.id
GROUP BY c.nombre, p.nombre, p.categoria
ORDER BY c.nombre, p.nombre;
