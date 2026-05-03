#!/usr/bin/env zsh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_ROOT="${REPO_ROOT}/scripts"

run_scripts_in_dir() {
    local dir="$1"
    local skip="${2:-}"
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
        [[ -n "${skip}" && "${script}" == *"${skip}"* ]] && continue
        echo "Running ${script}..."
        zsh "${script}"
    done
}

case "$(uname -s)" in
    Darwin)
        zsh "${SCRIPTS_ROOT}/macos/20-homebrew.sh"
        run_scripts_in_dir "${SCRIPTS_ROOT}/common"
        run_scripts_in_dir "${SCRIPTS_ROOT}/macos" "20-homebrew.sh"
        ;;
    Linux)
        run_scripts_in_dir "${SCRIPTS_ROOT}/common"
        run_scripts_in_dir "${SCRIPTS_ROOT}/linux"
        ;;
    *)
        echo "Unsupported platform $(uname -s). Add scripts under scripts/<platform>/ to continue."
        exit 1
        ;;
esac

echo "Installation Complete!"
