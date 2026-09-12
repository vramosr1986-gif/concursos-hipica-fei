-- ============================================
-- PASO 2: Migrar datos de binomios a inscripciones
-- ============================================

INSERT INTO inscripciones (binomio_id, concurso_id, dorsal, equipo, orden_salida)
SELECT id, concurso_id, dorsal, equipo, orden_salida
FROM binomios
WHERE concurso_id IS NOT NULL
  AND dorsal IS NOT NULL;
