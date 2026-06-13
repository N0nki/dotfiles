#!/bin/zsh
# homebrew
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/opt/python@3.10/libexec/bin:$PATH
export PATH=/opt/homebrew/Cellar/libpq/18.2/bin:$PATH
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
export JUST_CHOOSER="fzf --tmux 90%,70% --preview 'just --show {}'"

# eza
export EZA_CONFIG_DIR="$HOME/.config/eza"

# bat (iceberg theme)
export BAT_THEME="Iceberg"

# fzf (iceberg palette)
export FZF_DEFAULT_OPTS="
  --color=fg:#c6c8d1,bg:-1,hl:#84a0c6
  --color=fg+:#e2a478,bg+:#1e2132,hl+:#89b8c2
  --color=border:#6b7089,header:#84a0c6,gutter:-1
  --color=spinner:#e2a478,info:#84a0c6,separator:#6b7089
  --color=pointer:#e27878,marker:#b4be82,prompt:#84a0c6
  --color=label:#a093c7,query:#c6c8d1
  --border=rounded --prompt='❯ ' --pointer='▶' --marker='✓'"

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
alias cdg="cd ~/Google\ Drive/マイドライブ"
alias ls="eza"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
