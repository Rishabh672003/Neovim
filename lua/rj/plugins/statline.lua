local M = {
  "tamton-aquib/staline.nvim",
  lazy = false,
  enabled = false,
}

function M.config()
  require("staline").setup()
end

return M
