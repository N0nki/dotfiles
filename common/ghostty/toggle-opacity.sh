#!/bin/bash
# Toggle Ghostty background opacity between transparent and opaque

set -euo pipefail

CONFIG=$(realpath ~/.config/ghostty/config 2>/dev/null || echo ~/.config/ghostty/config)

current=$(grep -E '^background-opacity' "$CONFIG" | head -1 | awk -F'= ' '{print $2}')

if [ "$current" = "1" ]; then
    sed -i '' 's/^background-opacity = 1$/background-opacity = 0.9/' "$CONFIG"
else
    sed -i '' 's/^background-opacity = [0-9.]*/background-opacity = 1/' "$CONFIG"
fi

# macOS: Ghostty にリロードを送る（Cmd+Shift+,）
if [ "$(uname)" = "Darwin" ]; then
    /usr/bin/osascript <<'APPLESCRIPT'
if application "Ghostty" is running then
    tell application "System Events"
        tell application process "Ghostty"
            set frontmost to true
            keystroke "," using {command down, shift down}
        end tell
    end tell
end if
APPLESCRIPT
fi
