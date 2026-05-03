#!/usr/bin/env zsh
set -euo pipefail

HELPERS_DIR="${HOME}/.config/sketchybar/helpers"
SBAR_LUA_DIR="${HOME}/.local/share/sketchybar_lua"

if [[ ! -d "${HELPERS_DIR}" ]]; then
    echo "Sketchybar helpers directory not found. Skipping build."
    exit 0
fi

if [[ ! -f "${SBAR_LUA_DIR}/sketchybar.so" ]]; then
    echo "Installing SbarLua..."
    git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua
    make -C /tmp/SbarLua install
    rm -rf /tmp/SbarLua
fi

echo "Building sketchybar helpers..."
make -C "${HELPERS_DIR}" all

echo "Restarting sketchybar..."
brew services restart sketchybar
