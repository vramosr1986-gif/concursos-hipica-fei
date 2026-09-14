-- ============================================================
-- COMPLETAR Otono 2026 con binomios INDIVIDUALES
-- ============================================================

DO $$
DECLARE
  v_concurso_id uuid;
  v_reprise_id uuid;
  v_prueba_id uuid;
  v_inscripcion_id uuid;
  v_prueba_juez_id uuid;
  v_ejercicio_id uuid;
  r_binomio RECORD;
  r_inscripcion RECORD;
  r_prueba RECORD;
  r_juez RECORD;
  r_ejercicio RECORD;
  r_participacion RECORD;
  v_contador_insc int := 0;
  v_contador_part int := 0;
  v_contador_punt int := 0;
  v_orden int := 1;
BEGIN
  -- 1. Obtener el concurso "Otono 2026"
  SELECT id INTO v_concurso_id FROM concursos WHERE nombre = 'Otono 2026' LIMIT 1;
  
  IF v_concurso_id IS NULL THEN
    RAISE EXCEPTION 'No se encontro el concurso Otono 2026';
  END IF;

  -- 2. Inscribir binomios NUEVOS (sin equipo) que no esten ya
  FOR r_binomio IN
    SELECT b.id AS binomio_id
    FROM binomios b
    WHERE NOT EXISTS (
      SELECT 1 FROM inscripciones i 
      WHERE i.concurso_id = v_concurso_id AND i.binomio_id = b.id
    )
    LIMIT 10
  LOOP
    SELECT COALESCE(MAX(dorsal), 0) + 1 INTO v_contador_insc
    FROM inscripciones WHERE concurso_id = v_concurso_id;

    INSERT INTO inscripciones (binomio_id, concurso_id, dorsal, categoria)
    VALUES (r_binomio.binomio_id, v_concurso_id, v_contador_insc, 'Clasica');
    
    RAISE NOTICE 'Binomio individual inscrito con dorsal %', v_contador_insc;
  END LOOP;

  -- 3. Anadir TODAS las inscripciones SIN equipo a TODAS las pruebas
  FOR r_prueba IN
    SELECT id, reprise_id FROM pruebas WHERE concurso_id = v_concurso_id
  LOOP
    v_orden := 100;  -- empezar en 100 para que vayan despues de los equipos

    FOR r_inscripcion IN
      SELECT i.id AS inscripcion_id
      FROM inscripciones i
      WHERE i.concurso_id = v_concurso_id
        AND NOT EXISTS (
          SELECT 1 FROM equipo_miembros em 
          WHERE em.inscripcion_id = i.id
        )
      ORDER BY i.dorsal
    LOOP
      -- Verificar si ya existe
      IF NOT EXISTS (
        SELECT 1 FROM participaciones 
        WHERE prueba_id = r_prueba.id AND inscripcion_id = r_inscripcion.inscripcion_id
      ) THEN
        INSERT INTO participaciones (prueba_id, inscripcion_id, orden_salida)
        VALUES (r_prueba.id, r_inscripcion.inscripcion_id, v_orden);
        
        v_orden := v_orden + 1;
        v_contador_part := v_contador_part + 1;
      END IF;
    END LOOP;
  END LOOP;

  RAISE NOTICE 'Participaciones individuales creadas: %', v_contador_part;

  -- 4. Generar puntuaciones para las NUEVAS participaciones
  FOR r_prueba IN
    SELECT id, reprise_id FROM pruebas 
    WHERE concurso_id = v_concurso_id AND reprise_id IS NOT NULL
  LOOP
    v_reprise_id := r_prueba.reprise_id;

    FOR r_participacion IN
      SELECT pa.id AS participacion_id
      FROM participaciones pa
      WHERE pa.prueba_id = r_prueba.id
        AND NOT EXISTS (
          SELECT 1 FROM puntuaciones pu 
          WHERE pu.participacion_id = pa.id
        )
    LOOP
      FOR r_juez IN
        SELECT id, letra FROM prueba_jueces WHERE prueba_id = r_prueba.id
      LOOP
        FOR r_ejercicio IN
          SELECT id FROM ejercicios_reprise 
          WHERE reprise_id = v_reprise_id 
          ORDER BY numero_orden
        LOOP
          INSERT INTO puntuaciones (
            participacion_id, prueba_juez_id, ejercicio_reprise_id,
            nota, comentario, letra_juez
          ) VALUES (
            r_participacion.participacion_id, r_juez.id, r_ejercicio.id,
            ROUND((5.0 + random() * 4.5)::numeric, 1),
            'Nota de ejemplo',
            r_juez.letra
          );
          v_contador_punt := v_contador_punt + 1;
        END LOOP;
      END LOOP;
    END LOOP;
  END LOOP;

  RAISE NOTICE 'Puntuaciones individuales creadas: %', v_contador_punt;
END $$;

-- ============================================================
-- VERIFICACION: Estado de Otono 2026
-- ============================================================

-- Por prueba: cuantos con equipo, cuantos individuales
SELECT 
  p.nombre AS prueba,
  COUNT(DISTINCT pa.id) AS total_participantes,
  COUNT(DISTINCT pa.id) FILTER (WHERE pa.equipo_id IS NOT NULL) AS en_equipo,
  COUNT(DISTINCT pa.id) FILTER (WHERE pa.equipo_id IS NULL) AS individuales,
  COUNT(DISTINCT pu.id) AS puntuaciones
FROM pruebas p
LEFT JOIN participaciones pa ON pa.prueba_id = p.id
LEFT JOIN puntuaciones pu ON pu.participacion_id = pa.id
WHERE p.concurso_id = (SELECT id FROM concursos WHERE nombre = 'Otono 2026')
GROUP BY p.id, p.nombre, p.orden
ORDER BY p.orden;

-- Equipos en Otono 2026
SELECT 
  e.nombre AS equipo,
  COUNT(em.id) AS num_miembros
FROM equipos e
LEFT JOIN equipo_miembros em ON em.equipo_id = e.id
WHERE e.concurso_id = (SELECT id FROM concursos WHERE nombre = 'Otono 2026')
GROUP BY e.nombre
ORDER BY e.nombre;