local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_autocmd("FileType", {
    pattern = "dashboard",
    command = "setlocal nocursorline"
})

autocmd({ "FileType" }, {
  pattern = { "qf", "help", "lspinfo", "spectre_panel", "oil", "Jaq" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", { silent = true, buffer = true })
    vim.api.nvim_set_option_value("buflisted", false, { buf = 0 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go", "c", "cpp", "rust", "java" },
    command = "setlocal tabstop=4 shiftwidth=4"
})

autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})


-- make a command to clear registers
vim.cmd([[
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
]])

vim.api.nvim_create_user_command("Grep", function(opts)
  local command = string.format('silent cgetexpr system("rg --vimgrep -S %s")', opts.args)
  vim.cmd(command)
  vim.cmd("Trouble quickfix focus")
end, { nargs = 1 })
