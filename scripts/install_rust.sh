#!/usr/bin/env bash
set -euo pipefail

if ! command -v rustc &>/dev/null; then
  echo "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  echo "Rust already installed: $(rustc --version)"
fi

if command -v rustup &>/dev/null; then
  rustup component add rust-analyzer
fi
