export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/homebrew/bin:$PATH"

if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [[ -d "$HOME/.atuin/bin" ]]; then
  export PATH="$HOME/.atuin/bin:$PATH"
fi

if [[ -d "$HOME/.local/share/atuin/bin" ]]; then
  export PATH="$HOME/.local/share/atuin/bin:$PATH"
fi

ZSH_THEME=""

plugins=(git zsh-autosuggestions python docker zsh-syntax-highlighting)

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "source $ZSH/oh-my-zsh.sh"
fi

alias ls='lsd --group-directories-first'
alias tree='ls --tree --depth 2'
alias python='python3'
alias pip='pip3'
alias cat='bat'
alias ld='lazydocker'

if command -v atuin &>/dev/null; then
  eval "$(atuin init zsh)"
fi

if command -v uv &>/dev/null; then
  eval "$(uv generate-shell-completion zsh)"
fi

if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

function brew() {
  command brew "$@"

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# Added by Antigravity
export PATH="/Users/andrematte/.antigravity/antigravity/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/andrematte/.cache/lm-studio/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/andrematte/.bun/_bun" ] && source "/Users/andrematte/.bun/_bun"
