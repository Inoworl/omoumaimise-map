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

Firebase はメインバックエンドではなく、Android App Distribution、Push通知(FCM)、Analytics、Crashlytics、Remote Config のために併用する想定です。Firebaseの実体設定である `firebase_options.dart`、`google-services.json`、`GoogleService-Info.plist`、`firebase_app_id_file.json`、`apps/mobile_flutter/firebase.json` はローカル生成扱いとし、Gitには含めません。

FirebaseアプリID:

| 環境 | Firebase project | Android applicationId | iOS bundle id |
| --- | --- | --- | --- |
| dev | `omoumaimise-map-dev` | `com.inoworl.omoumaimise.dev` | `com.inoworl.omoumaimise.dev` |
| prod | `omoumaimise-map` | `com.inoworl.omoumaimise` | `com.inoworl.omoumaimise` |

## 開発

Flutterアプリの起動:

```sh
cd apps/mobile_flutter
fvm flutter pub get
fvm flutter run -d chrome
```

dev/prod flavorを指定する場合:

```sh
cd apps/mobile_flutter
fvm flutter run --flavor dev --dart-define-from-file=dart_define/dev_dart_define.json
fvm flutter run --flavor prod --dart-define-from-file=dart_define/prod_dart_define.json
```

静的解析:

```sh
cd apps/mobile_flutter
fvm flutter analyze
```
