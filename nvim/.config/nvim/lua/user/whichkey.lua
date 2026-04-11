local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

wk.setup({
  delay = 400, -- ms after leader before popup appears
})

-- Register key group labels so the popup is readable
wk.add({
  { "<leader>f",  group = "find (telescope)" },
  { "<leader>h",  group = "hunks (git)" },
  { "<leader>c",  group = "code action" },
  { "<leader>r",  group = "rename" },
  { "<leader>g",  group = "git" },
  { "<leader>t",  group = "terminal" },
})
