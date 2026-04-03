#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing apt packages..."
bash "$DOTFILES_DIR/scripts/install_apt_packages.sh"

echo "==> Installing Homebrew and brew packages..."
bash "$DOTFILES_DIR/scripts/install_brew_packages.sh"

echo "==> Symlinking dotfiles with stow..."
cd "$DOTFILES_DIR"
stow byobu fish git helix ipython nvim zed

echo "==> Installing Rust..."
bash "$DOTFILES_DIR/scripts/install_rust.sh"

echo "==> Installing uv and Python venv..."
bash "$DOTFILES_DIR/scripts/install_uv.sh"

echo "==> Done! Restart your shell."
