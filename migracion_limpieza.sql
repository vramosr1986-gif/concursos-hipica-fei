-- ============================================
-- PASO 4: Limpiar binomios (quitar columnas que van a inscripciones)
-- ============================================

ALTER TABLE binomios DROP COLUMN IF EXISTS concurso_id;
ALTER TABLE binomios DROP COLUMN IF EXISTS dorsal;
ALTER TABLE binomios DROP COLUMN IF EXISTS equipo;
ALTER TABLE binomios DROP COLUMN IF EXISTS orden_salida;
