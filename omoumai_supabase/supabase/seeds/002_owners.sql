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
  ),
  (
    '00000000-0000-4000-8000-000000000303',
    '港町 大将',
    'みなとまちたいしょう',
    'sample-owner-yokohama',
    '港町デカ盛り亭の大将プロフィールです。',
    'local seed',
    null,
    'published'
  ),
  (
    '00000000-0000-4000-8000-000000000304',
    '北国 みさき',
    'きたぐにみさき',
    'sample-owner-sapporo',
    '北国もりもり軒を切り盛りする店主プロフィールです。',
    'local seed',
    null,
    'published'
  ),
  (
    '00000000-0000-4000-8000-000000000305',
    '南風 健',
    'みなみかぜけん',
    'sample-owner-nagasaki',
    '南風ちゃんぽんの店主プロフィールです。',
    'local seed',
    null,
    'published'
  ),
  (
    '00000000-0000-4000-8000-000000000306',
    '準備中 店主',
    'じゅんびちゅうてんしゅ',
    'sample-owner-draft',
    '下書き表示制御確認用の店主プロフィールです。',
    'local seed',
    null,
    'draft'
  )
on conflict (id) do nothing;
