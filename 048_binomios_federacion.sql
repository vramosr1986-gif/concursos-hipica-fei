-- Federación autonómica (código FH de la RFHE: AN, CT, MA, VA...) del jinete y del caballo.
-- Se usa para mostrar la bandera de la comunidad junto al nombre.
ALTER TABLE binomios
ADD COLUMN IF NOT EXISTS fh_jinete TEXT,
ADD COLUMN IF NOT EXISTS fh_caballo TEXT;

NOTIFY pgrst, 'reload schema';
