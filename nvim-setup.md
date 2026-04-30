# Neovim from Scratch

## File Layout

```
~/.config/nvim/
├── init.lua
└── lua/
    └── config/
        ├── options.lua
        ├── keymaps.lua
        └── lazy.lua        -- bootstrap + load plugins
    └── plugins/
        ├── ui.lua
        ├── editor.lua
        ├── lsp.lua
        └── treesitter.lua
```

`init.lua` just requires each file in `config/`:
```lua
require("config.options")
require("config.keymaps")
require("config.lazy")
```

## Plugin Manager

**[lazy.nvim](https://github.com/folke/lazy.nvim)** — paste the bootstrap snippet into `config/lazy.lua`, then point it at `lua/plugins/`.

---

## Recommended Plugins

### UI (`plugins/ui.lua`)
| Plugin | Purpose |
|--------|---------|
| [catppuccin/nvim](https://github.com/catppuccin/nvim) | Colorscheme |
| [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [folke/which-key.nvim](https://github.com/folke/which-key.nvim) | Keybind hints |
| [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git diff in gutter |

### Editor (`plugins/editor.lua`)
| Plugin | Purpose |
|--------|---------|
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder (files, grep, buffers) |
| [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File tree |
| [echasnovski/mini.pairs](https://github.com/echasnovski/mini.pairs) | Auto-close brackets |
| [echasnovski/mini.surround](https://github.com/echasnovski/mini.surround) | Add/change/delete surrounds |
| [folke/flash.nvim](https://github.com/folke/flash.nvim) | Motion/jump (replaces leap/hop) |

### LSP (`plugins/lsp.lua`)
| Plugin | Purpose |
|--------|---------|
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP client configs |
| [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) | Install LSP servers |
| [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Bridge mason ↔ lspconfig |
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP completion source |
| [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippets |
| [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting (replaces null-ls) |

### Treesitter (`plugins/treesitter.lua`)
| Plugin | Purpose |
|--------|---------|
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting + textobjects |
| [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | `af`, `if`, `ac`, `ic` etc. |

---

## Notes

- **LazyVim** is a full distro built on lazy.nvim — worth reading its source for good patterns even if you don't use it directly.
- Mason handles LSP server binaries; configure servers in `lsp.lua` via `mason-lspconfig`'s `handlers` table.
- `conform.nvim` calls formatters on save; install the actual binaries (e.g. `prettierd`, `stylua`) via Mason or your system package manager.
