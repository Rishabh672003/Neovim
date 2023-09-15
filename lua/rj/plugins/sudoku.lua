local M = {
  "jim-fx/sudoku.nvim",
  cmd = "Sudoku",
}

function M.config()
  require("sudoku").setup({})
end

return M
