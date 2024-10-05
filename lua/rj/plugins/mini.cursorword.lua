local M = {
  "echasnovski/mini.cursorword",
  version = false,
  lazy = false,
}

M.config = function()
  require("mini.cursorword").setup()
  vim.api.nvim_set_hl(0, "MiniCursorWord", { link = "Visual" })
  vim.api.nvim_set_hl(0, "MiniCursorWordCurrent", { link = "CursorLine" })
end
return M
