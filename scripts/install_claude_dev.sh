#!/usr/bin/env bash
set -euo pipefail

BREW_BIN="/home/linuxbrew/.linuxbrew/bin"
FNM_BIN="$BREW_BIN/fnm"

# Activate brew PATH
eval "$("$BREW_BIN/brew" shellenv)"

# Activate fnm-managed Node so `npm -g` targets the right tree
if [ -x "$FNM_BIN" ]; then
  eval "$($FNM_BIN env --shell bash)"
fi

# ── Claude Code ───────────────────────────────────────────────────────────────
if ! command -v claude &>/dev/null; then
  echo "Installing Claude Code..."
  npm install -g @anthropic-ai/claude-code
else
  echo "Claude Code already installed: $(claude --version 2>/dev/null | head -1)"
fi

# ── RTK ───────────────────────────────────────────────────────────────────────
if [ ! -x "$BREW_BIN/rtk" ]; then
  echo "Installing rtk..."
  brew install rtk
else
  echo "rtk already installed: $("$BREW_BIN/rtk" --version 2>/dev/null)"
fi

# ── TypeScript LSP ────────────────────────────────────────────────────────────
if ! command -v typescript-language-server &>/dev/null; then
  echo "Installing typescript-language-server..."
  npm install -g typescript typescript-language-server
else
  echo "typescript-language-server already installed: $(typescript-language-server --version 2>/dev/null)"
fi

# ── Rust LSP ─────────────────────────────────────────────────────────────────
if [ -f "$HOME/.cargo/env" ]; then
  # shellcheck source=/dev/null
  source "$HOME/.cargo/env"
fi
if rustup component list 2>/dev/null | grep -q "^rust-analyzer"; then
  echo "rust-analyzer already installed"
else
  echo "Adding rust-analyzer component..."
  rustup component add rust-analyzer
fi

# ── Python LSP ────────────────────────────────────────────────────────────────
echo "Python LSP managed by install_uv.sh — skipping."

echo "==> install_claude_dev.sh complete."
