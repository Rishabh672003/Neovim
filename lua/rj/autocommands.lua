local autocmd = vim.api.nvim_create_autocmd

autocmd({ "FileType" }, {
  pattern = { "c", "go", "java", "cpp", "py", "sh" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

autocmd({ "FileType" }, {
  pattern = { "qf", "help", "lspinfo", "spectre_panel", "oil", "Jaq" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", { silent = true, buffer = true })
    vim.api.nvim_set_option_value("buflisted", false, { buf = 0 })
  end,
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

vim.api.nvim_create_user_command("Format", function()
  local function myCallback(err)
    if err then
      vim.notify("Error during formatting: ", err)
    else
      vim.notify("Formatting completed successfully.")
    end
  end
  require("conform").format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  }, myCallback())
end, {
desc = "format",
})
