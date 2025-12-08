@echo off

mkdir %USERPROFILE%\.vim
mkdir %USERPROFILE%\.config
mkdir %USERPROFILE%\.config\nvim
mkdir %USERPROFILE%\.cache\dein

cd %USERPROFILE%\.cache\dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.ps1 > installer.ps1
powershell.exe ./installer.ps1 ~/.cache/dein

mklink %USERPROFILE%\.vimrc %USERPROFILE%\dotfiles\vim\.vimrc
mklink %USERPROFILE%\.gvimrc %USERPROFILE%\dotfiles\vim\.gvimrc
mklink %USERPROFILE%\.config\nvim\init.vim %USERPROFILE%\dotfiles\vim\.vimrc
mklink %USERPROFILE%\.config\nvim\keymap.rc.vim %USERPROFILE%\dotfiles\vim\keymap.rc.vim 
mklink %USERPROFILE%\.config\nvim\options.rc.vim %USERPROFILE%\dotfiles\vim\options.rc.vim

mklink %USERPROFILE%\.dein.toml %USERPROFILE%\dotfiles\vim\.dein.toml
mklink %USERPROFILE%\.dein_lazy.toml %USERPROFILE%\dotfiles\vim\.dein_lazy.toml

mklink /D %USERPROFILE%\.config\nvim\plugins %USERPROFILE%\dotfiles\vim\plugins
mklink /D %USERPROFILE%\.vim\snippets %USERPROFILE%\dotfiles\vim\snippets

pause
