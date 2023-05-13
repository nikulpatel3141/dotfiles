#/usr/bin/env bash

sudo apt-get update && sudo apt-get install \
	fish \
	htop \
	

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle install
