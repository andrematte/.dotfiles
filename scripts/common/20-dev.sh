#!/usr/bin/env zsh
set -euo pipefail

install_uv() {
    if command -v uv &>/dev/null; then
        echo "uv already installed. Skipping..."
        return
    fi

    echo "Installing uv via Astral's installer..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
}

verify_uvx() {
    if command -v uvx &>/dev/null; then
        echo "uvx available."
    else
        echo "uvx not found in PATH. Ensure the uv installer added its bin directory to your shell."
    fi
}

install_uv
verify_uvx
