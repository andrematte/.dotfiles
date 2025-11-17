#!/usr/bin/env zsh
set -euo pipefail

# Install Zsh + Oh My Zsh if necessary and ensure Zsh is the default shell.

if ! command -v zsh &>/dev/null; then
    echo "Zsh is not installed. Please install Zsh using your package manager and rerun the script."
    exit 1
fi

if [[ ! -d "${HOME}/.oh-my-zsh" ]]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh already installed."
fi

if [[ "${SHELL}" != "$(command -v zsh)" ]]; then
    echo "Changing the default shell to Zsh..."
    chsh -s "$(command -v zsh)"
fi
