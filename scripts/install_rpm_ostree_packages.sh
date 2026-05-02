#! /usr/bin/env bash

rpm-ostree install -y --allow-inactive \
  fish \
  gcc-c++ \
  git \
  htop \
  python3 \
  curl \
  byobu \
  clang-tools-extra \
  stow

if [[ ! $SHELL == *fish ]]; then
  echo "Changing user shell to fish"
  chsh -s "$(which fish)"
else
  echo "User shell is already fish"
fi

echo "NOTE: rpm-ostree changes take effect after reboot."
