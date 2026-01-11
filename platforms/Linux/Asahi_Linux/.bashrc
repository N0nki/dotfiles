#!/bin/bash

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

# my config

# disable ksshaskpass(GUI input dialog)
unset SSH_ASKPASS

# fcitx5
unset rcexport XMODIFIERS="@im=fcitx5"

# history
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S %a "
export HISTSIZE=10000
export HISTFILESIZE=10000
HISTCONTROL=ignoreboth
shopt -s histappend

# startship
eval "$(starship init bash)"

# direnv
eval "$(direnv hook bash)"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# fzf-git: Git branch/commit/tag selection with fzf
[ -f ~/dotfiles/common/fzf-git/fzf-git.sh ] && source ~/dotfiles/common/fzf-git/fzf-git.sh
