local core_modules = {
  "user.impatient",
  "user.options",
  "user.keymaps",
  "user.plugins",
  "user.colorscheme",
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
  "user.whichkey",
  "user.autocommands",
  "user.colorizer",
  "user.lualine-themes.lualine1",
}

-- Using pcall we can handle better any loading issues
for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
      --error("Error loading " .. module .. "\n\n" .. err)
      return
    end
end
