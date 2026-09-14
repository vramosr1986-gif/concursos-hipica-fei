-- ============================================================
-- POBLAR "Otono 2026" (Barcelona) COMPLETO
-- 1. Equipo Cataluna con 4 miembros
-- 2. Jueces asignados a las pruebas
-- 3. Participantes en cada prueba
-- 4. Puntuaciones
-- ============================================================

DO $$
DECLARE
  v_concurso_id uuid;
  v_equipo_id uuid;
  v_prueba_id uuid;
  v_inscripcion_id uuid;
  v_prueba_juez_id uuid;
  v_reprise_id uuid;
  v_ejercicio_id uuid;
  r_inscripcion RECORD;
  r_prueba RECORD;
  r_juez RECORD;
  r_ejercicio RECORD;
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

  RAISE NOTICE 'Concurso Otono 2026: %', v_concurso_id;

  -- 2. Inscribir binomios que no esten ya en este concurso
  FOR r_inscripcion IN
    SELECT b.id AS binomio_id
    FROM binomios b
    WHERE NOT EXISTS (
      SELECT 1 FROM inscripciones i 
      WHERE i.concurso_id = v_concurso_id AND i.binomio_id = b.id
    )
    LIMIT 15
  LOOP
    SELECT COALESCE(MAX(dorsal), 0) + 1 INTO v_contador_insc
    FROM inscripciones WHERE concurso_id = v_concurso_id;

    INSERT INTO inscripciones (binomio_id, concurso_id, dorsal, categoria)
    VALUES (r_inscripcion.binomio_id, v_concurso_id, v_contador_insc, 'Clasica');
    
    RAISE NOTICE 'Inscrito binomio con dorsal %', v_contador_insc;
  END LOOP;

  -- 3. Crear equipo "Cataluna" en Otono 2026
  SELECT id INTO v_equipo_id FROM equipos 
  WHERE concurso_id = v_concurso_id AND nombre = 'Cataluna' LIMIT 1;
  
  IF v_equipo_id IS NULL THEN
    INSERT INTO equipos (concurso_id, nombre, club)
    VALUES (v_concurso_id, 'Cataluna', 'RFHE Cataluna')
    RETURNING id INTO v_equipo_id;
    RAISE NOTICE 'Equipo Cataluna creado: %', v_equipo_id;
  END IF;

  -- 4. Anadir 4 miembros al equipo (que no esten ya en otro equipo)
  v_orden := 1;
  FOR r_inscripcion IN
    SELECT i.id AS inscripcion_id
    FROM inscripciones i
    WHERE i.concurso_id = v_concurso_id
      AND NOT EXISTS (
        SELECT 1 FROM equipo_miembros em 
        WHERE em.inscripcion_id = i.id
      )
    ORDER BY i.dorsal
    LIMIT 4
  LOOP
    INSERT INTO equipo_miembros (equipo_id, inscripcion_id, orden)
    VALUES (v_equipo_id, r_inscripcion.inscripcion_id, v_orden);
    
    RAISE NOTICE 'Miembro % anadido al equipo', v_orden;
    v_orden := v_orden + 1;
  END LOOP;

  -- 5. Asignar jueces a TODAS las pruebas del concurso
  FOR r_prueba IN
    SELECT id, reprise_id FROM pruebas WHERE concurso_id = v_concurso_id
  LOOP
    v_orden := 1;
    FOR r_juez IN
      SELECT id FROM profiles WHERE rol = 'juez' ORDER BY id LIMIT 3
    LOOP
      -- Verificar si ya existe
      IF NOT EXISTS (
        SELECT 1 FROM prueba_jueces 
        WHERE prueba_id = r_prueba.id 
          AND letra = CASE v_orden WHEN 1 THEN 'A' WHEN 2 THEN 'B' ELSE 'C' END
      ) THEN
        INSERT INTO prueba_jueces (prueba_id, juez_id, letra)
        VALUES (
          r_prueba.id, 
          r_juez.id, 
          CASE v_orden WHEN 1 THEN 'A' WHEN 2 THEN 'B' ELSE 'C' END
        );
        RAISE NOTICE 'Juez % anadido a prueba % (letra %)', v_orden, r_prueba.id, 
          CASE v_orden WHEN 1 THEN 'A' WHEN 2 THEN 'B' ELSE 'C' END;
      END IF;
      v_orden := v_orden + 1;
    END LOOP;
  END LOOP;

  -- 6. Anadir TODAS las inscripciones a CADA prueba del concurso
  FOR r_prueba IN
    SELECT id FROM pruebas WHERE concurso_id = v_concurso_id
  LOOP
    v_orden := 1;
    FOR r_inscripcion IN
      SELECT id, equipo_id FROM (
        SELECT i.id, em.equipo_id
        FROM inscripciones i
        LEFT JOIN equipo_miembros em ON em.inscripcion_id = i.id
        WHERE i.concurso_id = v_concurso_id
      ) sub
      ORDER BY id
    LOOP
      -- Verificar si ya existe
      IF NOT EXISTS (
        SELECT 1 FROM participaciones 
        WHERE prueba_id = r_prueba.id AND inscripcion_id = r_inscripcion.id
      ) THEN
        INSERT INTO participaciones (prueba_id, inscripcion_id, orden_salida, equipo_id)
        VALUES (r_prueba.id, r_inscripcion.id, v_orden, r_inscripcion.equipo_id);
        
        v_orden := v_orden + 1;
        v_contador_part := v_contador_part + 1;
      END IF;
    END LOOP;
  END LOOP;

  RAISE NOTICE 'Total participaciones creadas: %', v_contador_part;

  -- 7. Generar puntuaciones para todas las participaciones sin puntuaciones
  FOR r_prueba IN
    SELECT id, reprise_id FROM pruebas 
    WHERE concurso_id = v_concurso_id AND reprise_id IS NOT NULL
  LOOP
    v_reprise_id := r_prueba.reprise_id;

    FOR r_inscripcion IN
      SELECT id FROM participaciones WHERE prueba_id = r_prueba.id
    LOOP
      FOR r_juez IN
        SELECT id, letra FROM prueba_jueces WHERE prueba_id = r_prueba.id
      LOOP
        FOR r_ejercicio IN
          SELECT id FROM ejercicios_reprise 
          WHERE reprise_id = v_reprise_id 
          ORDER BY numero_orden
        LOOP
          -- Verificar si ya existe
          IF NOT EXISTS (
            SELECT 1 FROM puntuaciones
            WHERE participacion_id = r_inscripcion.id
              AND prueba_juez_id = r_juez.id
              AND ejercicio_reprise_id = r_ejercicio.id
          ) THEN
            INSERT INTO puntuaciones (
              participacion_id, prueba_juez_id, ejercicio_reprise_id,
              nota, comentario, letra_juez
            ) VALUES (
              r_inscripcion.id, r_juez.id, r_ejercicio.id,
              ROUND((5.0 + random() * 4.5)::numeric, 1),
              'Nota de ejemplo',
              r_juez.letra
            );
            v_contador_punt := v_contador_punt + 1;
          END IF;
        END LOOP;
      END LOOP;
    END LOOP;
  END LOOP;

  RAISE NOTICE 'Total puntuaciones creadas: %', v_contador_punt;
