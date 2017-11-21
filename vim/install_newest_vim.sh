mkdir -p ~/usr/bin
export PATH=$PATH:$HOME/usr/bin
git clone https://github.com/vim/vim.git ~/vim
cd ~/vim
git pull
cd ~/vim/src/
./configure --with-features=huge --enable-gui=gnome2 --enable-perlinterp --enable-pythoninterp --enable-rubyinterp --enable-fail-if-missing --prefix=$HOME/usr
# ./configure --with-features=huge --enable-gui=gnome2 --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-luainterp --with-luajit --with-lua-prefix=/usr/local --enable-fail-if-missing --prefix=$HOME/usr
make
make install
# echo 'alias vim="~/usr/bin/vim"' >> ~/.bashrc
# source ~/.bashrc
