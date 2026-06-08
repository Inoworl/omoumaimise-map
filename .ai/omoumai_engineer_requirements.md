# オモうまい店 非公式アプリ エンジニア向け要件定義書

- 文書種別: 要件定義書
- 対象読者: エンジニア・テックリード・PdM・QA
- 版数: v1.0
- 作成日: 2026-03-21
- 想定用途: 初期企画の整理、社内説明、実装検討の土台として利用。必要に応じてデザイン・法務・運用観点を追加して改訂する。

## 1. システム目的

番組で紹介された店舗データを蓄積し、ユーザーが店舗を検索・閲覧・訪問記録・継続可視化できるモバイルアプリを構築する。MVPでは、店舗データ基盤、マップ検索、訪問記録、GitHub contribution 風ヒートマップ、マイページ集計を提供する。

## 2. 対象プラットフォーム

優先度は iOS / Android のモバイルアプリ。将来的に管理画面や Web 閲覧画面を追加可能な構成を想定する。

| 領域 | 方針 |
| --- | --- |
| クライアント | Flutter |
| API/DB | Supabase(PostgreSQL) |
| 地図 | Google Maps SDK または Mapbox |
| 画像保存 | Supabase Storage / Firebase Storage |
| 分析 | Firebase Analytics または PostHog |

## 2.1 バックエンド採用方針

初期バックエンドは Supabase を採用する。

採用理由:

- Flutter クライアントから扱いやすい
- PostgreSQL / PostGIS を利用でき、店舗の位置検索・距離順・範囲検索に向く
- Auth、Storage、RLS、Edge Functions を同一基盤で扱える
- 無料枠からMVPを開始しやすい
- 将来Nuxt Webを追加しても、同じPostgreSQL schemaを基点にできる

スケール後の再検討:

- 利用規模が増え、DB費用やDB運用が主要課題になった段階で NeonDB を再検討する
- NeonDBを採用する場合は、原則として `Flutter / Nuxt -> 自前APIサーバ -> NeonDB` の構成にする
- 初期から移行しやすくするため、DB schemaは標準PostgreSQL/PostGISを基本とし、Supabase固有APIへの密結合を避ける
- Auth、Storage、RLS、Edge Functionsを使う場合も、アプリ側では `packages/supabase_common` に境界を寄せる

Firebase併用方針:

- Firebaseはメインバックエンドではなく、配布・通知・分析・クラッシュ収集の補助基盤として併用する
- Androidのテスト配布は Firebase App Distribution を利用する想定にする
- Push通知が必要になった場合は Firebase Cloud Messaging を利用する
- 分析、クラッシュ収集、機能フラグが必要になった場合は Firebase Analytics、Crashlytics、Remote Config を候補にする
- App Distribution は基本的にアプリ内Firebase SDKを必須としないが、FCM、Analytics、Crashlytics、Remote Configを使う場合はFlutterアプリ内にFirebase SDKを導入する
- `firebase_options.dart` はdev/prodを1ファイルに統合し、`FLAVOR` dart-defineで `DevFirebaseOptions` / `ProdFirebaseOptions` を切り替える
- `firebase_options.dart`、`google-services.json`、`GoogleService-Info.plist`、`firebase_app_id_file.json`、`apps/mobile_flutter/firebase.json` はローカル生成扱いとし、Gitには含めない
- Firebase project は dev=`omoumaimise-map-dev`、prod=`omoumaimise-map` を使う
- Android applicationId / iOS bundle id は dev=`com.inoworl.omoumaimise.dev`、prod=`com.inoworl.omoumaimise` とする
- Supabase接続境界とFirebase接続境界は混在させず、将来 `packages/supabase_common` と `packages/firebase_common` のように責務を分ける

## 2.2 リポジトリ構成方針

将来のNuxt Web追加を前提に、モノレポ構成で管理する。

