# omoumaimise-map

オモうまい店の店舗検索、地図表示、訪問記録、活動可視化を扱う非公式アプリのモノレポです。

## 構成

```text
apps/
  mobile_flutter/      iOS / Android / Web のFlutterアプリ
  public_web_nuxt/     将来のSEO向け公開Web
packages/
  app_common/          Dart/Flutter共通ユーティリティ
  map_domain/          店舗・地図・訪問記録のドメインモデル
  supabase_common/     Flutter側のSupabase接続境界
  ts_common/           Nuxt側のTypeScript共通型
omoumai_supabase/
  supabase/            DB migration、RLS、Edge Functions、seed
docker/                開発用Dockerとポート方針
scripts/               ルート操作スクリプト
tools/                 補助ツール
```

## 初期バックエンド方針

初期リリースでは Supabase を採用します。Flutter連携、Auth、Storage、RLS、PostGISをまとめて利用でき、MVPの店舗マップ、訪問記録、プロフィール、公開設定を短い実装距離で構築しやすいためです。

利用規模が大きくなり、DBコスト、DBブランチ、検証環境、独自APIサーバ運用が主要課題になった段階で NeonDB の移行または併用を再検討します。

## 開発

Flutterアプリの起動:

```sh
cd apps/mobile_flutter
flutter pub get
flutter run -d chrome
```

静的解析:

```sh
cd apps/mobile_flutter
flutter analyze
```
