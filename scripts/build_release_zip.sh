#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

VERSION="$(tr -d '[:space:]' < VERSION)"
MAIN_CODE="$(find src -maxdepth 1 -type f -name 'carbor_v*.py' | sort -V | tail -n 1)"
[[ -n "$MAIN_CODE" ]] || { echo "Keine aktuelle Carbor-Datei gefunden." >&2; exit 1; }

/usr/bin/python3 scripts/check_secrets.py
/usr/bin/python3 -m py_compile "$MAIN_CODE"

mkdir -p release
OUT="release/Carbor-$VERSION-Quellcode.zip"
rm -f "$OUT" "$OUT.sha256"

git archive --format=zip --prefix="Carbor-$VERSION/" -o "$OUT" HEAD
sha256sum "$OUT" > "$OUT.sha256"

echo "Erstellt: $OUT"
echo "Prüfsumme: $OUT.sha256"
