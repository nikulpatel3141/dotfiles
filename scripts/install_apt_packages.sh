#! /usr/bin/env bash

sudo apt-add-repository ppa:fish-shell/release-3

sudo apt-get update && sudo apt-get install -y \
  fish \
  g++ \
  git \
  htop \
  python3-full \
  curl

chsh -s $(which fish)
