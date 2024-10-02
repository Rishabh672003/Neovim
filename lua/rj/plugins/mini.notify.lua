local M = { 
  'echasnovski/mini.notify', 
  version = false,
  lazy = false,
  enabled = true,
}

M.config = function()
  require('mini.notify').setup({
    -- Content management
    content = {
      -- Function which formats the notification message
      -- By default prepends message with notification time
      format = nil,

      -- Function which orders notification array from most to least important
      -- By default orders first by level and then by update timestamp
      sort = nil,
    },

    -- Notifications about LSP progress
    lsp_progress = {
      -- Whether to enable showing
      enable = true,

      -- Duration (in ms) of how long last message should be shown
      duration_last = 1000,
    },

    -- Window options
    window = {
      -- Floating window config
      config = {},

      -- Maximum window width as share (between 0 and 1) of available columns
      max_width_share = 0.382,

      -- Value of 'winblend' option
      winblend = 25,
    },
  })
  vim.notify = require('mini.notify').make_notify()
end

return M
