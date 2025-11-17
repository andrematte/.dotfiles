#!/usr/bin/env zsh
set -euo pipefail

# Install common Oh My Zsh plugins required by the shared .zshrc.

ZSH_DIR="${ZSH:-${HOME}/.oh-my-zsh}"
if [[ ! -d "${ZSH_DIR}" ]]; then
    echo "Oh My Zsh is not installed yet. Skipping plugin installation."
    exit 0
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-${ZSH_DIR}/custom}"
mkdir -p "${ZSH_CUSTOM}/plugins"

typeset -A plugins
plugins=(
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
)

for plugin url in ${(kv)plugins}; do
    plugin_dir="${ZSH_CUSTOM}/plugins/${plugin}"
    if [[ -d "${plugin_dir}" ]]; then
        echo "Plugin ${plugin} already installed at ${plugin_dir}. Skipping..."
        continue
    fi

    if ! command -v git &>/dev/null; then
        echo "git is required to install ${plugin}. Install git via your package manager and rerun."
        exit 1
    fi

    echo "Installing ${plugin}..."
    git clone --depth=1 "${url}" "${plugin_dir}"
done
