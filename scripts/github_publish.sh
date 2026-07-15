#!/usr/bin/env bash
set -Eeuo pipefail

PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_DIR"

REPO_NAME="${CARBOR_GITHUB_REPO:-Carbor}"
VISIBILITY="${CARBOR_GITHUB_VISIBILITY:-public}"
DEFAULT_BRANCH="${CARBOR_GITHUB_BRANCH:-main}"
VERSION_FILE="$PROJECT_DIR/VERSION"

say() { printf '\n==> %s\n' "$*"; }
die() { printf '\nFEHLER: %s\n' "$*" >&2; exit 1; }

command -v git >/dev/null 2>&1 || die "Git fehlt. Installiere es mit: sudo apt install git"
command -v gh >/dev/null 2>&1 || die "GitHub CLI fehlt. Installiere sie mit: sudo apt install gh"
command -v python3 >/dev/null 2>&1 || die "Python 3 fehlt."

if ! gh auth status >/dev/null 2>&1; then
    say "Einmalige GitHub-Anmeldung wird geöffnet."
    gh auth login --web --git-protocol https
fi

OWNER="$(gh api user --jq .login)"
USER_ID="$(gh api user --jq .id)"
[[ -n "$OWNER" && -n "$USER_ID" ]] || die "GitHub-Konto konnte nicht ermittelt werden."

if [[ ! -f "$VERSION_FILE" ]]; then
    die "VERSION fehlt im Projektstamm."
fi

VERSION="$(tr -d '[:space:]' < "$VERSION_FILE")"
[[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+([.-][0-9A-Za-z.-]+)?$ ]] \
    || die "Ungültige Versionsnummer in VERSION: $VERSION"
TAG="v$VERSION"

MAIN_CODE="$(find "$PROJECT_DIR/src" -maxdepth 1 -type f -name 'carbor_v*.py' | sort -V | tail -n 1)"
[[ -n "$MAIN_CODE" && -f "$MAIN_CODE" ]] || die "Keine aktuelle Datei src/carbor_v*.py gefunden."

say "Syntaxprüfung: $(basename "$MAIN_CODE")"
/usr/bin/python3 -m py_compile "$MAIN_CODE"

say "Prüfung auf versehentlich veröffentlichte Geheimnisse"
python3 - "$PROJECT_DIR" <<'PY'
from pathlib import Path
import re, sys

root = Path(sys.argv[1])
ignored_parts = {".git", "__pycache__", "build", "dist", "release", "cache", "logs", "log"}
ignored_names = {
    "github_publish.sh",
    "github_preflight.sh",
    "carbor_git_automation_install.sh",
}
patterns = [
    ("OpenAI-Schlüssel", re.compile(r"\bsk-[A-Za-z0-9_-]{20,}\b")),
    ("GitHub-Token", re.compile(r"\bgh[pousr]_[A-Za-z0-9]{20,}\b")),
    ("TMDb-Bearer-Token", re.compile(r"\beyJ[A-Za-z0-9_-]{30,}\.[A-Za-z0-9_-]{20,}")),
    ("privater Schlüssel", re.compile(r"-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----")),
    ("allgemeines Passwort", re.compile(r"(?i)\b(password|passwd|passwort)\s*[:=]\s*['\"][^'\"]{6,}['\"]")),
]
hits = []
for path in root.rglob("*"):
    if not path.is_file() or path.name in ignored_names:
        continue
    if any(part in ignored_parts for part in path.parts):
        continue
    try:
        if path.stat().st_size > 2_000_000:
            continue
        text = path.read_text(encoding="utf-8")
    except (UnicodeDecodeError, OSError):
        continue
    for label, pattern in patterns:
        if pattern.search(text):
            hits.append(f"{path.relative_to(root)}: {label}")

if hits:
    print("\nMögliche Zugangsdaten gefunden:", file=sys.stderr)
    for hit in hits:
        print(f"  - {hit}", file=sys.stderr)
    sys.exit(2)
