-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Utilities (lazy-loaded, depended on by others)
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Colorscheme (eager, high priority so it loads before everything else)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("user.colorscheme")
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("user.lualine")
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("user.toggleterm")
    end,
  },

  -- Indent guides (ibl v3)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    config = function()
      require("user.indentline")
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help tags" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("user.telescope")
    end,
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("user.treesitter")
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
  },

  -- Completion + snippets (config loads LSP too so they share capabilities)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      { "L3MON4D3/LuaSnip", version = "v2.*" },
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("user.lsp")
    end,
  },

  -- Git signs: hunk navigation, inline blame, stage/reset hunks
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    config = function()
      require("user.gitsigns")
    end,
  },

  -- Which-key: shows available keybindings after leader pause
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("user.whichkey")
    end,
  },

  -- LaTeX (only loads for .tex files)
  { "lervag/vimtex", ft = "tex" },
}, {
  performance = {
    rtp = {
      -- Disable unused built-in plugins for faster startup
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})
