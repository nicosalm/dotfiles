#!/usr/bin/env bash
set -e

VSCODE_USER="$HOME/Library/Application Support/Code/User"

cp "$(dirname "$0")/settings.json" "$VSCODE_USER/settings.json"
cp "$(dirname "$0")/keybindings.json" "$VSCODE_USER/keybindings.json"

xargs -L 1 code --install-extension < "$(dirname "$0")/extensions.txt"
