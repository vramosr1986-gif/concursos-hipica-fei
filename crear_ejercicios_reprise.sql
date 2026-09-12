-- ============================================
-- ESTRUCTURA DE REPRISES Y EJERCICIOS
-- ============================================

-- 1. Ampliar tabla reprises
ALTER TABLE reprises
  ADD COLUMN IF NOT EXISTS codigo text,
  ADD COLUMN IF NOT EXISTS categoria text,
  ADD COLUMN IF NOT EXISTS nivel text,
  ADD COLUMN IF NOT EXISTS tipo text,
  ADD COLUMN IF NOT EXISTS anio int,
  ADD COLUMN IF NOT EXISTS tiempo_orientativo text,
  ADD COLUMN IF NOT EXISTS edad_minima_caballo int,
  ADD COLUMN IF NOT EXISTS total_maximo int,
  ADD COLUMN IF NOT EXISTS reprise_oficial text;

-- 2. Crear tabla de ejercicios
CREATE TABLE IF NOT EXISTS ejercicios_reprise (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  reprise_id uuid NOT NULL REFERENCES reprises(id) ON DELETE CASCADE,
  numero_orden int NOT NULL,
  letras text,
  movimiento text NOT NULL,
  directrices text,
  coeficiente int NOT NULL DEFAULT 1,
  puntuacion_max int NOT NULL DEFAULT 10,
  tipo text NOT NULL DEFAULT 'movimiento',
  created_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_ejercicios_reprise_id ON ejercicios_reprise(reprise_id);
CREATE INDEX IF NOT EXISTS idx_ejercicios_orden ON ejercicios_reprise(reprise_id, numero_orden);

-- 3. Permisos
GRANT USAGE ON SCHEMA public TO service_role, authenticated, anon;
GRANT ALL ON TABLE ejercicios_reprise TO service_role, authenticated, anon;
GRANT ALL ON TABLE reprises TO service_role, authenticated, anon;

-- 4. RLS en ejercicios
ALTER TABLE ejercicios_reprise ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "ejercicios_select_authenticated" ON ejercicios_reprise;
CREATE POLICY "ejercicios_select_authenticated" ON ejercicios_reprise
FOR SELECT TO authenticated USING (true);

DROP POLICY IF EXISTS "ejercicios_insert_authenticated" ON ejercicios_reprise;
CREATE POLICY "ejercicios_insert_authenticated" ON ejercicios_reprise
FOR INSERT TO authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "ejercicios_update_authenticated" ON ejercicios_reprise;
CREATE POLICY "ejercicios_update_authenticated" ON ejercicios_reprise
FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "ejercicios_delete_authenticated" ON ejercicios_reprise;
CREATE POLICY "ejercicios_delete_authenticated" ON ejercicios_reprise
FOR DELETE TO authenticated USING (true);
