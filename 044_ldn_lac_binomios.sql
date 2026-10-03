-- Agregar campos LDN y LAC a tabla binomios
ALTER TABLE binomios 
ADD COLUMN IF NOT EXISTS ldn_jinete VARCHAR(50),
ADD COLUMN IF NOT EXISTS lac_caballo VARCHAR(50);

-- Crear índices para búsqueda rápida
CREATE INDEX IF NOT EXISTS idx_binomios_ldn ON binomios(ldn_jinete);
CREATE INDEX IF NOT EXISTS idx_binomios_lac ON binomios(lac_caballo);
