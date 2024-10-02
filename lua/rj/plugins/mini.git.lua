local M = {
 'echasnovski/mini-git',
 version = false,
 lazy = true,
 cmd = "Git",
 main = 'mini.git',
}

M.config = function()
  require('mini.git').setup()
end

return M
