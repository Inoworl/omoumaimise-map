# omoumai_supabase

Firebase構成における `firebase.json`、Functions、rules、indexes に相当するSupabase管理領域です。

## 管理対象

```text
supabase/
  config.toml          Supabase CLI設定
  migrations/          DB schema、PostGIS、index、RLS policy
  functions/           Edge Functions
  seed.sql             ローカル開発用データ
  tests/               DB/RLS検証
scripts/               local/dev/prod操作
```

## Firebaseとの対応

| Firebase | Supabase |
| --- | --- |
| `functions/src` | `supabase/functions/<function_name>/index.ts` |
| `firestore.rules` | migration内の `alter table ... enable row level security` と `create policy` |
| `storage.rules` | Storage bucket policy / RLS |
| `firestore.indexes.json` | migration内の `create index` |
| `firebase.json` | `supabase/config.toml` |

## 初期方針

初期バックエンドはSupabaseを採用します。Auth、Storage、RLS、PostGISを利用し、Flutterから扱う境界は `packages/supabase_common` に寄せます。

将来、DB費用やDB運用が主要課題になった場合は、NeonDB + 自前APIサーバ構成への移行または併用を検討します。そのため、DB schemaは標準PostgreSQL/PostGISを基本にし、Supabase固有機能への密結合を避けます。
