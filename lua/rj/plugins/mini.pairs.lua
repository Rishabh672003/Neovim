local M = { 
  'echasnovski/mini.pairs', 
  version = false,
  lazy = true,
  event = { "InsertEnter", "CmdLineEnter"}
}

M.config = function()
  require('mini.pairs').setup()
end

return M
