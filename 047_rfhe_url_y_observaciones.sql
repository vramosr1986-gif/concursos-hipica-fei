-- Concursos importados de la RFHE: enlace de origen (si está vacío, el concurso es manual).
ALTER TABLE concursos
ADD COLUMN IF NOT EXISTS rfhe_url TEXT;

-- Observaciones de la RFHE por participación (p. ej. "Pte. Confirmación").
ALTER TABLE participaciones
ADD COLUMN IF NOT EXISTS observaciones TEXT;

NOTIFY pgrst, 'reload schema';
