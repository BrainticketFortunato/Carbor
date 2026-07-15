#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

VERSION="$(tr -d '[:space:]' < VERSION)"
/usr/bin/python3 scripts/check_secrets.py

if [[ ! -d .git ]]; then
    git init -b main
fi

git add -A
if git diff --cached --quiet; then
    echo "Keine neuen Änderungen."
else
    git commit -m "Carbor $VERSION"
fi
