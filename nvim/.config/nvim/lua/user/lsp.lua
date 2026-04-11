local cmp = require("cmp")
local luasnip = require("luasnip")
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- nvim-cmp setup
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"]   = cmp.mapping.scroll_docs(-4),
    ["<C-f>"]   = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"]    = cmp.mapping.confirm({ select = true }),
    ["<Tab>"]   = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

-- Keymaps set on LSP attach
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd",         vim.lsp.buf.definition,                    opts)
  vim.keymap.set("n", "gy",         vim.lsp.buf.type_definition,               opts)
  vim.keymap.set("n", "gi",         vim.lsp.buf.implementation,                opts)
  vim.keymap.set("n", "gr",         vim.lsp.buf.references,                    opts)
  vim.keymap.set("n", "K",          vim.lsp.buf.hover,                         opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,                        opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,                   opts)
  vim.keymap.set("n", "<leader>f",  function() vim.lsp.buf.format({ async = true }) end, opts)
  vim.keymap.set("n", "[g",         vim.diagnostic.goto_prev,                  opts)
  vim.keymap.set("n", "]g",         vim.diagnostic.goto_next,                  opts)
  vim.keymap.set("n", "<space>a",   vim.diagnostic.setloclist,                 opts)
end

-- C / C++
lspconfig.clangd.setup({
  on_attach    = on_attach,
  capabilities = capabilities,
})

-- Locate pylsp: prefer PATH (activated venv / system install), then scan ~/.venvs/*
local function find_pylsp()
  local in_path = vim.fn.exepath("pylsp")
  if in_path ~= "" then return in_path end
  local found = vim.fn.glob(vim.fn.expand("~/.venvs/*/bin/pylsp"), false, true)
  if #found > 0 then return found[1] end
  return "pylsp"
end

-- Python
lspconfig.pylsp.setup({
  on_attach    = on_attach,
  capabilities = capabilities,
  cmd          = { find_pylsp() },
  settings = {
    pylsp = {
      plugins = {
        ruff        = { enabled = true },
        mypy        = { enabled = true },
        -- disable the redundant default linters since ruff covers them
        pycodestyle = { enabled = false },
        pyflakes    = { enabled = false },
        mccabe      = { enabled = false },
      },
    },
  },
})

-- Diagnostic appearance
vim.diagnostic.config({
  virtual_text   = true,
  signs          = true,
  underline      = true,
  update_in_insert = false,
  severity_sort  = true,
})
