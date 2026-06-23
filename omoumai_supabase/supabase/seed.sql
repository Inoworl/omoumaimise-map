insert into public.shops (
  id,
  name,
  name_kana,
  description,
  address,
  prefecture_code,
  prefecture_name,
  city,
  latitude,
  longitude,
  source_name,
  source_url,
  status
) values
  (
    '00000000-0000-4000-8000-000000000101',
    'サンプル食堂 東京',
    'さんぷるしょくどうとうきょう',
    'ローカル開発用のサンプル店舗です。',
    '東京都千代田区丸の内1-1',
    '13',
    '東京都',
    '千代田区',
    35.681236,
    139.767125,
    'local seed',
    null,
    'published'
  ),
  (
    '00000000-0000-4000-8000-000000000102',
    'サンプル食堂 名古屋',
    'さんぷるしょくどうなごや',
    '距離検索と都道府県フィルタ確認用のサンプル店舗です。',
    '愛知県名古屋市中村区名駅1-1',
    '23',
    '愛知県',
    '名古屋市',
    35.170915,
    136.881537,
    'local seed',
    null,
    'published'
  )
on conflict (id) do nothing;

insert into public.owners (
  id,
  display_name,
  display_name_kana,
  slug,
  short_bio,
  source_name,
  source_url,
  status
) values
  (
    '00000000-0000-4000-8000-000000000301',
    'サンプル店主 太郎',
    'さんぷるてんしゅたろう',
    'sample-owner-tokyo',
    '東京サンプル店舗の店主プロフィールです。',
    'local seed',
    null,
    'published'
  ),
  (
    '00000000-0000-4000-8000-000000000302',
    'サンプル女将 花子',
    'さんぷるおかみはなこ',
    'sample-owner-nagoya',
    '名古屋サンプル店舗の店主プロフィールです。',
    'local seed',
    null,
    'published'
  )
on conflict (id) do nothing;

insert into public.owner_profiles (
  owner_id,
  portrait_path,
  headline,
  biography,
  specialties,
  public_notes,
  is_featured
) values
  (
    '00000000-0000-4000-8000-000000000301',
    null,
    '大盛り定食を支えるサンプル店主',
    'ローカル開発で店主詳細ページを確認するためのプロフィール本文です。',
    '定食、仕込み、接客',
    '実在人物ではありません。',
    true
  ),
  (
    '00000000-0000-4000-8000-000000000302',
    null,
    '常連に愛されるサンプル女将',
    'ローカル開発で店主一覧ページを確認するためのプロフィール本文です。',
    '味噌料理、仕込み、店舗運営',
    '実在人物ではありません。',
    false
  )
on conflict (owner_id) do nothing;

insert into public.shop_owners (
  shop_id,
  owner_id,
  role,
  display_order,
  started_on,
  ended_on,
  is_primary
) values
  (
    '00000000-0000-4000-8000-000000000101',
    '00000000-0000-4000-8000-000000000301',
    'owner',
    1,
    null,
    null,
    true
  ),
  (
    '00000000-0000-4000-8000-000000000102',
    '00000000-0000-4000-8000-000000000302',
    'owner',
    1,
    null,
    null,
    true
  )
on conflict (shop_id, owner_id) do nothing;

insert into public.episodes (
  id,
  aired_on,
  title,
  episode_no,
  source_url
) values
  (
    '00000000-0000-4000-8000-000000000201',
    '2024-01-01',
    'サンプル放送回',
    1,
    null
  )
on conflict (id) do nothing;

insert into public.shop_episodes (shop_id, episode_id, notes)
values
  (
    '00000000-0000-4000-8000-000000000101',
    '00000000-0000-4000-8000-000000000201',
    'ローカル開発用の関連付け'
  ),
  (
    '00000000-0000-4000-8000-000000000102',
    '00000000-0000-4000-8000-000000000201',
    'ローカル開発用の関連付け'
  )
on conflict (shop_id, episode_id) do nothing;
