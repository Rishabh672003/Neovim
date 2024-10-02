local M = {
  'echasnovski/mini.completion',
  version = false,
  lazy = false,
  enabled = false,
}

M.config = function()
  require('mini.completion').setup()
end

return M
