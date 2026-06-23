grant usage on schema public to anon, authenticated;

grant select on public.shops to anon, authenticated;
grant select on public.owners to anon, authenticated;
grant select on public.owner_profiles to anon, authenticated;
grant select on public.shop_owners to anon, authenticated;
grant select on public.episodes to anon, authenticated;
grant select on public.shop_episodes to anon, authenticated;

grant select on public.profiles to anon, authenticated;
grant insert, update on public.profiles to authenticated;

grant select, insert, delete on public.want_to_go to authenticated;

grant select on public.visit_records to anon, authenticated;
grant insert, update, delete on public.visit_records to authenticated;

grant select on public.visit_photos to anon, authenticated;
grant insert, update, delete on public.visit_photos to authenticated;

grant select on public.public_owner_profiles to anon, authenticated;
grant select on public.public_visit_records to anon, authenticated;
grant select on public.user_daily_visit_counts to authenticated;
grant select on public.user_shop_visit_counts to authenticated;
