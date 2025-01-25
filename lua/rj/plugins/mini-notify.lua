Now(function()
  local opts = {
    ERROR = { duration = 5000, hl_group = "DiagnosticError" },
    WARN = { duration = 5000, hl_group = "DiagnosticWarn" },
    INFO = { duration = 5000, hl_group = "DiagnosticInfo" },
    DEBUG = { duration = 0, hl_group = "DiagnosticHint" },
    TRACE = { duration = 0, hl_group = "DiagnosticOk" },
    OFF = { duration = 0, hl_group = "MiniNotifyNormal" },
  }
  require("mini.notify").setup(opts)
  vim.notify = require("mini.notify").make_notify()

  vim.keymap.set("n", "<Leader>nc", function()
    vim.cmd.lua("MiniNotify.clear()")
  end, { silent = true, desc = "Clear all the notification" })
  vim.keymap.set("n", "<Leader>nh", function()
    vim.cmd.lua("MiniNotify.show_history()")
  end, { silent = true, desc = "Replay all the notification" })
end)
