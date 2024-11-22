if vim.g.neovide then
  vim.keymap.set("n", "<Leader>q", "<Cmd>silent close<CR>", { desc = "Close the Buffer" })
end

if vim.g.vscode then
  return
end
