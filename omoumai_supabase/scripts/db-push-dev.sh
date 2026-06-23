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

supabase_cli link --project-ref "$PROJECT_REF"
supabase_cli db push