```text
apps/
  mobile_flutter/      iOS / Android / Web のFlutterアプリ
  public_web_nuxt/     将来のSEO向け公開Web
packages/
  app_common/          Dart/Flutter共通ユーティリティ
  map_domain/          店舗・地図・訪問記録のドメインモデル
  supabase_common/     Flutter側のSupabase接続境界
  firebase_common/     将来のFCM、Analytics、Crashlytics接続境界
  ts_common/           Nuxt側のTypeScript共通型
omoumai_supabase/
  supabase/            DB migration、RLS、Edge Functions、seed
  scripts/             local/dev/prod操作
docker/                Docker構成とポート方針
scripts/               リポジトリ全体の操作
tools/                 型生成、migration検証、データ取り込み補助
```

Firebase構成の `functions`、`security_rules`、`indexes` に相当するものは、Supabaseでは `omoumai_supabase/supabase/` 配下で管理する。RLS policy と index は SQL migration に含める。

## 3. スコープ

MVP と後続機能を明確に分ける。

| 項目 | MVP | 後続 |
| --- | --- | --- |
| 店舗一覧・詳細 | ○ |  |
| 地図表示 | ○ |  |
| 地域/放送回フィルタ | ○ |  |
| 行きたい店 | ○ |  |
| 訪問記録 CRUD | ○ |  |
| 年間ヒートマップ | ○ |  |
| 継続訪問ロジック | ○ |  |
| プロフィール表示 | ○ |  |
| プロフィール公開/非公開設定 | ○ |  |
| 公開プロフィール閲覧 | △ | ○ |
| 店舗別コントリビューター表示 | △ | ○ |
| 店舗別公開訪問写真グリッド | △ | ○ |
| 全体公開フィード |  | ○ |
| バッジ・称号 |  | ○ |
| ユーザー投稿の公開共有 |  | ○ |
| SNS機能 |  | ○ |

## 4. ユースケース

主要ユースケースを以下に定義する。

| ID | ユースケース | 概要 |
| --- | --- | --- |
| UC-01 | 店舗を探す | ユーザーが地図・地域・放送回から店舗を検索する |
| UC-02 | 店舗詳細を見る | ユーザーが店舗の基本情報と自分の訪問状況を確認する |
| UC-03 | 訪問を記録する | ユーザーが訪問日、写真、メモ、再訪回数を登録する |
| UC-04 | 活動を振り返る | ユーザーがヒートマップや地域制覇率を確認する |
| UC-05 | 継続訪問店を確認する | 同じ店への継続訪問状況を確認する |
| UC-06 | プロフィールを管理する | 表示名、アイコン、自己紹介、公開/非公開を設定する |
| UC-07 | 公開プロフィールを見る | 公開設定済みユーザーの活動サマリーを見る |
| UC-08 | 店舗の訪問ユーザーを見る | 店舗ごとに公開ユーザーの訪問実績を確認する |
| UC-09 | 行きたい店を保存する | ユーザーが気になる店を後で行ける候補として保存する |
| UC-10 | 公開訪問写真を見る | 店舗詳細や公開プロフィールで公開OKの訪問写真を見る |

## 5. 画面一覧

MVP の主要画面は次の通り。

| 画面 | 主な責務 |
| --- | --- |
| ホーム | サマリー、ヒートマップ、最近訪問、次の候補 |
| 店舗一覧 | 検索、フィルタ、並び替え |
| 地図 | ピン表示、現在地近傍、店舗カード表示、行きたい保存 |
| 店舗詳細 | 店舗情報、放送回、自分の訪問履歴、公開訪問写真 |
| 訪問記録作成/編集 | 店舗確認、GPS写真、短文メモ、追加写真、公開設定 |
| マイページ | プロフィール、公開設定、訪問記録、訪問済み店、行きたい店、地域制覇率 |
| 公開プロフィール | 公開ユーザーの活動サマリー、ヒートマップ、最近の公開訪問 |
| ログイン | 認証導線 |

## 6. 機能要件

