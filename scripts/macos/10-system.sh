#!/usr/bin/env zsh
set -euo pipefail

# Configure macOS UI tweaks such as wallpaper, dock speed, and Xcode command line tools.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_SETTINGS="$(cd "${SCRIPT_DIR}/../.." && pwd)/settings"

set_wallpaper() {
    local image_path=""
    for candidate in "wallpaper.jpg" "wallpaper.png"; do
        if [[ -f "${DOTFILES_SETTINGS}/${candidate}" ]]; then
            image_path="${DOTFILES_SETTINGS}/${candidate}"
            break
        fi
    done

    if [[ -z "${image_path}" ]]; then
        echo "No wallpaper image found in ${DOTFILES_SETTINGS}. Skipping wallpaper change."
        return
    fi

    /usr/bin/osascript <<EOF
tell application "System Events"
    set desktopCount to count of desktops
    repeat with desktopNumber from 1 to desktopCount
        tell desktop desktopNumber
            set picture to "${image_path}"
        end tell
    end repeat
end tell
EOF
}

if command -v osascript &>/dev/null; then
    set_wallpaper
else
    echo "osascript is unavailable; skipping wallpaper configuration."
fi

if command -v defaults &>/dev/null; then
    defaults write com.apple.dock autohide-time-modifier -float 0.3
    killall Dock || true
fi

if command -v xcode-select &>/dev/null; then
    echo "Installing Xcode Command Line Tools (requires confirmation)..."
    xcode-select --install || true
    echo "Complete the installation of Xcode Command Line Tools, then press enter to continue."
    read -r
fi

echo "macOS UI setup complete."
