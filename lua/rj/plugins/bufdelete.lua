Later(function()
  Add({
    source = "famiu/bufdelete.nvim",
  })

  vim.keymap.set("n", "<Leader>c", "<Cmd>Bdelete!<CR>", { silent = true, desc = "Close the buffer" })
end)
