#!/bin/sh
set -eu
ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT"
python3 scripts/check_secrets.py
python3 -m py_compile src/carbor.py
OUT="Carbor-1.0.2-source.zip"
rm -f "$OUT"
zip -r "$OUT" . -x '.git/*' '*.pyc' '__pycache__/*' "$OUT"
sha256sum "$OUT" > "$OUT.sha256"
echo "Erstellt: $OUT und $OUT.sha256"
