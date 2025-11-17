#!/usr/bin/env zsh
set -euo pipefail

# Install and configure Homebrew, CLI packages, applications, and manual tasks.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"

install_homebrew() {
    if command -v brew &>/dev/null; then
        echo "Homebrew is already installed."
        return
    fi

    echo "Homebrew not installed. Installing Homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ -x "/opt/homebrew/bin/brew" ]]; then
        echo "Configuring Homebrew in PATH for Apple Silicon Mac..."
        export PATH="/opt/homebrew/bin:${PATH}"
    fi

    if ! command -v brew &>/dev/null; then
        echo "Failed to configure Homebrew in PATH. Please add Homebrew to your PATH manually."
        exit 1
    fi
}

is_formula_installed() {
    brew list --formula | grep -qx "$1"
}

is_cask_installed() {
    brew list --cask | grep -qx "$1"
}

install_package_list() {
    local type="$1"; shift
    local items=("$@")

    for item in "${items[@]}"; do
        if [[ "${type}" == "formula" ]]; then
            if is_formula_installed "${item}"; then
                echo "${item} is already installed. Skipping..."
                continue
            fi
            echo "Installing ${item}..."
            brew install "${item}"
        else
            if is_cask_installed "${item}"; then
                echo "${item} is already installed. Skipping..."
                continue
            fi
            echo "Installing ${item}..."
            brew install --cask "${item}"
        fi
    done
}

install_homebrew

brew update
brew upgrade
brew upgrade --cask
brew cleanup

formulas=(
    "bash"
    "zsh"
    "git"
    "tree"
    "font-jetbrains-mono-nerd-font"
    "python"
    "node"
    "gifski"
    # "atuin"
    "powerlevel10k"
)

apps=(
    # Apps
    "chatgpt"
    "discord"
    "drawio"
    "figma"
    "obsidian"
    "vlc"
    "zotero"

    # Development
    "devtoys"
    "docker"
    "insomnia"
    "iterm2"
    "visual-studio-code"

    # Tools
    "alt-tab"
    "appcleaner"
    "betterdisplay"
    "command-x"
    "coteditor"
    "hiddenbar"
    "keka"
    "keyboardcleantool"
    "logi-options-plus"
    "maccy"
    "rectangle"
    "shottr"
    "stats"
)

install_package_list "formula" "${formulas[@]}"
install_package_list "cask" "${apps[@]}"

echo "Changing default shell to Homebrew zsh"
homebrew_zsh="$(brew --prefix)/bin/zsh"
if ! grep -qx "${homebrew_zsh}" /etc/shells; then
    echo "${homebrew_zsh}" | sudo tee -a /etc/shells >/dev/null
fi
chsh -s "${homebrew_zsh}"

"$(brew --prefix)/bin/git" config --global user.name "${git_user_name}"
"$(brew --prefix)/bin/git" config --global user.email "${git_user_email}"

appstore=(
    "1440147259"  # AdGuard for Safari
    "409183694"   # Keynote
    "408981434"   # iMovie
    "1438243180"  # Dark Reader for Safari
    "409201541"   # Pages
    "1147396723"  # WhatsApp
    "747648890"   # Telegram
    "1233965871"  # ScreenBrush
    "409203825"   # Numbers
    "1611378436"  # Pure Paste
)

for app in "${appstore[@]}"; do
    echo "Installing ${app} from the App Store..."
    mas install "${app}"
done

brew update
brew upgrade
brew upgrade --cask
brew cleanup

echo "Open BetterDisplay and activate license. Press enter to continue..."
read -r

echo "Open Rectangle and import the settings located in ${REPO_ROOT}/settings/rectangle-config.json. Press enter to continue..."
read -r

echo "Open iTerm2 and set it up with the settings located at ${REPO_ROOT}/settings/iterm2-config.json. Press enter to continue..."
read -r

echo "Open Visual Studio Code, log in and sync settings/extensions. Press enter to continue..."
read -r

echo "Open Obsidian and set the iCloud vault location. Press enter to continue..."
read -r

echo "Open Zotero, log in and setup syncing, install plugins (Better BibTeX, Zutilo, Night for Zotero). Press enter to continue..."
read -r
