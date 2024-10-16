Later(function()
  require("mini.cursorword").setup()
  vim.api.nvim_set_hl(0, "MiniCursorword", { link = "Visual" })
  vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", {})
end
)
