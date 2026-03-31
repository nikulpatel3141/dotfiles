#/usr/bin/env bash

HOMEBREW_PATH='/home/linuxbrew/.linuxbrew/bin'

if [ ! -d "$HOMEBREW_PATH" ]; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homwebrew already installed, installing from Brewfile"
  brew bundle install
fi


