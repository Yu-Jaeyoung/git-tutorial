#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE_DIR="$REPO_ROOT/student-kit"
OUTPUT_INPUT="${1:-generated/git-workshop-student-kit.zip}"
PACKAGE_DIR_NAME="git-workshop-student-kit"

if ! command -v zip >/dev/null 2>&1; then
  echo "The 'zip' command is required but was not found." >&2
  exit 1
fi

if [[ "$OUTPUT_INPUT" = /* ]]; then
  OUTPUT_ZIP="$OUTPUT_INPUT"
else
  OUTPUT_ZIP="$REPO_ROOT/$OUTPUT_INPUT"
fi

mkdir -p "$(dirname "$OUTPUT_ZIP")"

TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/git-student-kit.XXXXXX")"
trap 'rm -rf "$TMP_ROOT"' EXIT

PACKAGE_ROOT="$TMP_ROOT/$PACKAGE_DIR_NAME"
mkdir -p "$PACKAGE_ROOT"

cp "$SOURCE_DIR/README.md" "$PACKAGE_ROOT/README.md"
cp "$SOURCE_DIR/QUICK-CHECKLIST.md" "$PACKAGE_ROOT/QUICK-CHECKLIST.md"
cp "$SOURCE_DIR/setup-student-lab.sh" "$PACKAGE_ROOT/setup-student-lab.sh"
chmod +x "$PACKAGE_ROOT/setup-student-lab.sh"

rm -f "$OUTPUT_ZIP"

(
  cd "$TMP_ROOT"
  zip -qr "$OUTPUT_ZIP" "$PACKAGE_DIR_NAME"
)

printf 'Student kit packaged at %s\n' "$OUTPUT_ZIP"
