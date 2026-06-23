create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null check (char_length(display_name) between 1 and 50),
  avatar_path text,
  bio text check (bio is null or char_length(bio) <= 200),
  is_public boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger set_profiles_updated_at
before update on public.profiles
for each row execute function public.set_updated_at();

create table public.shops (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  name_kana text,
  description text,
  address text not null,
  prefecture_code char(2) not null check (prefecture_code ~ '^[0-9]{2}$'),
  prefecture_name text not null,
  city text,
  latitude numeric(9, 6) not null check (latitude between -90 and 90),
  longitude numeric(9, 6) not null check (longitude between -180 and 180),
  geo geography(point, 4326) generated always as (
    st_setsrid(st_makepoint(longitude::double precision, latitude::double precision), 4326)::geography
  ) stored,
  source_name text,
  source_url text,
  status text not null default 'published' check (status in ('draft', 'published', 'closed')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger set_shops_updated_at
before update on public.shops
for each row execute function public.set_updated_at();

create table public.owners (
  id uuid primary key default gen_random_uuid(),
  display_name text not null check (char_length(display_name) between 1 and 80),
  display_name_kana text,
  slug text not null unique check (slug ~ '^[a-z0-9][a-z0-9-]{1,80}$'),
  short_bio text check (short_bio is null or char_length(short_bio) <= 200),
  source_name text,
  source_url text,
  status text not null default 'published' check (status in ('draft', 'published', 'archived')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger set_owners_updated_at
before update on public.owners
for each row execute function public.set_updated_at();

create table public.owner_profiles (
  owner_id uuid primary key references public.owners(id) on delete cascade,
  portrait_path text,
  headline text check (headline is null or char_length(headline) <= 120),
  biography text,
  specialties text,
  public_notes text,
  is_featured boolean not null default false,
  updated_at timestamptz not null default now()
);

create trigger set_owner_profiles_updated_at
before update on public.owner_profiles
for each row execute function public.set_updated_at();

create table public.shop_owners (
  shop_id uuid not null references public.shops(id) on delete cascade,
  owner_id uuid not null references public.owners(id) on delete cascade,
  role text not null default 'owner',
  display_order integer not null default 0,
  started_on date,
  ended_on date,
  is_primary boolean not null default false,
  created_at timestamptz not null default now(),
  primary key (shop_id, owner_id)
);

create table public.episodes (
  id uuid primary key default gen_random_uuid(),
  aired_on date,
  title text not null,
  episode_no integer check (episode_no is null or episode_no > 0),
  source_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger set_episodes_updated_at
before update on public.episodes
for each row execute function public.set_updated_at();

create table public.shop_episodes (
  shop_id uuid not null references public.shops(id) on delete cascade,
  episode_id uuid not null references public.episodes(id) on delete cascade,
  notes text,
  created_at timestamptz not null default now(),
  primary key (shop_id, episode_id)
);

create table public.want_to_go (
  user_id uuid not null references auth.users(id) on delete cascade,
  shop_id uuid not null references public.shops(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, shop_id)
);

create table public.visit_records (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  shop_id uuid not null references public.shops(id) on delete restrict,
  visited_on date not null,
  memo text check (memo is null or char_length(memo) <= 1000),
  is_public boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger set_visit_records_updated_at
before update on public.visit_records
for each row execute function public.set_updated_at();

create table public.visit_photos (
  id uuid primary key default gen_random_uuid(),
  visit_record_id uuid not null references public.visit_records(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  shop_id uuid not null references public.shops(id) on delete restrict,
  storage_path text not null unique,
  is_public boolean not null default false,
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  constraint visit_photos_path_not_empty check (char_length(storage_path) > 0)
);
