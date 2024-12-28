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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# aliases
alias ls="eza"
