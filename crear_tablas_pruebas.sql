CREATE TABLE IF NOT EXISTS pruebas (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  concurso_id uuid NOT NULL REFERENCES concursos(id) ON DELETE CASCADE,
  reprise_id uuid REFERENCES reprises(id) ON DELETE SET NULL,
  nombre text NOT NULL,
  categoria text,
  fecha date NOT NULL,
  hora_inicio time NOT NULL,
  pista text,
  orden integer DEFAULT 1,
  estado text DEFAULT 'programada',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_pruebas_concurso ON pruebas(concurso_id);
CREATE INDEX IF NOT EXISTS idx_pruebas_fecha ON pruebas(fecha);

CREATE TABLE IF NOT EXISTS prueba_jueces (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  prueba_id uuid NOT NULL REFERENCES pruebas(id) ON DELETE CASCADE,
  juez_id uuid NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  letra text NOT NULL,
  created_at timestamptz DEFAULT now(),
  UNIQUE(prueba_id, letra)
);

CREATE INDEX IF NOT EXISTS idx_prueba_jueces_prueba ON prueba_jueces(prueba_id);

CREATE TABLE IF NOT EXISTS participaciones (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  prueba_id uuid NOT NULL REFERENCES pruebas(id) ON DELETE CASCADE,
  inscripcion_id uuid NOT NULL REFERENCES inscripciones(id) ON DELETE CASCADE,
  orden_salida integer NOT NULL,
  hora_salida time,
  estado text DEFAULT 'pendiente',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(prueba_id, inscripcion_id)
);

CREATE INDEX IF NOT EXISTS idx_participaciones_prueba ON participaciones(prueba_id);
CREATE INDEX IF NOT EXISTS idx_participaciones_inscripcion ON participaciones(inscripcion_id);

GRANT USAGE ON SCHEMA public TO service_role, authenticated, anon;
GRANT ALL ON TABLE pruebas TO service_role, authenticated, anon;
GRANT ALL ON TABLE prueba_jueces TO service_role, authenticated, anon;
GRANT ALL ON TABLE participaciones TO service_role, authenticated, anon;

ALTER TABLE pruebas ENABLE ROW LEVEL SECURITY;
ALTER TABLE prueba_jueces ENABLE ROW LEVEL SECURITY;
ALTER TABLE participaciones ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "pruebas_select" ON pruebas;
CREATE POLICY "pruebas_select" ON pruebas FOR SELECT TO authenticated USING (true);
DROP POLICY IF EXISTS "pruebas_insert" ON pruebas;
CREATE POLICY "pruebas_insert" ON pruebas FOR INSERT TO authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "pruebas_update" ON pruebas;
CREATE POLICY "pruebas_update" ON pruebas FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "pruebas_delete" ON pruebas;
CREATE POLICY "pruebas_delete" ON pruebas FOR DELETE TO authenticated USING (true);

DROP POLICY IF EXISTS "prueba_jueces_select" ON prueba_jueces;
CREATE POLICY "prueba_jueces_select" ON prueba_jueces FOR SELECT TO authenticated USING (true);
DROP POLICY IF EXISTS "prueba_jueces_insert" ON prueba_jueces;
CREATE POLICY "prueba_jueces_insert" ON prueba_jueces FOR INSERT TO authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "prueba_jueces_update" ON prueba_jueces;
CREATE POLICY "prueba_jueces_update" ON prueba_jueces FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "prueba_jueces_delete" ON prueba_jueces;
CREATE POLICY "prueba_jueces_delete" ON prueba_jueces FOR DELETE TO authenticated USING (true);

DROP POLICY IF EXISTS "participaciones_select" ON participaciones;
CREATE POLICY "participaciones_select" ON participaciones FOR SELECT TO authenticated USING (true);
DROP POLICY IF EXISTS "participaciones_insert" ON participaciones;
CREATE POLICY "participaciones_insert" ON participaciones FOR INSERT TO authenticated WITH CHECK (true);
DROP POLICY IF EXISTS "participaciones_update" ON participaciones;
CREATE POLICY "participaciones_update" ON participaciones FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "participaciones_delete" ON participaciones;
CREATE POLICY "participaciones_delete" ON participaciones FOR DELETE TO authenticated USING (true);
