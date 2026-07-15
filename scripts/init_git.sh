#!/bin/sh
set -eu
ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT"
python3 scripts/check_secrets.py
if [ ! -d .git ]; then git init -b main; fi
git add .
git commit -m "Carbor 1.0.2: Open-Source-Projektstruktur" || true
echo "Git-Projekt vorbereitet. Nun GitHub-Remote hinzufügen und pushen."
