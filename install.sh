#!/usr/bin/env zsh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_ROOT="${REPO_ROOT}/scripts"

run_scripts_in_dir() {
    local dir="$1"; shift
    local skips=("$@")
    if [[ ! -d "${dir}" ]]; then
        return
    fi

    local script
    local scripts=()
    while IFS= read -r script; do
        scripts+=("${script}")
    done < <(LC_ALL=C find "${dir}" -maxdepth 1 -type f -name "*.sh" | sort)

    if [[ "${#scripts[@]}" -eq 0 ]]; then
        return
    fi

    for script in "${scripts[@]}"; do
        local skip
        for skip in "${skips[@]}"; do
            [[ "${script}" == *"${skip}"* ]] && continue 2
        done
        echo "Running ${script}..."
        zsh "${script}"
    done
}

case "$(uname -s)" in
    Darwin)
        zsh "${SCRIPTS_ROOT}/macos/20-homebrew.sh"
        zsh "${SCRIPTS_ROOT}/common/stow.sh"
        run_scripts_in_dir "${SCRIPTS_ROOT}/common" "stow.sh"
        run_scripts_in_dir "${SCRIPTS_ROOT}/macos" "20-homebrew.sh"
        ;;
    Linux)
        run_scripts_in_dir "${SCRIPTS_ROOT}/linux"
        zsh "${SCRIPTS_ROOT}/common/stow.sh"
        run_scripts_in_dir "${SCRIPTS_ROOT}/common" "stow.sh"
        ;;
    *)
        echo "Unsupported platform $(uname -s). Add scripts under scripts/<platform>/ to continue."
        exit 1
        ;;
esac

echo "Installation Complete!"
