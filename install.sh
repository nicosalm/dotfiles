#!/usr/bin/env bash
# Symlink this dotfiles repo into place. Idempotent: re-running is safe.
# Any existing non-symlink target is backed up to ~/dotfiles-backup-<timestamp>/.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# link <source-relative-to-repo> <absolute-target>
link() {
  local src="$DOTFILES/$1" dest="$2"

  # already correctly linked → nothing to do
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok    $dest"
    return
  fi

  # back up anything real that's in the way
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mkdir -p "$BACKUP"
    mv "$dest" "$BACKUP/$(basename "$dest")"
    echo "backup $dest -> $BACKUP/"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "link  $dest -> $src"
}

link zsh/.zshrc "$HOME/.zshrc"
link zsh        "$HOME/.config/zsh"
link nvim       "$HOME/.config/nvim"
link tmux       "$HOME/.config/tmux"
link ghostty    "$HOME/.config/ghostty"

echo
echo "Done. Open a new shell, or run: exec zsh"
echo "Packages: brew bundle --file \"$DOTFILES/Brewfile\""
