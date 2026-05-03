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
stow byobu fish git helix ipython nvim zed

# 4. Rust + rust-analyzer
bash scripts/install_rust.sh

# 5. uv + Python 3.14 venv (~/.venvs/venv14) + packages from requirements.txt
bash scripts/install_uv.sh
```

After step 3, install fish plugins:
```sh
fisher update
```

> Update the email in `git/.gitconfig` before stowing — find your noreply address at github.com/settings/emails.

## Stow

Symlink all packages at once from the repo root:
```sh
stow byobu fish git helix ipython nvim zed
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

### direnv

Auto-loads `.envrc` files when you `cd` into a directory. Complements the global `~/.venvs/venv14` activation — use it for project-specific overrides (extra env vars, a project-local venv, secrets).

Create a `.envrc` in any project directory:
```sh
# activate a project-specific venv
source .venv/bin/activate

# or set project env vars
export DATABASE_URL=postgres://localhost/mydb
export DEBUG=1
```

Then allow it once:
```sh
direnv allow
```

direnv will load/unload it automatically as you enter/leave the directory.

---

## Git

Config in `git/.gitconfig`. Uses `delta` for all diffs.

### Aliases

| Alias | Expands to | Notes |
|-------|-----------|-------|
| `git st` | `status -sb` | Short status with branch |
| `git co` | `checkout` | |
| `git br` | `branch -vv` | Branches with tracking info |
| `git lg` | `log --oneline --graph --decorate --all` | Pretty graph of all branches |
| `git last` | `log -1 HEAD --stat` | Last commit + files changed |
| `git unstage` | `restore --staged` | Unstage a file |
| `git aliases` | `config --get-regexp alias` | List all aliases |

### delta

`delta` is the default pager for all git output. Key features:

- Syntax-highlighted diffs with line numbers
- Side-by-side view by default
- Press `n` / `N` to jump between diff sections
- Merge conflicts rendered with `diff3` style

---

## Editors

### Neovim

Config in `nvim/.config/nvim/`. Uses Neovim 0.11+ native `vim.pack.add()` (no plugin manager).

Only plugin: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (with plenary.nvim).

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |

### Helix

Config in `helix/.config/helix/`. Theme: monokai_pro_octagon. Python formatter: black (79 chars). Markdown formatter: prettier.

### Zed

Config in `zed/.config/zed/`. Theme: Tokyo Night. Terminal shell: fish. Format on save enabled.

---

## CLI tools

### bat

`cat` replacement with syntax highlighting, line numbers, and git change markers. Used as the previewer by fzf.fish.

### delta

Syntax-highlighted diffs for `git diff`, `git show`, `git log -p`. Configured as the default pager in `git/.gitconfig`.

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
