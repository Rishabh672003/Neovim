Later(function()
  require("mini.sessions").setup({
    autowrite = true,
  })
  local keymap = vim.keymap.set
  keymap("n", "<Leader>mw", function()
    MiniSessions.write(vim.fn.fnamemodify(vim.fn.getcwd(), ":t"), {})
  end, { desc = "Write current session" })

  keymap("n", "<Leader>ms", function()
    MiniSessions.select()
  end, { desc = "Select a session" })

  keymap("n", "<Leader>md", function()
    MiniSessions.select("delete")
  end, { desc = "Delete a session to delete" })

  keymap("n", "<Leader>mW", function()
    MiniSessions.select("write")
  end, { desc = "Select and write a session" })

  keymap("n", "<Leader>mq", "<Cmd>qa!<CR>", { desc = "close all" })
end)