MVP で実装すべき機能要件を定義する。

| ID | 要件 |
| --- | --- |
| FR-01 | 店舗データを一覧取得できること |
| FR-02 | 店舗を都道府県・キーワード・放送回で絞り込めること |
| FR-03 | 地図上に店舗をピン表示できること |
| FR-04 | 店舗詳細で放送情報とユーザー自身の訪問情報を表示できること |
| FR-05 | 訪問記録を作成・更新・削除できること |
| FR-06 | 同一店舗の訪問回数を集計できること |
| FR-07 | 日単位の訪問数を集計しヒートマップに反映できること |
| FR-08 | 地域ごとの訪問店舗数と制覇率を算出できること |
| FR-09 | 最近訪問した店舗と継続訪問中の店舗を表示できること |
| FR-10 | 出典情報および更新日時を店舗データに保持できること |
| FR-11 | ユーザーがプロフィールを作成・更新できること |
| FR-12 | プロフィールと活動情報の公開/非公開を切り替えられること |
| FR-13 | 公開設定済みユーザーのみ公開プロフィールとして閲覧できること |
| FR-14 | 店舗詳細で公開設定済みユーザーの訪問実績を表示できること |
| FR-15 | ユーザーが店舗を「行きたい店」として保存・解除できること |
| FR-16 | 店舗詳細で公開OKの訪問写真をグリッド表示できること |
| FR-17 | マイページで訪問記録、訪問済み店、行きたい店をタブ表示できること |
| FR-18 | 訪問記録ごとに公開/非公開を設定できること |

## 7. 非機能要件

初期段階でも最低限必要な品質要件を明記する。

| 分類 | 要件 |
| --- | --- |
| 性能 | 主要一覧画面は良好な通信環境下で初回表示3秒以内を目標とする |
| 可用性 | 店舗データ読み取り失敗時でもリトライ導線を表示する |
| 拡張性 | 店舗データソース追加や管理画面追加に耐えられる構成にする |
| 保守性 | 画面・状態管理・データアクセス層を分離する |
| セキュリティ | ユーザーごとの訪問記録は本人のみ閲覧・編集可能とし、公開設定済みプロフィールおよび公開設定済み訪問記録だけを他ユーザーに公開する |
| プライバシー | GPS詳細、写真EXIF、非公開ユーザーの活動は公開画面に出さない |
| 監視 | クラッシュ・主要イベント・APIエラーを計測する |

## 8. 推奨アーキテクチャ

Flutter クライアント + BaaS を前提に、責務を次のように分ける。

- `presentation`: 画面、Widget、状態表示
- `application`: ユースケース、集計、入力バリデーション
- `domain`: Entity、ValueObject、Repository interface
- `infrastructure`: API client、DB access、Storage access
- `analytics`: イベント送信、エラートラッキング

## 9. 想定データモデル

初期 DB は店舗・放送情報・訪問記録・集計ビューを中心に設計する。

| テーブル | 主なカラム |
| --- | --- |
| shops | id, name, prefecture, city, address, lat, lng, genre, source_url, last_verified_at |
| episodes | id, aired_at, title, summary |
| shop_episode_links | shop_id, episode_id |
| user_visits | id, user_id, shop_id, visited_at, memo, rating |
| visit_photos | id, visit_id, image_url, sort_order |
| wishlisted_shops | user_id, shop_id, created_at |
| profiles | user_id, display_name, avatar_url, bio, is_public, created_at, updated_at |
| user_shop_stats | user_id, shop_id, visit_count, first_visited_at, last_visited_at |
| user_region_stats | user_id, prefecture, visited_shop_count, total_shop_count, completion_rate |
| public_user_activity | user_id, visit_date, visit_count, prefecture_count, shop_count |
| shop_contributors | shop_id, user_id, visit_date, visit_count |
| public_visit_photos | shop_id, visit_id, user_id, image_url, visited_at |

