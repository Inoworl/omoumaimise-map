# Docker port policy

このプロジェクトはポート管理レジストリに従い、PROJECT_ID `33` を使用します。

参照元:

```text
/Users/keisukeshimizu/Library/CloudStorage/GoogleDrive-keisukeshimizu.inoworl@gmail.com/マイドライブ/Obsidian/my-work-vault/projects/port-management-registry.md
```

## 割り当て

| サービス | 内部ポート | ホストポート | 備考 |
| --- | ---: | ---: | --- |
| Nuxt dev server | 3000 | 13300 | 将来の `apps/public_web_nuxt` |
| API/BFF | 8000 | 13301 | 将来必要になった場合 |
| Flutter web | 3000 | 13302 | Docker化する場合 |
| Supabase API | 54321 | 13321 | `omoumai_supabase/supabase/config.toml` |
| Supabase DB | 54322 | 23322 | DBは `2{PROJECT_ID}xx` 番台 |
| Supabase Studio | 54323 | 13323 | ローカル管理画面 |
| Supabase Inbucket | 54324 | 13324 | ローカルメール確認 |

Docker Composeを追加する場合は、上記のホストポートを優先します。
