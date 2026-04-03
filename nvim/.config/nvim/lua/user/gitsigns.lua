local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup({
  signs = {
    add          = { text = "▎" },
    change       = { text = "▎" },
    delete       = { text = "▁" },
    topdelete    = { text = "▔" },
    changedelete = { text = "▎" },
  },
  current_line_blame = false, -- toggle with <leader>gb
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Hunk navigation
    vim.keymap.set("n", "]h", gs.next_hunk,                         opts)
    vim.keymap.set("n", "[h", gs.prev_hunk,                         opts)

    -- Stage / reset
    vim.keymap.set("n", "<leader>hs", gs.stage_hunk,                opts)
    vim.keymap.set("n", "<leader>hr", gs.reset_hunk,                opts)
    vim.keymap.set("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts)
    vim.keymap.set("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts)
    vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk,           opts)

    -- Preview / blame
    vim.keymap.set("n", "<leader>hp", gs.preview_hunk,              opts)
    vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame, opts)

    -- Diff
    vim.keymap.set("n", "<leader>hd", gs.diffthis,                  opts)
  end,
})