## 10. API/Repository 観点の主要操作

フロントから見た主要操作を整理する。

| 操作 | 概要 |
| --- | --- |
| `getShops()` | フィルタ条件付きで店舗一覧を取得 |
| `getShopDetail(shopId)` | 店舗詳細、放送情報、自分の訪問集計を取得 |
| `createVisit()` | 訪問記録を保存 |
| `updateVisit()` | 訪問記録を更新 |
| `deleteVisit()` | 訪問記録を削除 |
| `getVisitHeatmap(year)` | 年単位の日別訪問数を取得 |
| `getRegionProgress()` | 地域別制覇率を取得 |
| `getMyProfile()` | 自分のプロフィールと公開設定を取得 |
| `updateProfile()` | 自分のプロフィールと公開設定を更新 |
| `getPublicProfile(userId)` | 公開設定済みユーザーのプロフィールを取得 |
| `getShopContributors(shopId, date?)` | 店舗ごとの公開訪問ユーザーを取得 |
| `toggleWishlist(shopId)` | 行きたい店の保存/解除 |
| `getWishlist()` | 自分の行きたい店一覧を取得 |
| `getPublicVisitPhotos(shopId)` | 店舗ごとの公開訪問写真を取得 |

## 11. 状態管理とキャッシュ

検索条件、地図表示、認証状態、集計結果を安定的に扱うため、状態管理とキャッシュ戦略を決める。

- Flutter では Riverpod / Bloc などで責務を分離する
- 店舗一覧は検索条件単位でキャッシュする
- 店舗詳細は遷移後の体感速度向上のため事前取得を検討する
- ヒートマップや地域集計はサーバー集計または materialized view を検討する

## 12. ヒートマップ仕様

GitHub contribution 風の可視化は、単なる飾りではなく再訪・継続を促す中心機能として扱う。

| 項目 | 仕様 |
| --- | --- |
| 単位 | 日単位 |
| 色の強さ | その日の訪問件数または重み付きスコア |
| 色段階 | 0件=白、1件=薄色、2件=中間色、3件以上=濃色 |
| 入力元 | `user_visits` |
| 表示期間 | 直近1年を基本 |
| 表示形式 | GitHub contribution 風の7行カレンダーグリッド |
| UI表示名 | 訪問カレンダー |
| セル | 1セル=1日、7行=曜日、約53列=週 |
| 補助情報 | 月ラベル、曜日目安、0/1/2/3+の凡例、週/月単位の合計、継続週数、最多訪問店 |
| 操作 | セルタップで日付、訪問件数、訪問店舗を表示 |

0件の日は「活動なし」として白にする。活動がある日だけ色を付け、ユーザーが直感的に「行った日」と「行っていない日」を区別できるようにする。
ホームでは横幅に合わせた縮小版または直近90日表示を許容する。進捗/プロフィールでは直近1年のフルグリッドを表示し、一目で活動の密度が分かることを優先する。UI上では「草」と呼ばず、「訪問カレンダー」と表示する。

## 12.1 都道府県ヒートマップ仕様

都道府県ヒートマップは、日別ヒートマップとは別に「地域の開拓度」を示す機能として扱う。

| 項目 | 仕様 |
| --- | --- |
| 単位 | 都道府県 |
| 集計対象 | 過去1年のGPS確認済み訪問店舗数 |
| 集計方法 | `user_visits.shop_id` から `shops.prefecture_code` をJOINし、都道府県ごとのユニーク店舗数を集計する |
| 色段階 | 0店=白、1〜4店=薄い黄色、5〜9店=オレンジ、10店以上=赤 |
| 表示形式 | 47都道府県に分割された日本地図SVGまたは同等の型紙 |
| 操作 | MVPでは閲覧専用。都道府県タップ、下部シート、県別店舗一覧遷移は後続機能とする |
| 補助情報 | 地図下部に都道府県ランキングまたは一覧を表示し、詳細確認を補完する |

