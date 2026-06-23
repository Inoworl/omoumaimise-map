create policy "Anyone can read published shops"
on public.shops for select
to anon, authenticated
using (status = 'published');

create policy "Anyone can read published owners"
on public.owners for select
to anon, authenticated
using (status = 'published');

create policy "Anyone can read published owner profiles"
on public.owner_profiles for select
to anon, authenticated
using (
  exists (
    select 1
    from public.owners
    where owners.id = owner_profiles.owner_id
      and owners.status = 'published'
  )
);

create policy "Anyone can read published shop owners"
on public.shop_owners for select
to anon, authenticated
using (
  exists (
    select 1
    from public.shops
    where shops.id = shop_owners.shop_id
      and shops.status = 'published'
  )
  and exists (
    select 1
    from public.owners
    where owners.id = shop_owners.owner_id
      and owners.status = 'published'
  )
);

create policy "Anyone can read episodes"
on public.episodes for select
to anon, authenticated
using (true);

create policy "Anyone can read shop episodes"
on public.shop_episodes for select
to anon, authenticated
using (true);

create policy "Profiles are readable by owner or public users"
on public.profiles for select
to anon, authenticated
using (is_public = true or auth.uid() = id);

create policy "Users can insert own profile"
on public.profiles for insert
to authenticated
with check (auth.uid() = id);

create policy "Users can update own profile"
on public.profiles for update
to authenticated
using (auth.uid() = id)
with check (auth.uid() = id);

create policy "Users can read own want-to-go shops"
on public.want_to_go for select
to authenticated
using (auth.uid() = user_id);

create policy "Users can add own want-to-go shops"
on public.want_to_go for insert
to authenticated
with check (auth.uid() = user_id);

create policy "Users can remove own want-to-go shops"
on public.want_to_go for delete
to authenticated
using (auth.uid() = user_id);

create policy "Visit records are readable by owner or public profile"
on public.visit_records for select
to anon, authenticated
using (
  auth.uid() = user_id
  or (
    is_public = true
    and exists (
      select 1
      from public.profiles
      where profiles.id = visit_records.user_id
        and profiles.is_public = true
    )
  )
);

create policy "Users can insert own visit records"
on public.visit_records for insert
to authenticated
with check (auth.uid() = user_id);

create policy "Users can update own visit records"
on public.visit_records for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create policy "Users can delete own visit records"
on public.visit_records for delete
to authenticated
using (auth.uid() = user_id);

create policy "Visit photos are readable by owner or public visit"
on public.visit_photos for select
to anon, authenticated
using (
  auth.uid() = user_id
  or (
    is_public = true
    and exists (
      select 1
      from public.visit_records
      join public.profiles on profiles.id = visit_records.user_id
      where visit_records.id = visit_photos.visit_record_id
        and visit_records.is_public = true
        and profiles.is_public = true
    )
  )
);

create policy "Users can insert own visit photos"
on public.visit_photos for insert
to authenticated
with check (
  auth.uid() = user_id
  and exists (
    select 1
    from public.visit_records
    where visit_records.id = visit_photos.visit_record_id
      and visit_records.user_id = auth.uid()
      and visit_records.shop_id = visit_photos.shop_id
  )
);

create policy "Users can update own visit photos"
on public.visit_photos for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create policy "Users can delete own visit photos"
on public.visit_photos for delete
to authenticated
using (auth.uid() = user_id);
