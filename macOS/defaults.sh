#!/bin/sh

# 参考
# https://github.com/mathiasbynens/dotfiles/blob/c495de6d15a1af43951b5964320e8e3ea587b4b5/.macos
# http://baqamore.hatenablog.com/entry/2013/07/31/222438

### Dock
# 自動で隠す
defaults write com.apple.dock autohide -bool true

### Finder
# 拡張子を表示
defaults write -g AppleShowAllExtensions -bool true
# 隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles -bool true
# デフォルトでホームフォルダを開く
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# ステータスバーを表示
defaults write com.apple.finder ShowStatusBar -bool true
# パスバーを表示
defaults write com.apple.finder ShowPathbar -bool true
# タブバーを表示
defaults write com.apple.finder ShowTabView -bool true
# ライブラリを表示
chflags nohidden ~/Library

### Terminal
# TerminalのテーマをIcebergに変更
open "$HOME/dotfiles/macOS/termcolor/terminalapp/Iceberg.terminal"
sleep 1 # Wait a bit to make sure the theme is loaded
defaults write com.apple.terminal "Default Window Settings" -string "Iceberg"
defaults write com.apple.terminal "Startup Window Settings" -string "Iceberg"

### Other
# バッテリー残量の%表示
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

killall Finder
killall Dock
