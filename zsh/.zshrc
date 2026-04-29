# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# plugins
if (( $+commands[brew] )); then
  SHARE_DIR="$(brew --prefix)/share"
  P10K_ROOT="$SHARE_DIR"
else
  SHARE_DIR="/usr/share"
  P10K_ROOT="$HOME"
fi

load_plugin() {
  [[ -r "$1" ]] && source "$1"
}

load_plugin "$P10K_ROOT/powerlevel10k/powerlevel10k.zsh-theme"
load_plugin "$SHARE_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
load_plugin "$SHARE_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# aliases
alias l="ls -CF"
alias la="ls -A"
alias ll="ls -alF"
alias ls="ls --color=auto"

# colors
DIRCOLORS_CONF="$HOME/.dircolors"

if (( $+commands[gdircolors] )); then
  eval "$(gdircolors -b "$DIRCOLORS_CONF")"
elif (( $+commands[dircolors] )); then
  eval "$(dircolors -b "$DIRCOLORS_CONF")"
fi

export CLICOLOR=1

# completion
zstyle ":completion:*" menu select
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"

# keybindings
bindkey -e
bindkey "^[[Z" reverse-menu-complete

# fzf theme
export FZF_DEFAULT_OPTS="--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
