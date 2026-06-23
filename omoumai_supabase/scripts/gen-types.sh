#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

supabase_cli() {
  if command -v supabase >/dev/null 2>&1; then
    supabase "$@"
  else
    npx supabase "$@"
  fi
}

PROJECT_REF="${SUPABASE_PROJECT_REF:-rniznpselxzinskxijea}"
OUT_FILE="../packages/ts_common/src/database.types.ts"

mkdir -p "$(dirname "$OUT_FILE")"
supabase_cli gen types typescript --project-id "$PROJECT_REF" --schema public > "$OUT_FILE"
