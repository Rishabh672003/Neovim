local core_modules = {
  "user.plugins",
  "user.impatient",
  "user.colorschemes.tokyonight",
  "user.lualine-themes.lualine1",
  "user.startup-screens.startup-screen3",
  "user.options",
  "user.keymaps",
  "user.cmp",
  "user.lsp",
  "user.telescope",
  "user.treesitter",
  "user.autopairs",
  "user.comment",
  "user.gitsigns",
  "user.nvim-tree",
  "user.bufferline",
  "user.whichkey",
  "user.toggleterm",
  "user.project",
  "user.indentline",
  "user.autocommands",
  "user.colorizer",
  "user.illuminate",
  "user.notify",
  "user.fidget",
  "user.jaq",
}

-- Using pcall we can handle better any loading issues
for _, module in ipairs(core_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    print("config missing!!, or not loaded, see all config files are available and if they are restart neovim")
    return
  end
end

