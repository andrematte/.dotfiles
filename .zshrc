# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions python docker zsh-syntax-highlighting)

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
	eval "source $ZSH/oh-my-zsh.sh"
fi

alias ls='lsd --group-directories-first'
alias tree='ls --tree --depth 2'
alias python='python3'
alias pip='pip3'
alias cat='bat'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Atuin for terminal history searching
if command -v atuin &>/dev/null; then
  eval "$(atuin init zsh)"
fi

if command -v uv &>/dev/null; then
  eval "$(uv generate-shell-completion zsh)"
fi
