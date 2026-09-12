CREATE TABLE IF NOT EXISTS inscripciones (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  binomio_id uuid NOT NULL REFERENCES binomios(id) ON DELETE CASCADE,
  concurso_id uuid NOT NULL REFERENCES concursos(id) ON DELETE CASCADE,
  dorsal integer NOT NULL,
  equipo text,
  orden_salida integer,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE (concurso_id, dorsal)
);

GRANT USAGE ON SCHEMA public TO service_role, authenticated, anon;
GRANT ALL ON TABLE inscripciones TO service_role, authenticated, anon;

ALTER TABLE inscripciones ENABLE ROW LEVEL SECURITY;

CREATE POLICY "inscripciones_select_authenticated" ON inscripciones
FOR SELECT TO authenticated USING (true);

CREATE POLICY "inscripciones_insert_authenticated" ON inscripciones
FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "inscripciones_update_authenticated" ON inscripciones
FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "inscripciones_delete_authenticated" ON inscripciones
FOR DELETE TO authenticated USING (true);
