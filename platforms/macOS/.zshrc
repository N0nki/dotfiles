#!/bin/zsh
# homebrew
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/opt/python@3.10/libexec/bin:$PATH
export PATH=~/go/bin:$PATH
XDG_CONFIG_HOME=$HOME/.config

# completions
fpath=(
  ${HOME}/.zsh/completions
  ${fpath}
)
autoload -Uz compinit
compinit

# starship
eval "$(starship init zsh)"

# mise
eval "$(mise activate zsh)"

# rbenv
eval "$(rbenv init - zsh)"

# just
eval "$(just --completions zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# fzf
source <(fzf --zsh)

# fzf-git: Git branch/commit/tag selection with fzf
[ -f ~/dotfiles/common/fzf-git/fzf-git.sh ] && source ~/dotfiles/common/fzf-git/fzf-git.sh

# uv
eval "$(uv generate-shell-completion zsh)"
export PATH="$HOME/.local/bin:$PATH"

# cargo (Rust)
export PATH="$HOME/.cargo/bin:$PATH"

# for pet, select snippet like Ctrl-r
function pet-select() {
  LBUFFER=$(pet search --query "$LBUFFER")
  CURSOR=${#LBUFFER}
}
zle -N pet-select
bindkey "^X^R" pet-select

# mise
eval "$(mise activate zsh)"

# terraform completion
if command -v terraform &> /dev/null; then
  autoload -U +X bashcompinit && bashcompinit
  complete -C "$(which terraform)" terraform
fi

# aliases
alias ls="eza"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
