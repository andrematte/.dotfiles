#!/usr/bin/env zsh
set -euo pipefail

# Create main folder structure used by both Linux and macOS installs.

PROGRAMMING_DIR="${HOME}/dev"

if [[ ! -d "${PROGRAMMING_DIR}" ]]; then
    mkdir -p "${PROGRAMMING_DIR}"
    echo "Created base directory: ${PROGRAMMING_DIR}"
fi