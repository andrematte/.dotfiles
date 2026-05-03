#!/usr/bin/env zsh
set -euo pipefail

HELPERS_DIR="${HOME}/.config/sketchybar/helpers"

if [[ ! -d "${HELPERS_DIR}" ]]; then
    echo "Sketchybar helpers directory not found. Skipping build."
    exit 0
fi

echo "Building sketchybar helpers..."
make -C "${HELPERS_DIR}" all

echo "Restarting sketchybar..."
brew services restart sketchybar
