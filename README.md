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

# 2. Homebrew + brew packages (see Brewfile for full list)
bash scripts/install_brew_packages.sh

# 3. Symlink dotfiles
stow byobu fish helix ipython nvim zed

# 4. Rust + rust-analyzer
bash scripts/install_rust.sh

# 5. uv + Python 3.14 venv (~/.venvs/venv14) + packages from requirements.txt
bash scripts/install_uv.sh
```

After step 3, install fish plugins:
```sh
fisher update
```

## Stow

Symlink all packages at once from the repo root:
```sh
stow byobu fish helix ipython nvim zed
```

Or symlink / remove a single package:
```sh
stow fish
stow -D fish
```

> Run `stow` from the root of this repo. By default stow targets the parent directory (`$HOME`).

---

## Shell (fish)

### Aliases

| Alias | Command | Notes |
|-------|---------|-------|
| `l` | `eza` | Coloured file listing |
| `ll` | `eza -l` | Long listing |
| `lla` | `eza -la` | Long listing including hidden |
| `cat` | `bat` | Syntax-highlighted file viewer |
| `gi` | `gitui` | Git TUI |
| `lg` | `lazygit` | Alternative git TUI |

### fzf.fish

Provides keyboard shortcuts wired to `fzf` + `fd` + `bat`:

| Shortcut | Action |
|----------|--------|
| `Ctrl+F` | Search files and paste path into command line |
| `Ctrl+R` | Search shell history across all sessions |
| `Ctrl+Alt+S` | Search running processes and paste PID |
| `Ctrl+Alt+L` | Search git log and paste commit hash |
| `Ctrl+Alt+F` | Search git status (changed files) |

### zoxide

Smarter `cd` that learns your most-visited directories.

| Command | Action |
|---------|--------|
| `z foo` | Jump to the highest-ranked directory matching `foo` |
| `zi` | Interactive fuzzy jump (uses fzf) |

### atuin

Replaces shell history with a searchable SQLite database.

| Shortcut | Action |
|----------|--------|
| `Ctrl+R` | Fuzzy-search full history with context (dir, exit code, duration) |
| `Up` arrow | Search history filtered to the current command prefix |

---

## Editors

### Neovim

Config in `nvim/.config/nvim/`. Uses [lazy.nvim](https://github.com/folke/lazy.nvim) — plugins install automatically on first launch.

#### LSP

| Language | Server | Notes |
|----------|--------|-------|
| C / C++ | `clangd` | Installed via apt |
| Python | `pylsp` | Auto-detected from `~/.venvs/` or PATH; ruff + mypy enabled |

#### Key mappings

**LSP** (active when a language server attaches):

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | List references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>f` | Format buffer |
| `[g` / `]g` | Previous / next diagnostic |

**Telescope** (fuzzy finder):

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Open buffers |
| `<leader>fh` | Help tags |

**Git (gitsigns)**:

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next / previous hunk |
| `<leader>hs` | Stage hunk (also works in visual mode) |
| `<leader>hr` | Reset hunk (also works in visual mode) |
| `<leader>hu` | Undo stage hunk |
| `<leader>hp` | Preview hunk diff |
| `<leader>gb` | Toggle inline line blame |
| `<leader>hd` | Diff this file |
| `<leader>gg` | Open lazygit (floating terminal) |

**Terminal** (`toggleterm`):

| Key | Action |
|-----|--------|
| `Ctrl+\` | Toggle floating terminal |
| `<leader>gg` | Open lazygit |
| `jk` or `Esc` | Exit terminal insert mode |

**which-key** shows all `<leader>` bindings automatically after a short pause.

### Helix

Config in `helix/.config/helix/`. Theme: monokai_pro_octagon. Python formatter: black (79 chars). Markdown formatter: prettier.

### Zed

Config in `zed/.config/zed/`. Theme: Tokyo Night. Terminal shell: fish. Format on save enabled.

---

## CLI tools

### bat

`cat` replacement with syntax highlighting, line numbers, and git change markers. Used as the previewer by fzf.fish.

### delta

Syntax-highlighted diffs for `git diff`, `git show`, `git log -p`. Configured via `~/.gitconfig` (see git stow package once added).

### fd

Fast `find` replacement. Used by telescope and fzf.fish for file search. Respects `.gitignore` by default.

### ripgrep (`rg`)

Fast grep. Used by telescope live grep and as the default grep in neovim.

---

## Misc

Swap Esc and Caps

- Linux:
  `/usr/bin/setxkbmap -option "caps:swapescape"`
- Windows: using autohotkey
  ```
  $Capslock::Esc
  $Esc::Capslock
  ```
