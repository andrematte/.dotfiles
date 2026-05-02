#!/usr/bin/env zsh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
STOW_DIR="${REPO_ROOT}/stow"

if ! command -v stow &>/dev/null; then
    echo "stow not found. Install with: brew install stow"
    exit 1
fi

stow --dir="${STOW_DIR}" --target="${HOME}" --restow git zsh atuin ghostty starship claude codex aerospace borders sketchybar ssh gh
echo "Stow complete."
