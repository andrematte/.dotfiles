#!/usr/bin/env zsh
set -euo pipefail

# Ensure the Atuin client config from the repo is symlinked into ~/.config/atuin.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
SOURCE_CONFIG="${REPO_ROOT}/settings/atuin/config.toml"
TARGET_DIR="${HOME}/.config/atuin"
TARGET_CONFIG="${TARGET_DIR}/config.toml"

if [[ ! -f "${SOURCE_CONFIG}" ]]; then
    echo "Atuin config ${SOURCE_CONFIG} not found. Skipping Atuin setup."
    exit 0
fi

mkdir -p "${TARGET_DIR}"
rm -f "${TARGET_CONFIG}"
ln -sfn "${SOURCE_CONFIG}" "${TARGET_CONFIG}"
echo "Linked ${SOURCE_CONFIG} -> ${TARGET_CONFIG}"
