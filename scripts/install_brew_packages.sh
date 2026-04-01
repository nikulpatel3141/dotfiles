#!/usr/bin/env bash
set -euo pipefail

HOMEBREW_PATH='/home/linuxbrew/.linuxbrew/bin'
BREW="$HOMEBREW_PATH/brew"

if [ ! -d "$HOMEBREW_PATH" ]; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure brew is on PATH for this session (needed after a fresh install)
eval "$("$BREW" shellenv)"

echo "Installing packages from Brewfile..."
brew bundle install --file "$(dirname "${BASH_SOURCE[0]}")/Brewfile"
