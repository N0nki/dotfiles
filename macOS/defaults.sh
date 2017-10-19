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

### Other
# バッテリー残量の%表示
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
