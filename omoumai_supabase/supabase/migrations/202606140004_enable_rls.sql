alter table public.profiles enable row level security;
alter table public.shops enable row level security;
alter table public.owners enable row level security;
alter table public.owner_profiles enable row level security;
alter table public.shop_owners enable row level security;
alter table public.episodes enable row level security;
alter table public.shop_episodes enable row level security;
alter table public.want_to_go enable row level security;
alter table public.visit_records enable row level security;
alter table public.visit_photos enable row level security;

alter table public.profiles force row level security;
alter table public.want_to_go force row level security;
alter table public.visit_records force row level security;
alter table public.visit_photos force row level security;
