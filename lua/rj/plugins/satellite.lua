local M = {
  "lewis6991/satellite.nvim",
  enabled = false,
  event = { "InsertEnter", "BufReadPre" },
}

function M.config()
  require("satellite").setup()
end

return M
