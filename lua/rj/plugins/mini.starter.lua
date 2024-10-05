local M = {
  "echasnovski/mini.starter",
  version = false,
  lazy = false,
  enabled = false,
}

M.config = function()
  require("mini.starter").setup()
end

return M
