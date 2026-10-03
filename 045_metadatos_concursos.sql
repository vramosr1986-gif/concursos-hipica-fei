-- Metadatos oficiales del concurso incluidos en el avance RFHE.
ALTER TABLE concursos
ADD COLUMN IF NOT EXISTS disciplina TEXT,
ADD COLUMN IF NOT EXISTS provincia TEXT;
