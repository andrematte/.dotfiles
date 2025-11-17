# Personal Setup Scripts

Dotfiles and provisioning scripts that configure my development environment on macOS or Linux. The current layout separates common tasks from OS-specific tasks so each platform can evolve independently.

## Repository Layout

```
scripts/
  common/   # runs on both platforms – dotfile symlinks, shell setup, dev tooling, folders
  macos/    # macOS-only automation (wallpaper, Dock tweaks, Homebrew/apps, manual tasks)
  linux/    # Linux-only automation (placeholder for now)
settings/   # app preferences (iTerm2, Rectangle, wallpaper, etc.)
```

Common scripts run first and handle the pieces that should behave the same everywhere:

| Script | Purpose |
| ------ | ------- |
| `scripts/common/00-link-dotfiles.sh` | Symlink dotfiles into `$HOME`. |
| `scripts/common/10-shell.sh` | Ensure Zsh + Oh My Zsh are installed and set Zsh as the default shell. |
| `scripts/common/15-ohmyzsh-plugins.sh` | Install shared Oh My Zsh community plugins (autosuggestions, syntax highlighting). |
| `scripts/common/20-dev.sh` | Install shared CLI dev tooling (`uv` + `uvx` via Astral's installer). |
| `scripts/common/30-folders.sh` | Create the shared folder hierarchy under `~/Programming`. |

After that, the installer branches:

* **macOS** – `scripts/macos/*.sh` configures UI tweaks, installs Homebrew, formulae, casks, Mac App Store apps, and walks through manual post-install tasks.
* **Linux** – `scripts/linux/10-system.sh` is a placeholder for distro tweaks, while `scripts/linux/20-packages.sh` installs JetBrainsMono Nerd Font, uv, Atuin, Powerlevel10k, and CLI tools like `bat`/`lsd` through upstream installers (no Homebrew required). Extend this directory with package-manager-specific automation for your distro.

## Usage

```sh
git clone https://github.com/andrematte/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` automatically detects the OS, runs every script under `scripts/common/`, and then runs the matching platform directory (`scripts/macos/` or `scripts/linux/`). The scripts are executed in lexicographical order, so prefix new files with numbers (e.g., `40-packages.sh`) to control execution order.
