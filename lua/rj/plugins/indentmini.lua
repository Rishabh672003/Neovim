Now(function()
  Add({
    source = "nvimdev/indentmini.nvim",
  })
  require("indentmini").setup({
    char = "▏",
  }) -- use default config
  vim.cmd.highlight("IndentLine guifg=#45475A")
  vim.cmd.highlight("IndentLineCurrent guifg=#cdd6f4")
end)
