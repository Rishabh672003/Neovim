Now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()

  vim.keymap.set("n", "<Leader>nc", function() vim.cmd.lua("MiniNotify.clear()") end, { silent = true, desc = "Clear all the notification" })
  vim.keymap.set("n", "<Leader>nh", function() vim.cmd.lua("MiniNotify.show_history()") end, { silent = true, desc = "Replay all the notification" })
end)
