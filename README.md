# Dotfiles

macOS development environment. Managed with GNU Stow + shell scripts.

## Quick Start

```sh
git clone https://github.com/andrematte/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` runs `scripts/common/` then `scripts/macos/` in lexicographical order.

## What Gets Installed

### Stow Packages

Symlinked into `$HOME` via `scripts/common/00-stow.sh`:

| Package | Target |
| ------- | ------ |
| `aerospace` | `~/.aerospace.toml` |
| `atuin` | `~/.config/atuin/` |
| `borders` | `~/.config/borders/` |
| `claude` | `~/.claude/` |
| `codex` | `~/.codex/` |
| `gh` | `~/.config/gh/` |
| `ghostty` | `~/.config/ghostty/` |
| `git` | `~/.gitconfig` |
| `sketchybar` | `~/.config/sketchybar/` |
| `ssh` | `~/.ssh/config` |
| `starship` | `~/.config/starship.toml` |
| `zsh` | `~/.zshrc`, `~/.zprofile`, etc. |

### Common Scripts

| Script | Purpose |
| ------ | ------- |
| `00-stow.sh` | Symlink all stow packages |
| `10-shell.sh` | Install Oh My Zsh, set Zsh as default shell |
| `15-ohmyzsh-plugins.sh` | Install autosuggestions + syntax highlighting plugins |
| `20-dev.sh` | Install `uv` + `uvx` |
| `30-folders.sh` | Create `~/Programming/` folder hierarchy |

### macOS Scripts

| Script | Purpose |
| ------ | ------- |
| `10-system.sh` | Wallpaper, Dock speed, Xcode CLT |
| `20-homebrew.sh` | Homebrew + formulas + casks + App Store apps |

See `scripts/macos/packages/` for full package lists.

## Post-Install Steps

These require manual action after `install.sh` completes:

1. **Aerospace CLI** — symlink to PATH:
   ```sh
   sudo ln -s /Applications/AeroSpace.app/Contents/MacOS/AeroSpace /usr/local/bin/aerospace
   ```
2. **BetterDisplay** — activate license
3. **Rectangle** — import `settings/macos/rectangle-config.json`
4. **VS Code** — sign in and sync settings/extensions
5. **Obsidian** — set iCloud vault location
6. **Zotero** — sign in, enable sync, install plugins (Better BibTeX, Zutilo, Night for Zotero)
7. **SSH keys** — generate or copy keys, then `ssh-add`

## Notable Tools

- **[AeroSpace](https://github.com/nicehash/AeroSpace)** — tiling window manager, config at `~/.aerospace.toml`
- **[sketchybar](https://github.com/FelixKratz/SketchyBar)** — custom menu bar, config at `~/.config/sketchybar/`
- **[borders](https://github.com/FelixKratz/JankyBorders)** — window focus borders
- **[Starship](https://starship.rs)** — shell prompt
- **[Atuin](https://atuin.sh)** — shell history sync
