-- 035_vista_equipos_sin_flag.sql
-- Vista que detecta automaticamente las pruebas de equipos
-- (prueba con al menos 1 participacion con equipo_id no nulo)

DROP VIEW IF EXISTS v_clasificacion_equipos;

CREATE OR REPLACE VIEW v_clasificacion_equipos AS
WITH puntuaciones_por_binomio AS (
  SELECT
    pa.id AS participacion_id,
    pa.prueba_id,
    pa.equipo_id,
    pa.inscripcion_id,
    i.dorsal,
    b.nombre_jinete,
    b.nombre_caballo,
    ROUND(
      (SUM(pu.nota * er.coeficiente) * 100.0) / NULLIF(SUM(er.coeficiente) * 10, 0),
      2
    ) AS porcentaje
  FROM participaciones pa
  JOIN puntuaciones pu ON pu.participacion_id = pa.id
  JOIN ejercicios_reprise er ON er.id = pu.ejercicio_reprise_id
  JOIN inscripciones i ON i.id = pa.inscripcion_id
  JOIN binomios b ON b.id = i.binomio_id
  WHERE pa.equipo_id IS NOT NULL
  GROUP BY pa.id, pa.prueba_id, pa.equipo_id, pa.inscripcion_id, i.dorsal, b.nombre_jinete, b.nombre_caballo
),
ranking_miembros AS (
  SELECT
    p.*,
    e.nombre AS equipo_nombre,
    ROW_NUMBER() OVER (
      PARTITION BY p.equipo_id, p.prueba_id 
      ORDER BY p.porcentaje DESC
    ) AS posicion_miembro
  FROM puntuaciones_por_binomio p
  JOIN equipos e ON e.id = p.equipo_id
),
resumen_equipo AS (
  SELECT
    equipo_id,
    equipo_nombre,
    prueba_id,
    ROUND(AVG(porcentaje), 2) AS puntuacion_equipo,
    RANK() OVER (
      PARTITION BY prueba_id 
      ORDER BY AVG(porcentaje) DESC
    ) AS posicion_equipo
  FROM ranking_miembros
  WHERE posicion_miembro <= 3
  GROUP BY equipo_id, equipo_nombre, prueba_id
)
SELECT
  rm.equipo_id,
  rm.equipo_nombre,
  rm.prueba_id,
  re.puntuacion_equipo,
  re.posicion_equipo,
  rm.posicion_miembro,
  rm.dorsal,
  rm.nombre_jinete,
  rm.nombre_caballo,
  rm.porcentaje
FROM ranking_miembros rm
JOIN resumen_equipo re 
  ON re.equipo_id = rm.equipo_id AND re.prueba_id = rm.prueba_id
WHERE rm.posicion_miembro <= 3
ORDER BY rm.prueba_id, re.posicion_equipo ASC, rm.posicion_miembro ASC;

-- Verificacion
SELECT * FROM v_clasificacion_equipos;