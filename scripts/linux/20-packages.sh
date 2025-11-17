#!/usr/bin/env zsh
set -euo pipefail

# Install Linux-specific dependencies without relying on Homebrew.

download_if_missing() {
    local url="$1"
    local destination="$2"

    if [[ -f "${destination}" ]]; then
        return
    fi

    echo "Downloading ${url}..."
    curl -L -o "${destination}" "${url}"
}

install_jetbrains_nerd_font() {
    local fonts_dir="${HOME}/.local/share/fonts"
    local marker="${fonts_dir}/JetBrainsMonoNerdFont-Regular.ttf"

    if [[ -f "${marker}" ]]; then
        echo "JetBrainsMono Nerd Font already present. Skipping..."
        return
    fi

    if ! command -v unzip &>/dev/null; then
        echo "The 'unzip' command is required to install the font. Install unzip via your package manager and rerun."
        exit 1
    fi

    mkdir -p "${fonts_dir}"
    local tmp_dir
    tmp_dir="$(mktemp -d)"
    trap 'rm -rf "${tmp_dir}"' EXIT

    local archive="${tmp_dir}/JetBrainsMono.zip"
    download_if_missing "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" "${archive}"

    echo "Extracting JetBrainsMono Nerd Font into ${fonts_dir}..."
    unzip -o "${archive}" -d "${fonts_dir}" >/dev/null

    if command -v fc-cache &>/dev/null; then
        fc-cache -fv "${fonts_dir}" >/dev/null
    fi
}

install_uv() {
    if command -v uv &>/dev/null; then
        echo "uv already installed. Skipping..."
        return
    fi

    echo "Installing uv via Astral's installer..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
}

install_atuin() {
    if command -v atuin &>/dev/null; then
        echo "Atuin already installed. Skipping..."
        return
    fi

    echo "Installing Atuin via official installer..."
    curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | sh
}

install_powerlevel10k() {
    local theme_dir="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k"

    if [[ -d "${theme_dir}" ]]; then
        echo "Powerlevel10k already installed at ${theme_dir}. Skipping..."
        return
    fi

    if ! command -v git &>/dev/null; then
        echo "git is required to install Powerlevel10k. Install git via your package manager and rerun."
        exit 1
    fi

    echo "Installing Powerlevel10k theme for Zsh..."
    mkdir -p "$(dirname "${theme_dir}")"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${theme_dir}"
}

install_jetbrains_nerd_font
install_uv
install_atuin
install_powerlevel10k
