#/usr/bin/env bash

sudo apt-get update && sudo apt-get install -y \
  fish \
  g++ \
  htop


chsh -s $(which fish)
