-- For mini.indentscope
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "alpha",
    "neo-tree",
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

local save_fold = vim.api.nvim_create_augroup("Persistent Folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*.*",
  callback = function()
    pcall(vim.cmd("mkview"))
  end,
  group = save_fold,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function()
    pcall(vim.cmd("loadview"))
  end,
  group = save_fold,
})
