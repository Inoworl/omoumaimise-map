create index shops_geo_idx on public.shops using gist (geo);
create index shops_prefecture_code_idx on public.shops (prefecture_code);
create index shops_status_idx on public.shops (status);
create index shops_name_trgm_like_idx on public.shops (name text_pattern_ops);

create index owners_slug_idx on public.owners (slug);
create index owners_status_idx on public.owners (status);
create index owners_display_name_idx on public.owners (display_name text_pattern_ops);
create index owner_profiles_featured_idx on public.owner_profiles (is_featured)
where is_featured = true;

create index shop_owners_owner_id_idx on public.shop_owners (owner_id);
create index shop_owners_shop_display_order_idx on public.shop_owners (shop_id, display_order);
create unique index shop_owners_one_primary_per_shop_idx on public.shop_owners (shop_id)
where is_primary = true;

create index episodes_aired_on_idx on public.episodes (aired_on desc);
create index shop_episodes_episode_id_idx on public.shop_episodes (episode_id);

create index want_to_go_user_created_at_idx on public.want_to_go (user_id, created_at desc);
create index want_to_go_shop_id_idx on public.want_to_go (shop_id);

create index visit_records_user_visited_on_idx on public.visit_records (user_id, visited_on desc);
create index visit_records_shop_id_idx on public.visit_records (shop_id);
create index visit_records_public_idx on public.visit_records (shop_id, visited_on desc)
where is_public = true;

create index visit_photos_visit_record_id_idx on public.visit_photos (visit_record_id, sort_order);
create index visit_photos_public_idx on public.visit_photos (shop_id, created_at desc)
where is_public = true;
