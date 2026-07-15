#!/bin/sh
set -eu
TARGET="${1:-/media/fortunato/Data/Python-Projekte/Carbor}"
ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
mkdir -p "$TARGET"
cp -a "$ROOT"/. "$TARGET"/
echo "Carbor-Projekt nach $TARGET kopiert."
