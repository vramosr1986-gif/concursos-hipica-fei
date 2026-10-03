-- Datos del concurso tal como los publica RFHE (calendario y ficha):
-- tipo ("CDN***", "CDI*", "DCTOES Y/J/I/X"...) y federación territorial.
ALTER TABLE concursos
ADD COLUMN IF NOT EXISTS tipo TEXT,
ADD COLUMN IF NOT EXISTS federacion TEXT;