PY

if [[ ! -d .git ]]; then
    say "Lokales Git-Repository wird angelegt"
    git init
fi

git branch -M "$DEFAULT_BRANCH"

if ! git config user.name >/dev/null; then
    git config user.name "$OWNER"
fi
if ! git config user.email >/dev/null; then
    git config user.email "${USER_ID}+${OWNER}@users.noreply.github.com"
fi

git add -A

if git diff --cached --quiet; then
    say "Keine neuen Dateiänderungen; vorhandener Stand wird verwendet"
else
    git commit -m "Carbor $VERSION"
fi

REMOTE_URL="https://github.com/$OWNER/$REPO_NAME.git"

if gh repo view "$OWNER/$REPO_NAME" >/dev/null 2>&1; then
    say "Vorhandenes GitHub-Repository wird verwendet: $OWNER/$REPO_NAME"
else
    say "GitHub-Repository wird automatisch angelegt: $OWNER/$REPO_NAME"
    case "$VISIBILITY" in
        public)  VISIBILITY_FLAG="--public" ;;
        private) VISIBILITY_FLAG="--private" ;;
        *) die "CARBOR_GITHUB_VISIBILITY muss public oder private sein." ;;
    esac
    gh repo create "$OWNER/$REPO_NAME" "$VISIBILITY_FLAG" \
        --description "Lokale, serverfreie Medienbibliothek für Linux" \
        --source=. --remote=origin --push
fi

if git remote get-url origin >/dev/null 2>&1; then
    git remote set-url origin "$REMOTE_URL"
else
    git remote add origin "$REMOTE_URL"
fi

say "Quellcode wird hochgeladen"
git push -u origin "$DEFAULT_BRANCH"

if git rev-parse "$TAG" >/dev/null 2>&1; then
    CURRENT_TAG_COMMIT="$(git rev-list -n 1 "$TAG")"
    CURRENT_HEAD="$(git rev-parse HEAD)"
    [[ "$CURRENT_TAG_COMMIT" == "$CURRENT_HEAD" ]] \
        || die "Tag $TAG existiert bereits für einen anderen Commit. Erhöhe zuerst VERSION."
else
    git tag -a "$TAG" -m "Carbor $VERSION"
fi
git push origin "$TAG"

mkdir -p release
ASSET="release/Carbor-$VERSION-Quellcode.zip"
rm -f "$ASSET"
git archive --format=zip --prefix="Carbor-$VERSION/" -o "$ASSET" HEAD

CHANGELOG=""
for candidate in \
    "CHANGELOG-$VERSION.md" \
    "CHANGELOG.md" \
    "README.md" \
    "README-$VERSION.md"; do
    if [[ -f "$candidate" ]]; then
        CHANGELOG="$candidate"
        break
    fi
done

if gh release view "$TAG" >/dev/null 2>&1; then
    say "Bestehendes Release wird aktualisiert"
    if [[ -n "$CHANGELOG" ]]; then
        gh release edit "$TAG" --title "Carbor $VERSION" --notes-file "$CHANGELOG"
    else
        gh release edit "$TAG" --title "Carbor $VERSION"
    fi
    gh release upload "$TAG" "$ASSET" --clobber
else
    say "GitHub-Release wird erstellt"
    if [[ -n "$CHANGELOG" ]]; then
        gh release create "$TAG" "$ASSET" \
            --title "Carbor $VERSION" \
            --notes-file "$CHANGELOG" \
            --verify-tag
    else
        gh release create "$TAG" "$ASSET" \
            --title "Carbor $VERSION" \
            --generate-notes \
            --verify-tag
    fi
fi

say "Fertig"
printf 'Repository: https://github.com/%s/%s\n' "$OWNER" "$REPO_NAME"
printf 'Release:    https://github.com/%s/%s/releases/tag/%s\n' "$OWNER" "$REPO_NAME" "$TAG"
