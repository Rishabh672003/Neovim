local M = { 
  'echasnovski/mini.pairs',
  version = false,
  lazy = true,
  enabled = true,
  event = { "InsertEnter"}
}

M.config = function()
  require('mini.pairs').setup()
end

return M
