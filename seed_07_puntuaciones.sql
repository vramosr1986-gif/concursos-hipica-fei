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
  -- Solo para las pruebas "Clasica 1 - Alevines" y "Clasica 3 - Adultos"
  FOR v_prueba_id IN
    SELECT id FROM pruebas 
    WHERE nombre IN ('Clasica 1 - Alevines', 'Clasica 3 - Adultos')
  LOOP
    -- Obtener reprise
    SELECT reprise_id INTO v_reprise_id FROM pruebas WHERE id = v_prueba_id;

    -- Para cada participacion de esta prueba
    FOR v_participacion IN
      SELECT id FROM participaciones WHERE prueba_id = v_prueba_id
    LOOP
      -- Para cada juez asignado a esta prueba
      FOR v_juez IN
        SELECT juez_id, letra FROM prueba_jueces WHERE prueba_id = v_prueba_id
      LOOP
        v_notas := '[]'::jsonb;
        v_total := 0;

        -- Puntuar cada ejercicio
        FOR v_ejercicio IN
          SELECT id, numero_orden, coeficiente, puntuacion_max 
          FROM ejercicios_reprise 
          WHERE reprise_id = v_reprise_id
        LOOP
          -- Nota aleatoria entre 6.0 y 8.5
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

-- Verificar
SELECT 
  c.nombre AS concurso,
  p.nombre AS prueba,
  COUNT(DISTINCT pu.id) AS total_puntuaciones,
  ROUND(AVG(pu.puntuacion_final), 2) AS media_puntos
FROM puntuaciones pu
LEFT JOIN participaciones pa ON pa.id = pu.participacion_id
LEFT JOIN pruebas p ON p.id = pa.prueba_id
LEFT JOIN concursos c ON c.id = p.concurso_id
GROUP BY c.nombre, p.nombre
ORDER BY c.nombre, p.nombre;
