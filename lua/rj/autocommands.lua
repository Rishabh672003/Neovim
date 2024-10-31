local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  command = "setlocal nocursorline",
})

autocmd({ "FileType" }, {
  pattern = { "qf", "help", "lspinfo", "spectre_panel", "oil", "Jaq", "man" },
  callback = function()
    vim.keymap.set("n", "q", "<Cmd>close!<CR>", { silent = true, buffer = true })
    vim.api.nvim_set_option_value("buflisted", false, { buf = 0 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "c", "cpp", "rust", "java", "js", "zsh", "sh", "bash", "ts" },
  command = "setlocal tabstop=4 shiftwidth=4",
})

autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt.textwidth = 120
  end,
})

vim.api.nvim_create_user_command("Grep", function(opts)
  local command = string.format('silent cgetexpr system("rg --vimgrep -S %s")', opts.args)
  vim.cmd(command)
  vim.cmd("copen")
end, { nargs = 1 })

vim.api.nvim_create_autocmd("FileType", {
  desc = "Disable indentscope for certain filetypes",
  pattern = {
    "Trouble",
    "better_term",
    "dashboard",
    "help",
    "lazy",
    "lazyterm",
    "leetcode.nvim",
    "man",
    "mason",
    "notify",
    "terminal",
    "toggleterm",
    "trouble",
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})
