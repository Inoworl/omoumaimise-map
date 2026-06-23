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

## dev project

| 項目 | 値 |
| --- | --- |
| Project name | `omoumaimise-map-dev` |
| Project ref | `rniznpselxzinskxijea` |
| URL | `https://rniznpselxzinskxijea.supabase.co` |
| REST API | `https://rniznpselxzinskxijea.supabase.co/rest/v1/` |
| Region | `Northeast Asia (Tokyo)` / `ap-northeast-1` |

publishable key はフロントエンドから見える前提の値です。安全性はkey秘匿ではなく、RLSとpolicyで担保します。`service_role`、DB password、JWT secret は絶対にGitへ含めません。

## migration方針

`supabase/migrations/` で以下を管理します。

| ファイル | 役割 |
| --- | --- |
| `*_enable_extensions.sql` | `pgcrypto`、`postgis` |
| `*_create_core_tables.sql` | `profiles`、`shops`、`episodes`、訪問記録など |
| `*_create_indexes.sql` | 検索、距離検索、公開フィード用index |
| `*_enable_rls.sql` | RLS有効化 |
| `*_create_policies.sql` | Firebase Security Rules相当 |
| `*_create_views_and_rpc.sql` | 集計View、距離検索RPC |
| `*_create_storage_policies.sql` | Storage bucketとpolicy |
| `*_grant_api_roles.sql` | Data API自動公開OFF前提の明示grant |

## schema概要

```text
auth.users
profiles
shops
owners
owner_profiles
shop_owners
episodes
shop_episodes
want_to_go
visit_records
visit_photos
```

`shops` は店舗そのものの所在地・放送情報・地図表示に必要な情報を持ちます。店主は `owners` と `owner_profiles` に分離し、店舗との関係は `shop_owners` で管理します。これにより、店主プロフィール一覧/詳細ページ、1店舗に複数店主、1店主が複数店舗に関わるケースを扱えます。

MVPでは集計値を冗長保持せず、`visit_records` からView/RPCで算出します。必要になった段階でmaterialized viewや集計テーブルを追加します。

## RLS概要

| 対象 | select | insert/update/delete |
| --- | --- | --- |
| `shops` / `owners` / `owner_profiles` / `shop_owners` / `episodes` | 全員可 | service roleのみ |
| `profiles` | 本人または公開profile | 本人のみ |
| `want_to_go` | 本人のみ | 本人のみ |
| `visit_records` | 本人または公開profileの公開訪問 | 本人のみ |
| `visit_photos` | 本人または公開profile/公開訪問の公開写真 | 本人のみ |

## Storage

| bucket | path | 方針 |
| --- | --- | --- |
| `avatars` | `{user_id}/avatar.jpg` | private bucket + policy |
| `owner-portraits` | `{owner_id}/portrait.jpg` | private bucket + published owner policy |
| `visit-photos` | `{user_id}/{visit_record_id}/{photo_id}.jpg` | private bucket + policy |

写真のEXIF/GPS詳細はアップロード前にアプリ側で削除します。

## scripts

```sh
cd omoumai_supabase

# ローカルDBをmigration + seedで作り直す
./scripts/db-reset-local.sh

# dev projectへmigrationを反映する
./scripts/db-push-dev.sh

# Supabase型をTypeScriptへ生成する
# 現時点のSupabase CLI標準はTypeScript型生成のため、
# packages/ts_common/src/database.types.ts を生成する
./scripts/gen-types.sh
```
