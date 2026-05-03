#!/usr/bin/env zsh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
STOW_DIR="${REPO_ROOT}/stow"

if ! command -v stow &>/dev/null; then
    echo "stow not found. Install with: brew install stow"
    exit 1
fi

PACKAGES=(git zsh atuin ghostty starship claude codex aerospace borders sketchybar ssh gh)

for pkg in "${PACKAGES[@]}"; do
    pkg_dir="${STOW_DIR}/${pkg}"
    while IFS= read -r file; do
        rel="${file#${pkg_dir}/}"
        target="${HOME}/${rel}"
        if [[ -f "${target}" && ! -L "${target}" ]]; then
            real="$(realpath "${target}" 2>/dev/null || true)"
            [[ "${real}" == "${REPO_ROOT}"* ]] && continue
            echo "Removing conflicting file: ${target}"
            rm -f "${target}"
        fi
    done < <(find "${pkg_dir}" -type f)
done

stow --dir="${STOW_DIR}" --target="${HOME}" --restow "${PACKAGES[@]}"
echo "Stow complete."
