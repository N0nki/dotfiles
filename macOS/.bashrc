# macvim
alias mvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

# anacondaとpyenvのコマンド競合を回避
alias activate="source $PYENV_ROOT/versions/anaconda3-4.3.1/bin/activate"
alias deactivate="source $PYENV_ROOT/versions/anaconda3-4.3.1/bin/deactivate"

alias grep="grep --color"
alias ls='ls -G'
alias ll='ls -hl'

# vimとneovimのセッション回復
alias nvims="nvim -S ~/.vim.session"
alias vims="vim -S ~/.vim.session"
