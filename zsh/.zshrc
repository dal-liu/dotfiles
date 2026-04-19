# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# plugins
if command -v brew &> /dev/null; then
  BREW_PREFIX=$(brew --prefix)

  source $BREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme
  source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# aliases
alias l="ls -CF"
alias la="ls -A"
alias ll="ls -alF"

# colors
export CLICOLOR=1
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:"

# completion
zstyle ":completion:*" menu select
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"

# keybindings
bindkey -e
bindkey "^[[Z" reverse-menu-complete

# fzf theme
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