END $$;

-- ============================================================
-- VERIFICACION
-- ============================================================

-- Resumen por concurso
SELECT 
  c.nombre AS concurso,
  COUNT(DISTINCT i.id) AS inscripciones,
  COUNT(DISTINCT e.id) AS equipos,
  COUNT(DISTINCT p.id) AS pruebas,
  COUNT(DISTINCT pa.id) AS participaciones,
  COUNT(DISTINCT pu.id) AS puntuaciones
FROM concursos c
LEFT JOIN inscripciones i ON i.concurso_id = c.id
LEFT JOIN equipos e ON e.concurso_id = c.id
LEFT JOIN pruebas p ON p.concurso_id = c.id
LEFT JOIN participaciones pa ON pa.prueba_id = p.id
LEFT JOIN puntuaciones pu ON pu.participacion_id = pa.id
WHERE c.nombre IN ('Otono 2026', 'Primavera 2026', 'Verano 2026')
GROUP BY c.nombre, c.fecha_inicio
ORDER BY c.fecha_inicio;

-- Detalle equipos
SELECT 
  c.nombre AS concurso,
  e.nombre AS equipo,
  COUNT(em.id) AS num_miembros
FROM equipos e
JOIN concursos c ON c.id = e.concurso_id
LEFT JOIN equipo_miembros em ON em.equipo_id = e.id
WHERE c.nombre IN ('Otono 2026', 'Primavera 2026')
GROUP BY c.nombre, c.fecha_inicio, e.nombre
ORDER BY c.fecha_inicio, e.nombre;