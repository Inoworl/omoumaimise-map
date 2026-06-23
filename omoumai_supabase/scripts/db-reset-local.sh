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

supabase_cli db reset
