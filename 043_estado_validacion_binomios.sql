-- Agregar campo de estado de validacion RFHE en binomios
-- Estados: 'pendiente', 'valido', 'no_valido'

ALTER TABLE binomios 
ADD COLUMN IF NOT EXISTS estado_validacion VARCHAR(20) DEFAULT 'pendiente',
ADD CONSTRAINT estado_validacion_check CHECK (estado_validacion IN ('pendiente', 'valido', 'no_valido'));

-- Crear indice para filtrar por estado
CREATE INDEX IF NOT EXISTS idx_binomios_estado_validacion 
ON binomios(estado_validacion);

-- Comentario
COMMENT ON COLUMN binomios.estado_validacion IS 'Estado de validacion en RFHE: pendiente, valido, no_valido';
