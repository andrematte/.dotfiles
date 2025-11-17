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

ensure_uvx() {
    if command -v uvx &>/dev/null; then
        echo "uvx available."
        return
    fi

    if ! command -v uv &>/dev/null; then
        echo "uv is missing; cannot create uvx helper."
        return
    fi

    local bin_dir="${HOME}/.local/bin"
    mkdir -p "${bin_dir}"
    ln -sf "$(command -v uv)" "${bin_dir}/uvx"
    echo "Created uvx shim at ${bin_dir}/uvx."
}

install_uv
ensure_uvx
