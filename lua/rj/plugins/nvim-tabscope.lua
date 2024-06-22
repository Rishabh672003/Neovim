local M = {
  "backdround/tabscope.nvim",
  event = { "BufEnter", "InsertEnter", "BufReadPre", "BufAdd", "BufNew" },
  enabled = false,
}

M.config = function()
  require("tabscope").setup({})
end

return M