訪問回数ではなく訪問店舗数で塗る。これにより、同じ店舗への再訪だけで都道府県が濃くなりすぎることを避け、複数店舗を開拓した地域ほど濃くなる見え方にする。

## 12.2 プロフィールと公開設定

プロフィールは自分の進捗を確認する入口であり、公開設定済みユーザー同士の貢献表示にも利用する。

MVP必須:

- 表示名、アイコン、自己紹介、公開/非公開を保存できる
- 自分のプロフィールと活動サマリーをマイページで確認できる
- マイページに「訪問記録」「訪問済み店」「行きたい店」のタブを置く
- 非公開の場合、訪問記録、活動量、プロフィール詳細は本人のみ閲覧可能にする
- 公開の場合でも、GPS詳細位置、写真EXIF、非公開メモは公開しない
- 訪問記録単位でも公開/非公開を設定できる

MVP候補または後続:

- 公開プロフィール画面で活動サマリー、日別ヒートマップ、都道府県ヒートマップを表示する
- 店舗詳細で、その店に訪問した公開ユーザーを日付単位で表示する
- 店舗別コントリビューターは公開ユーザーのみ対象にする
- 店舗詳細で公開OKの訪問写真をグリッド表示する
- 全体公開フィードは後続とし、MVPでは店舗詳細とプロフィールを中心に公開記録を見せる

## 12.3 公開訪問記録の扱い

本アプリでは汎用SNSの「投稿」ではなく、店舗に紐づいた「訪問記録」を公開できる設計にする。

- 訪問記録は必ず `shop_id` に紐づく
- GPS確認済みの訪問記録のみ公開対象にできる
- 公開OKの訪問記録だけ、店舗詳細の公開訪問写真、公開コントリビューター、公開プロフィールに表示する
- 星評価はMVP必須にしない。評価SNS化を避け、短文メモと写真を中心にする
- 公開写真グリッドは「行きたい」動機を作るために使い、ネガティブ評価を目立たせる設計にはしない

## 13. 継続訪問ロジック案

飲食行動に合う継続指標を定義する。

- 週1回以上の訪問が一定週数続いているか
- 同じ店舗を月1回以上で何か月継続しているか
- 同一店舗の再訪回数が閾値を超えたか
- 新規開拓と再訪を別指標として出し分ける

## 14. 管理・運用要件

店舗情報は更新されるため、アプリ外の運用も必要となる。

- 店舗データの登録・修正用の管理導線を用意する
- 閉店・移転・情報変更の反映手順を決める
- 出典URLと最終確認日を必須項目として保持する
- ユーザー報告を採用する場合は承認フローを設ける

## 15. リスク

実装前に認識すべき主要リスクを整理する。

| リスク | 内容 | 対策 |
| --- | --- | --- |
| データ精度 | 放送当時と現在で店舗情報が異なる | 出典・確認日時を保持し、更新運用を設ける |
| 権利 | 非公式アプリとして表現に注意が必要 | ロゴや画像を無断利用しない。表記を明確化する |
| 位置情報コスト | 地図や Geocoding で課金が増える可能性 | MVP では必要最小限の利用に絞る |
| 集計負荷 | ヒートマップや制覇率計算が重くなる | 集計ビューやバッチ更新を検討する |

## 16. 今後の拡張余地

MVP 成功後に追加しやすい方向を残しておく。

- 称号・バッジ・イベント機能
- 友人との比較・共有
- 旅行ルート提案
- AIによるおすすめ店提案
- 近隣の未訪問店プッシュ通知

## 17. 開発優先順位

まずは体験の核である「見つける → 行く → 記録される → 振り返る」を最短で成立させる。

- Step 1: 店舗DBと一覧・詳細・検索
- Step 2: 地図と地域フィルタ
- Step 3: 訪問記録CRUD
- Step 4: ヒートマップとマイページ集計
- Step 5: 継続訪問ロジックの改善
