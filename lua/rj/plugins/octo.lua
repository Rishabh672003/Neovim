local M = {
  "pwntester/octo.nvim",
  enabled = true,
  cmd = "Octo",
  -- event = "BufReadPost",
}

function M.config()
  require("octo").setup()
end

return M
