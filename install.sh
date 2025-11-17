#!/usr/bin/env zsh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_ROOT="${REPO_ROOT}/scripts"

run_scripts_in_dir() {
    local dir="$1"
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
        echo "Running ${script}..."
        zsh "${script}"
    done
}

run_scripts_in_dir "${SCRIPTS_ROOT}/common"

case "$(uname -s)" in
    Darwin)
        run_scripts_in_dir "${SCRIPTS_ROOT}/macos"
        ;;
    Linux)
        run_scripts_in_dir "${SCRIPTS_ROOT}/linux"
        ;;
    *)
        echo "Unsupported platform $(uname -s). Add scripts under scripts/<platform>/ to continue."
        exit 1
        ;;
esac

echo "Installation Complete!"
