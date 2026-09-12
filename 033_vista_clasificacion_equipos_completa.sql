-- 033_vista_clasificacion_equipos_completa.sql
-- Vista con TODOS los miembros de cada equipo + marca de "cuenta para el equipo"

DROP VIEW IF EXISTS v_clasificacion_equipos;

CREATE OR REPLACE VIEW v_clasificacion_equipos AS
WITH puntuaciones_por_binomio AS (
  -- % final de cada binomio en cada prueba de equipos
  SELECT
    pa.id AS participacion_id,
    pa.prueba_id,
    pa.equipo_id,
    pa.inscripcion_id,
    i.dorsal,
    b.nombre_jinete,
    b.nombre_caballo,
    SUM(pu.nota * er.coeficiente) AS puntuacion_bruta,
    SUM(er.coeficiente) AS suma_coef,
    COUNT(DISTINCT pu.prueba_juez_id) AS num_jueces,
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
  -- Ranking por equipo y prueba
  SELECT
    p.*,
    e.nombre AS equipo_nombre,
    ROW_NUMBER() OVER (
      PARTITION BY p.equipo_id, p.prueba_id 
      ORDER BY p.porcentaje DESC
    ) AS posicion_miembro,
    COUNT(*) OVER (
      PARTITION BY p.equipo_id, p.prueba_id
    ) AS total_miembros_equipo
  FROM puntuaciones_por_binomio p
  JOIN equipos e ON e.id = p.equipo_id
),
resumen_equipo AS (
  -- Media de los 3 mejores
  SELECT
    equipo_id,
    prueba_id,
    ROUND(AVG(porcentaje), 2) AS puntuacion_equipo,
    ROUND(SUM(porcentaje), 2) AS suma_total
  FROM ranking_miembros
  WHERE posicion_miembro <= 3
  GROUP BY equipo_id, prueba_id
)
-- Resultado final: TODOS los miembros + marca de si cuenta o no
SELECT
  rm.equipo_id,
  rm.equipo_nombre,
  rm.prueba_id,
  re.puntuacion_equipo,
  re.suma_total,
  rm.posicion_miembro,
  (rm.posicion_miembro <= 3) AS cuenta_para_equipo,
  rm.dorsal,
  rm.nombre_jinete,
  rm.nombre_caballo,
  rm.porcentaje,
  rm.num_jueces,
  rm.total_miembros_equipo
FROM ranking_miembros rm
JOIN resumen_equipo re 
  ON re.equipo_id = rm.equipo_id AND re.prueba_id = rm.prueba_id
ORDER BY rm.prueba_id, re.puntuacion_equipo DESC, rm.posicion_miembro ASC;

-- Verificacion
SELECT * FROM v_clasificacion_equipos LIMIT 20;