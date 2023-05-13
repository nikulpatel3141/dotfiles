#/usr/bin/env bash

HOMEBREW_PATH='/home/linuxbrew/.linuxbrew/bin/brew'

sudo apt-get update && sudo apt-get install -y \
  fish \
  g++ \
  git \
  htop

chsh -s $(which fish)

if [ ! -d "$HOMEBREW_PATH" ]; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

  brew bundle install

