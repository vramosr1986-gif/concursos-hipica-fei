-- Permisos SQL para usuarios autenticados
grant select, insert, update, delete on table public.jueces to authenticated;
grant select, insert, update, delete on table public.binomios to authenticated;
grant select, insert, update, delete on table public.reprises to authenticated;

-- =========================
-- JUECES
-- =========================

drop policy if exists "Admins can view jueces" on public.jueces;
drop policy if exists "Admins can create jueces" on public.jueces;
drop policy if exists "Admins can update jueces" on public.jueces;
drop policy if exists "Admins can delete jueces" on public.jueces;

create policy "Admins can view jueces"
on public.jueces
for select
to authenticated
using (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
);

create policy "Admins can create jueces"
on public.jueces
for insert
to authenticated
with check (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
);

create policy "Admins can update jueces"
on public.jueces
for update
to authenticated
using (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
)
with check (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
);

create policy "Admins can delete jueces"
on public.jueces
for delete
to authenticated
using (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
);

-- =========================
-- BINOMIOS
-- =========================

drop policy if exists "Admins can view binomios" on public.binomios;
drop policy if exists "Admins can create binomios" on public.binomios;
drop policy if exists "Admins can update binomios" on public.binomios;
drop policy if exists "Admins can delete binomios" on public.binomios;

create policy "Admins can view binomios"
on public.binomios
for select
to authenticated
using (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
);

create policy "Admins can create binomios"
on public.binomios
for insert
to authenticated
with check (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
);

create policy "Admins can update binomios"
on public.binomios
for update
to authenticated
using (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
)
with check (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
);

create policy "Admins can delete binomios"
on public.binomios
for delete
to authenticated
using (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
);

-- =========================
-- REPRISES
-- =========================

drop policy if exists "Admins can view reprises" on public.reprises;
drop policy if exists "Admins can create reprises" on public.reprises;
drop policy if exists "Admins can update reprises" on public.reprises;
drop policy if exists "Admins can delete reprises" on public.reprises;

create policy "Admins can view reprises"
on public.reprises
for select
to authenticated
using (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
);

create policy "Admins can create reprises"
on public.reprises
for insert
to authenticated
with check (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
);

create policy "Admins can update reprises"
on public.reprises
for update
to authenticated
using (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
)
with check (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
);

create policy "Admins can delete reprises"
on public.reprises
for delete
to authenticated
using (
  exists (
    select 1
    from public.users u
    where u.id = auth.uid()
      and u.role = 'admin'
  )
);
