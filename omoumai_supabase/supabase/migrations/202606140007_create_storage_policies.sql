insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values
  ('visit-photos', 'visit-photos', false, 10485760, array['image/jpeg', 'image/png', 'image/webp']),
  ('avatars', 'avatars', false, 2097152, array['image/jpeg', 'image/png', 'image/webp']),
  ('owner-portraits', 'owner-portraits', false, 5242880, array['image/jpeg', 'image/png', 'image/webp'])
on conflict (id) do update
set
  public = excluded.public,
  file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

create policy "Users can read own avatars"
on storage.objects for select
to authenticated
using (
  bucket_id = 'avatars'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "Public profile avatars are readable"
on storage.objects for select
to anon, authenticated
using (
  bucket_id = 'avatars'
  and exists (
    select 1
    from public.profiles
    where profiles.id = ((storage.foldername(name))[1])::uuid
      and profiles.is_public = true
  )
);

create policy "Users can write own avatars"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'avatars'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "Users can update own avatars"
on storage.objects for update
to authenticated
using (
  bucket_id = 'avatars'
  and (storage.foldername(name))[1] = auth.uid()::text
)
with check (
  bucket_id = 'avatars'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "Users can delete own avatars"
on storage.objects for delete
to authenticated
using (
  bucket_id = 'avatars'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "Published owner portraits are readable"
on storage.objects for select
to anon, authenticated
using (
  bucket_id = 'owner-portraits'
  and exists (
    select 1
    from public.owner_profiles
    join public.owners on owners.id = owner_profiles.owner_id
    where owner_profiles.portrait_path = storage.objects.name
      and owners.status = 'published'
  )
);

create policy "Users can read own visit photos"
on storage.objects for select
to authenticated
using (
  bucket_id = 'visit-photos'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "Public visit photos are readable"
on storage.objects for select
to anon, authenticated
using (
  bucket_id = 'visit-photos'
  and exists (
    select 1
    from public.visit_photos
    join public.visit_records on visit_records.id = visit_photos.visit_record_id
    join public.profiles on profiles.id = visit_photos.user_id
    where visit_photos.storage_path = storage.objects.name
      and visit_photos.is_public = true
      and visit_records.is_public = true
      and profiles.is_public = true
  )
);

create policy "Users can write own visit photos"
on storage.objects for insert
to authenticated
with check (
  bucket_id = 'visit-photos'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "Users can update own visit photos"
on storage.objects for update
to authenticated
using (
  bucket_id = 'visit-photos'
  and (storage.foldername(name))[1] = auth.uid()::text
)
with check (
  bucket_id = 'visit-photos'
  and (storage.foldername(name))[1] = auth.uid()::text
);

create policy "Users can delete own visit photos"
on storage.objects for delete
to authenticated
using (
  bucket_id = 'visit-photos'
  and (storage.foldername(name))[1] = auth.uid()::text
);
