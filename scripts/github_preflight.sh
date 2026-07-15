#!/usr/bin/env bash
set -Eeuo pipefail
PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_DIR"

MAIN_CODE="$(find src -maxdepth 1 -type f -name 'carbor_v*.py' | sort -V | tail -n 1)"
[[ -n "$MAIN_CODE" ]] || { echo "Keine src/carbor_v*.py gefunden." >&2; exit 1; }

/usr/bin/python3 -m py_compile "$MAIN_CODE"
git status --short 2>/dev/null || true
echo "Vorprüfung erfolgreich: $MAIN_CODE"
