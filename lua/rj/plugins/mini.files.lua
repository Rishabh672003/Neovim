local M = { 
  'echasnovski/mini.files', 
  version = false,
  lazy = true,
  keys = {
    {"<leader>e", function()MiniFiles.open()end ,  desc = "Open file explorer"}
  },
}

M.config = function()
  require('mini.files').setup()
end

return M
