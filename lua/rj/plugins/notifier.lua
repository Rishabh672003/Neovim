Later(function()
  Add({
    source = "vigoux/notifier.nvim",
  })
  vim.tbl_islist = vim.islist
  require("notifier").setup()
  vim.keymap.set("n", "<Leader>nc", vim.cmd.NotifierClear, { silent = true, desc = "Clear all the notification" })
  vim.keymap.set("n", "<Leader>nh", vim.cmd.NotifierReplay, { silent = true, desc = "Replay all the notification" })
end)
