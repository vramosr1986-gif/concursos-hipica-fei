-- ============================================================
-- POBLAR "Verano 2026" (Sevilla) COMPLETO
-- 1. Inscribir binomios
-- 2. Crear equipo "Sevilla" con 4 miembros
-- 3. Asignar jueces
-- 4. Inscribir binomios a pruebas
-- 5. Generar puntuaciones
-- ============================================================

DO $$
DECLARE
  v_concurso_id uuid;
  v_equipo_id uuid;
  v_reprise_id uuid;
  v_contador_insc int := 0;
  v_contador_part int := 0;
  v_contador_punt int := 0;
  v_orden int := 1;
  r_binomio RECORD;
  r_inscripcion RECORD;
  r_prueba RECORD;
  r_juez RECORD;
  r_ejercicio RECORD;
  r_participacion RECORD;
BEGIN
  -- 1. Obtener el concurso
  SELECT id INTO v_concurso_id FROM concursos WHERE nombre = 'Verano 2026' LIMIT 1;
  
  IF v_concurso_id IS NULL THEN
    RAISE EXCEPTION 'No se encontro Verano 2026';
  END IF;

  RAISE NOTICE 'Concurso Verano 2026: %', v_concurso_id;

  -- 2. Inscribir 15 binomios que no esten ya
  FOR r_binomio IN
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
    VALUES (r_binomio.binomio_id, v_concurso_id, v_contador_insc, 'Clasica');
  END LOOP;

  RAISE NOTICE 'Binomios inscritos';

  -- 3. Crear equipo "Sevilla" con 4 miembros
  SELECT id INTO v_equipo_id FROM equipos 
  WHERE concurso_id = v_concurso_id AND nombre = 'Sevilla' LIMIT 1;
  
  IF v_equipo_id IS NULL THEN
    INSERT INTO equipos (concurso_id, nombre, club)
    VALUES (v_concurso_id, 'Sevilla', 'RFHE Andalucia')
    RETURNING id INTO v_equipo_id;
  END IF;

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
    v_orden := v_orden + 1;
  END LOOP;

  RAISE NOTICE 'Equipo Sevilla creado con 4 miembros';

  -- 4. Asignar 3 jueces a cada prueba
  FOR r_prueba IN
    SELECT id FROM pruebas WHERE concurso_id = v_concurso_id
  LOOP
    v_orden := 1;
    FOR r_juez IN
      SELECT id FROM profiles WHERE rol = 'juez' ORDER BY id LIMIT 3
    LOOP
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
      END IF;
      v_orden := v_orden + 1;
    END LOOP;
  END LOOP;

  -- 5. Anadir TODAS las inscripciones a CADA prueba
  FOR r_prueba IN
    SELECT id FROM pruebas WHERE concurso_id = v_concurso_id
  LOOP
    v_orden := 1;
    FOR r_inscripcion IN
      SELECT i.id, em.equipo_id
      FROM inscripciones i
      LEFT JOIN equipo_miembros em ON em.inscripcion_id = i.id
      WHERE i.concurso_id = v_concurso_id
      ORDER BY i.dorsal
    LOOP
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

  RAISE NOTICE 'Participaciones creadas: %', v_contador_part;

  -- 6. Generar puntuaciones
  FOR r_prueba IN
    SELECT id, reprise_id FROM pruebas 
    WHERE concurso_id = v_concurso_id AND reprise_id IS NOT NULL
  LOOP
    v_reprise_id := r_prueba.reprise_id;

    FOR r_participacion IN
      SELECT id FROM participaciones 
      WHERE prueba_id = r_prueba.id
        AND NOT EXISTS (
          SELECT 1 FROM puntuaciones pu 
          WHERE pu.participacion_id = participaciones.id
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
            r_participacion.id, r_juez.id, r_ejercicio.id,
            ROUND((5.0 + random() * 4.5)::numeric, 1),
            'Nota de ejemplo',
            r_juez.letra
          );
          v_contador_punt := v_contador_punt + 1;
        END LOOP;
      END LOOP;
    END LOOP;
  END LOOP;

  RAISE NOTICE 'Puntuaciones creadas: %', v_contador_punt;
END $$;

-- Verificacion
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
WHERE c.nombre IN ('Primavera 2026', 'Verano 2026', 'Otono 2026')
GROUP BY c.nombre, c.fecha_inicio
ORDER BY c.fecha_inicio;