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

# rbenv
eval "$(rbenv init - zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# fzf
source <(fzf --zsh)
#
# uv
eval "$(uv generate-shell-completion zsh)"

# for pet, select snippet like Ctrl-r
function pet-select() {
  LBUFFER=$(pet search --query "$LBUFFER")
  CURSOR=${#LBUFFER}
}
zle -N pet-select
bindkey "^X^R" pet-select

# mise
eval "$(mise activate zsh)"

# aliases
alias ls="eza"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
