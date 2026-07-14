#!/usr/bin/env bash

set -euo pipefail

usage() {
  printf 'Usage: %s <version> [--dry-run]\n' "$0" >&2
  printf 'Example: %s 1.2.0\n' "$0" >&2
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
  usage
  exit 1
fi

VERSION=$1
DRY_RUN=false
if [[ ${2:-} == "--dry-run" ]]; then
  DRY_RUN=true
elif [[ $# -eq 2 ]]; then
  usage
  exit 1
fi

if [[ ! $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  printf 'Error: version must use MAJOR.MINOR.PATCH format: %s\n' "$VERSION" >&2
  exit 1
fi

ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null) || {
  printf 'Error: this script must run inside a Git repository.\n' >&2
  exit 1
}

cd "$ROOT_DIR"

if [[ ! -f plugin.json ]]; then
  printf 'Error: plugin.json was not found at the repository root.\n' >&2
  exit 1
fi

if [[ -n $(git status --short) ]]; then
  printf 'Error: working tree is not clean. Commit or stash changes first.\n' >&2
  git status --short
  exit 1
fi

TAG="v$VERSION"
if git rev-parse "$TAG" >/dev/null 2>&1; then
  printf 'Error: tag already exists: %s\n' "$TAG" >&2
  exit 1
fi

CURRENT_VERSION=$(sed -n 's/^[[:space:]]*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' plugin.json | head -1)
if [[ -z "$CURRENT_VERSION" ]]; then
  printf 'Error: could not parse version from plugin.json.\n' >&2
  exit 1
fi
if [[ $CURRENT_VERSION == "$VERSION" ]]; then
  printf 'Error: plugin.json already has version %s.\n' "$VERSION" >&2
  exit 1
fi

printf 'Version: %s -> %s\n' "$CURRENT_VERSION" "$VERSION"
printf 'Tag: %s\n' "$TAG"

if $DRY_RUN; then
  printf 'Dry run: no files or Git references were changed.\n'
  exit 0
fi

sed -E "s/^([[:space:]]*\"version\"[[:space:]]*:[[:space:]]*\")[^\"]*(\",?.*)$/\1$VERSION\2/" plugin.json > plugin.json.tmp
mv plugin.json.tmp plugin.json

git add plugin.json
git commit -m "Release $TAG"
git tag -a "$TAG" -m "Release $TAG"
git push origin HEAD
git push origin "$TAG"

if command -v gh >/dev/null 2>&1; then
  gh release create "$TAG" --generate-notes --title "$TAG"
else
  printf 'Warning: GitHub CLI (gh) is not installed. Create the GitHub release for %s manually.\n' "$TAG" >&2
fi

printf 'Release %s published.\n' "$TAG"
