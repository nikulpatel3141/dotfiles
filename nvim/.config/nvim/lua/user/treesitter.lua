local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup({
  ensure_installed = {
    "bash", "c", "cpp", "css", "fish", "html", "javascript",
    "json", "lua", "markdown", "python", "rust", "toml",
    "typescript", "yaml",
  },
  ignore_install = {},
  highlight = {
    enable  = true,
    disable = { "latex" },
  },
  indent = { enable = true, disable = { "python", "css" } },
})
