-- Fechas de nacimiento solo con permiso expreso (binomios añadidos a mano).
-- Fecha y hora en que el jinete (o su tutor) aceptó que se guarden; NULL = sin permiso.
ALTER TABLE binomios
ADD COLUMN IF NOT EXISTS consentimiento_datos_at TIMESTAMPTZ;

NOTIFY pgrst, 'reload schema';
