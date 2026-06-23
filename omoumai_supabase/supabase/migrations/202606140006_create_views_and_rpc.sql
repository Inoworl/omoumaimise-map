create or replace view public.public_visit_records
with (security_invoker = true) as
select
  visit_records.id,
  visit_records.user_id,
  visit_records.shop_id,
  visit_records.visited_on,
  visit_records.memo,
  visit_records.created_at
from public.visit_records
join public.profiles on profiles.id = visit_records.user_id
where visit_records.is_public = true
  and profiles.is_public = true;

create or replace view public.public_owner_profiles
with (security_invoker = true) as
select
  owners.id,
  owners.display_name,
  owners.display_name_kana,
  owners.slug,
  owners.short_bio,
  owner_profiles.portrait_path,
  owner_profiles.headline,
  owner_profiles.biography,
  owner_profiles.specialties,
  owner_profiles.public_notes,
  owner_profiles.is_featured,
  owners.updated_at
from public.owners
left join public.owner_profiles on owner_profiles.owner_id = owners.id
where owners.status = 'published';

create or replace view public.user_daily_visit_counts
with (security_invoker = true) as
select
  user_id,
  visited_on,
  count(*)::integer as visit_count
from public.visit_records
group by user_id, visited_on;

create or replace view public.user_shop_visit_counts
with (security_invoker = true) as
select
  user_id,
  shop_id,
  count(*)::integer as visit_count,
  max(visited_on) as last_visited_on
from public.visit_records
group by user_id, shop_id;

create or replace function public.search_shops_nearby(
  lat double precision,
  lng double precision,
  radius_m integer default 5000,
  result_limit integer default 50
)
returns table (
  id uuid,
  name text,
  address text,
  prefecture_code char(2),
  prefecture_name text,
  city text,
  latitude numeric,
  longitude numeric,
  distance_m double precision
)
language sql
stable
as $$
  select
    shops.id,
    shops.name,
    shops.address,
    shops.prefecture_code,
    shops.prefecture_name,
    shops.city,
    shops.latitude,
    shops.longitude,
    st_distance(
      shops.geo,
      st_setsrid(st_makepoint(lng, lat), 4326)::geography
    ) as distance_m
  from public.shops
  where shops.status = 'published'
    and st_dwithin(
      shops.geo,
      st_setsrid(st_makepoint(lng, lat), 4326)::geography,
      radius_m
    )
  order by distance_m asc
  limit least(greatest(result_limit, 1), 100);
$$;

grant execute on function public.search_shops_nearby(double precision, double precision, integer, integer)
to anon, authenticated;
