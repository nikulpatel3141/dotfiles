#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if command -v rpm-ostree &>/dev/null; then
  echo "==> Installing rpm-ostree packages (Fedora Atomic)..."
  bash "$DOTFILES_DIR/scripts/install_rpm_ostree_packages.sh"
elif command -v apt-get &>/dev/null; then
  echo "==> Installing apt packages..."
  bash "$DOTFILES_DIR/scripts/install_apt_packages.sh"
else
  echo "WARNING: No supported package manager found (apt-get or rpm-ostree). Skipping system packages."
fi

echo "==> Installing Homebrew and brew packages..."
bash "$DOTFILES_DIR/scripts/install_brew_packages.sh"

echo "==> Symlinking dotfiles with stow..."
cd "$DOTFILES_DIR"
if [ -f "$HOME/.claude/settings.json" ] && [ ! -L "$HOME/.claude/settings.json" ]; then
  mv "$HOME/.claude/settings.json" "$HOME/.claude/settings.json.bak"
fi
stow byobu fish git helix ipython nvim zed claude opencode

echo "==> Installing Rust..."
bash "$DOTFILES_DIR/scripts/install_rust.sh"

echo "==> Installing uv and Python venv..."
bash "$DOTFILES_DIR/scripts/install_uv.sh"

echo "==> Installing Claude Code, RTK, and LSP servers..."
bash "$DOTFILES_DIR/scripts/install_claude_dev.sh"

echo "==> Done! Restart your shell."
