#!/usr/bin/env zsh
set -euo pipefail

# Create symbolic links for dotfiles stored in the repository.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

# List of files/folders to symlink in ${HOME}
FILES=(
    gitconfig
    zshrc
)

for file in "${FILES[@]}"; do
    local_path="${REPO_ROOT}/.${file}"
    if [[ ! -e "${local_path}" ]]; then
        echo "Warning: ${local_path} does not exist. Skipping..."
        continue
    fi

    echo "Creating symlink to .${file} in the home directory."
    ln -sfn "${local_path}" "${HOME}/.${file}"
done
