#!/usr/bin/env bash
set -euo pipefail

UV_BIN="$HOME/.local/bin/uv"
VENV_DIR="$HOME/.venvs/venv14"
PYTHON_VERSION="3.14"

# Install uv if not already present
if [ ! -x "$UV_BIN" ]; then
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
else
  echo "uv already installed: $("$UV_BIN" --version)"
fi

# Create Python venv if it doesn't exist or is a different Python version
if [ ! -d "$VENV_DIR" ]; then
  echo "Creating Python $PYTHON_VERSION venv at $VENV_DIR..."
  "$UV_BIN" venv --python "$PYTHON_VERSION" "$VENV_DIR"
else
  CURRENT_VERSION=$("$VENV_DIR/bin/python" --version 2>&1 | awk '{print $2}' | cut -d. -f1,2)
  if [ "$CURRENT_VERSION" != "$PYTHON_VERSION" ]; then
    echo "Venv exists but is Python $CURRENT_VERSION, recreating with Python $PYTHON_VERSION..."
    rm -rf "$VENV_DIR"
    "$UV_BIN" venv --python "$PYTHON_VERSION" "$VENV_DIR"
  else
    echo "Python $PYTHON_VERSION venv already exists at $VENV_DIR"
  fi
fi

# Install packages from requirements.txt
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/requirements.txt" ]; then
  echo "Installing packages from requirements.txt..."
  "$UV_BIN" pip install --python "$VENV_DIR/bin/python" -r "$SCRIPT_DIR/requirements.txt"
fi

echo "Done. Restart your shell or run: source ~/.config/fish/conf.d/uv.fish"
