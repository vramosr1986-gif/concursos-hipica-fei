CREATE TABLE IF NOT EXISTS public.jinetes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  ldn text NOT NULL UNIQUE,
  nombre text NOT NULL,
  fecha_nacimiento date,
  comunidad text,
  federacion text NOT NULL DEFAULT 'nacional' CHECK (federacion IN ('nacional', 'territorial')),
  -- Se marca a mano tras comprobar el LDN en la web de la RFHE o de la federación territorial.
  verificado boolean NOT NULL DEFAULT false,
  verificado_en timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.caballos (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  lac text UNIQUE,
  nombre text NOT NULL,
  anio_nacimiento int,
  padre text,
  madre text,
  propietario text,
  comunidad text,
  federacion text NOT NULL DEFAULT 'nacional' CHECK (federacion IN ('nacional', 'territorial')),
  -- Se marca a mano tras comprobar el LAC en la web de la RFHE o de la federación territorial.
  verificado boolean NOT NULL DEFAULT false,
  verificado_en timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- Nullable: los binomios existentes conservan sus columnas de texto hasta migrarlos.
ALTER TABLE public.binomios
  ADD COLUMN IF NOT EXISTS jinete_id uuid REFERENCES public.jinetes(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS caballo_id uuid REFERENCES public.caballos(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS binomios_jinete_id_idx ON public.binomios (jinete_id);

ALTER TABLE public.jinetes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.caballos ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS jinetes_admin_all ON public.jinetes;
CREATE POLICY jinetes_admin_all ON public.jinetes
  FOR ALL TO authenticated
  USING (public.is_admin()) WITH CHECK (public.is_admin());

DROP POLICY IF EXISTS caballos_admin_all ON public.caballos;
CREATE POLICY caballos_admin_all ON public.caballos
  FOR ALL TO authenticated
  USING (public.is_admin()) WITH CHECK (public.is_admin());

CREATE TABLE IF NOT EXISTS public.cuentas_jinetes (
  user_id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  ldn_jinete text NOT NULL,
  jinete_id uuid REFERENCES public.jinetes(id) ON DELETE SET NULL,
  estado text NOT NULL DEFAULT 'pendiente'
    CHECK (estado IN ('pendiente', 'aprobada', 'rechazada')),
  solicitada_en timestamptz NOT NULL DEFAULT now(),
  revisada_en timestamptz,
  revisada_por uuid REFERENCES auth.users(id) ON DELETE SET NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS cuentas_jinetes_ldn_activo_idx
  ON public.cuentas_jinetes (upper(regexp_replace(trim(ldn_jinete), '\s+', '', 'g')))
  WHERE estado IN ('pendiente', 'aprobada');

ALTER TABLE public.cuentas_jinetes ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS cuentas_jinetes_select_own_or_admin ON public.cuentas_jinetes;
CREATE POLICY cuentas_jinetes_select_own_or_admin
  ON public.cuentas_jinetes
  FOR SELECT
  TO authenticated
  USING (
    user_id = auth.uid()
    OR public.is_admin()
  );

DROP POLICY IF EXISTS cuentas_jinetes_update_admin ON public.cuentas_jinetes;
CREATE POLICY cuentas_jinetes_update_admin
  ON public.cuentas_jinetes
  FOR UPDATE
  TO authenticated
  USING (public.is_admin())
  WITH CHECK (public.is_admin());

CREATE OR REPLACE FUNCTION public.crear_solicitud_cuenta_jinete()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_ldn text;
BEGIN
  IF NEW.raw_user_meta_data->>'tipo_cuenta' IS DISTINCT FROM 'jinete' THEN
    RETURN NEW;
  END IF;

  v_ldn := upper(regexp_replace(trim(coalesce(NEW.raw_user_meta_data->>'ldn_jinete', '')), '\s+', '', 'g'));
  IF v_ldn = '' THEN
    RAISE EXCEPTION 'El LDN del jinete es obligatorio';
  END IF;

  INSERT INTO public.cuentas_jinetes (user_id, ldn_jinete)
  VALUES (NEW.id, v_ldn);

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS crear_solicitud_cuenta_jinete ON auth.users;
CREATE TRIGGER crear_solicitud_cuenta_jinete
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.crear_solicitud_cuenta_jinete();
