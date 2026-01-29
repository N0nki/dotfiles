#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#
# This .bashrc is unified for both WSL2 and native Linux environments.
# Platform-specific configurations are handled via conditional branching.

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  if test -r ~/.dircolors; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias bat="batcat"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#
# -- my config --
#

# history
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S %a "
export HISTSIZE=10000
export HISTFILESIZE=10000
HISTCONTROL=ignoreboth
shopt -s histappend

# direnv
eval "$(direnv hook bash)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# uv
export PATH="$HOME/.local/bin:$PATH"

# cargo (Rust)
export PATH="$HOME/.cargo/bin:$PATH"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"

# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

# starship
eval "$(starship init bash)"

# Go
export PATH="$HOME/go/bin:$PATH"

# aws
export AWS_DEFAULT_REGION=ap-northeast-1

# my aliases (common)
alias fh='history | fzf'
alias aws-mfa='uv tool run aws-mfa'

#
# Platform-specific configurations
#
if [ -n "${WSL_DISTRO_NAME:-}" ]; then
  export BROWSER="wslview"

  # WSL2-specific aliases
  alias nvim='/snap/bin/nvim'
  alias cdg='cd /mnt/g/マイドライブ/'
  alias cdu='cd /mnt/c/Users/$USER'

  # for Claude Desktop Windows
  CLAUDE_DESKTOP_CONFIG="/mnt/c/Users/$USER/AppData/Roaming/Claude/claude_desktop_config.json"
  claude-desktop-aws-profile() {
    jq --arg p "$1" \
      '.mcpServers["awslabs.aws-pricing-mcp-server"].env.AWS_PROFILE = $p |
       .mcpServers["awslabs.cost-explorer-mcp-server"].env.AWS_PROFILE = $p' \
      "$CLAUDE_DESKTOP_CONFIG" >/tmp/claude_config.json &&
      mv /tmp/claude_config.json "$CLAUDE_DESKTOP_CONFIG" &&
      echo "Changed to: $1"
  }
  alias claude-desktop-aws-profile-show='jq '\''.mcpServers | to_entries[] | select(.value.env.AWS_PROFILE) | {server: .key, profile: .value.env.AWS_PROFILE}'\'' "$CLAUDE_DESKTOP_CONFIG"'

  # 1Password CLI - use Windows version for better integration
  if command -v op.exe &>/dev/null; then
    alias op='op.exe'
    source <(op.exe completion bash)
  fi
else
  # Native Linux - use native 1Password CLI if available
  if command -v op &>/dev/null; then
    source <(op completion bash)
  fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# fzf-git: Git branch/commit/tag selection with fzf
[ -f ~/dotfiles/common/fzf-git/fzf-git.sh ] && source ~/dotfiles/common/fzf-git/fzf-git.sh

# my tools
export PATH="$PATH:$HOME/sandbox/shell"

# for pet, select snippet like Ctrl-r
function pet-select() {
  BUFFER=$(pet search --query "$READLINE_LINE")
  READLINE_LINE=$BUFFER
  READLINE_POINT=${#BUFFER}
}
bind -x '"\C-x\C-r": pet-select'
. "$HOME/.cargo/env"

# terraform completion
if command -v terraform &>/dev/null; then
  complete -C "$(which terraform)" terraform
fi
