#!/usr/bin/env python3
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
SCAN_ROOTS = [ROOT / "src", ROOT / "help"]
for name in ("README.md", "INSTALL.md", "PUBLISHING.md", "THIRD_PARTY_NOTICES.md"):
    path = ROOT / name
    if path.exists():
        SCAN_ROOTS.append(path)

PATTERNS = [
    re.compile(r'(?i)\b(?:api[_-]?key|access[_-]?token|read[_-]?token)\s*=\s*["\'][A-Za-z0-9._-]{16,}["\']'),
    re.compile(r'(?i)\bsk-[A-Za-z0-9_-]{16,}'),
    re.compile(r'(?i)\beyJ[A-Za-z0-9_-]{40,}\.[A-Za-z0-9_-]{20,}\.[A-Za-z0-9_-]{20,}'),
    re.compile(r'/media/fortunato/(?!Data/Python-Projekte/Carbor)'),
]

files = []
for item in SCAN_ROOTS:
    if item.is_file():
        files.append(item)
    elif item.is_dir():
        files.extend(path for path in item.rglob('*') if path.is_file())

problems = []
for path in files:
    if path.suffix.lower() in {'.png', '.ico', '.zip', '.pyc'}:
        continue
    try:
        text = path.read_text(encoding='utf-8')
    except (UnicodeDecodeError, OSError):
        continue
    for pattern in PATTERNS:
        if pattern.search(text):
            problems.append(f'{path.relative_to(ROOT)}: {pattern.pattern}')

if problems:
    print('Mögliche private Daten gefunden:')
    print('\n'.join(problems))
    sys.exit(1)
print('Keine typischen Geheimnismuster gefunden.')
