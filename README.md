# Dotfiles

## Setup

This repo uses [GNU Stow](https://www.gnu.org/software/stow/) to manage symlinks. Each top-level directory is a stow package that mirrors the structure of `$HOME`.

On a fresh machine, run everything with:

```sh
bash setup.sh
```

Or step by step:

```sh
# 1. Core apt packages (fish, git, curl, byobu, clangd, stow, Zed) + sets fish as default shell
bash scripts/install_apt_packages.sh

# 2. Homebrew + brew packages (helix, neovim, eza, gh, ripgrep, fzf, fnm, pnpm, ...)
bash scripts/install_brew_packages.sh

# 3. Symlink dotfiles
stow byobu fish helix ipython nvim zed

# 4. Rust + rust-analyzer
bash scripts/install_rust.sh

# 5. uv + Python 3.14 venv (~/.venvs/venv14) + packages from requirements.txt
bash scripts/install_uv.sh
```

## Stow

Symlink all packages at once from the repo root:
```sh
stow byobu fish helix ipython nvim zed
```

Or symlink a single package:
```sh
stow fish
```

To remove symlinks for a package:
```sh
stow -D fish
```

> Run `stow` from the root of this repo. By default stow targets the parent directory (`$HOME`).

## Editors

### Neovim
Config lives in `nvim/.config/nvim/`. Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management with lazy loading enabled by default. LSP is handled natively via `nvim-lspconfig` + `nvim-cmp`:

- **clangd** — C/C++ (installed via apt)
- **pylsp** — Python (installed into `~/.venvs/` by `install_uv.sh`, auto-detected at startup)

On first launch, lazy.nvim will bootstrap itself and install all plugins automatically.

### Helix
Config lives in `helix/.config/helix/`.

### Zed
Config lives in `zed/.config/zed/`.

## Misc

Swap Esc and Caps

- Linux:
  `/usr/bin/setxkbmap -option "caps:swapescape"`
- Windows: using autohotkey
  ```
  $Capslock::Esc
  $Esc::Capslock
  ```
