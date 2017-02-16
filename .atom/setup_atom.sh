# update atom installed package list
# apm list --installed --bare > packages.txt

if [ -e ~/.atom ]; then
  cd ~/.atom
  ln -sf ~/dotfiles/.atom/init.coffee
  ln -sf ~/dotfiles/.atom/keymap.cson
  ln -sf ~/dotfiles/.atom/snippets.cson
  ln -sf ~/dotfiles/.atom/styles.less

  apm install --packages-file ~/dotfiles/.atom/packages.txt
fi
