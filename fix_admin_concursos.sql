drop policy if exists "Admins can create concursos" on public.concursos;

create policy "Admins can create concursos"
on public.concursos
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
