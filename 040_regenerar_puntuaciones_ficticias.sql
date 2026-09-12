-- 040_regenerar_puntuaciones_ficticias.sql
-- Genera puntuaciones ficticias para TODAS las participaciones sin notas

DO $$
DECLARE
  r_participacion RECORD;
  r_juez RECORD;
  r_ejercicio RECORD;
  v_ya_tiene boolean;
  v_contador int := 0;
BEGIN
  FOR r_participacion IN
    SELECT pa.id AS participacion_id, pa.prueba_id, p.reprise_id
    FROM participaciones pa
    JOIN pruebas p ON p.id = pa.prueba_id
    WHERE p.concurso_id = '7994f61f-525e-41db-a920-106b5ee99f38'
  LOOP
    FOR r_juez IN
      SELECT id, letra FROM prueba_jueces 
      WHERE prueba_id = r_participacion.prueba_id
    LOOP
      FOR r_ejercicio IN
        SELECT id FROM ejercicios_reprise 
        WHERE reprise_id = r_participacion.reprise_id
        ORDER BY numero_orden
      LOOP
        SELECT EXISTS(
          SELECT 1 FROM puntuaciones 
          WHERE participacion_id = r_participacion.participacion_id
            AND prueba_juez_id = r_juez.id
            AND ejercicio_reprise_id = r_ejercicio.id
        ) INTO v_ya_tiene;

        IF NOT v_ya_tiene THEN
          INSERT INTO puntuaciones (
            participacion_id,
            prueba_juez_id,
            ejercicio_reprise_id,
            nota,
            comentario,
            letra_juez
          ) VALUES (
            r_participacion.participacion_id,
            r_juez.id,
            r_ejercicio.id,
            ROUND((5.0 + random() * 4.5)::numeric, 1),
            'Nota de ejemplo',
            r_juez.letra
          );
          v_contador := v_contador + 1;
        END IF;
      END LOOP;
    END LOOP;
  END LOOP;

  RAISE NOTICE 'Puntuaciones creadas: %', v_contador;
END $$;

-- Verificacion: cuantas puntuaciones por prueba
SELECT 
  p.nombre AS prueba,
  COUNT(DISTINCT pa.id) AS participaciones,
  COUNT(DISTINCT pu.id) AS puntuaciones
FROM pruebas p
LEFT JOIN participaciones pa ON pa.prueba_id = p.id
LEFT JOIN puntuaciones pu ON pu.participacion_id = pa.id
WHERE p.concurso_id = '7994f61f-525e-41db-a920-106b5ee99f38'
GROUP BY p.id, p.nombre
ORDER BY p.nombre;

-- Ver por letra
SELECT letra_juez, COUNT(*) AS total
FROM puntuaciones
GROUP BY letra_juez
ORDER BY letra_juez;

-- Vista de equipos
SELECT * FROM v_clasificacion_equipos;