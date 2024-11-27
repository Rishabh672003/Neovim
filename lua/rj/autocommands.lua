local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

autocmd("FileType", {
  pattern = "dashboard",
  command = "setlocal nocursorline",
})

autocmd({ "FileType" }, {
  pattern = { "qf", "help", "Jaq", "man" },
  callback = function()
    vim.keymap.set("n", "q", "<Cmd>close!<CR>", { silent = true, buffer = true })
    vim.api.nvim_set_option_value("buflisted", false, { buf = 0 })
  end,
})

autocmd("FileType", {
  pattern = { "go", "c", "cpp", "rust", "java", "js", "zsh", "sh", "bash", "ts", "json" },
  command = "setlocal tabstop=4 shiftwidth=4",
})

autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "text", "man" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt.textwidth = 120
  end,
})

usercmd("Grep", function(opts)
  local command = string.format('silent cgetexpr system("rg --vimgrep -S %s")', opts.args)
  vim.cmd(command)
  vim.cmd("copen")
end, { nargs = 1 })

autocmd("BufWritePre", {
  pattern = "*",
  desc = "Create parent directories of a file, if they dont exist",
  callback = function()
    local fpath = vim.fn.expand("<afile>")
    local dir = vim.fn.fnamemodify(fpath, ":p:h")

    if vim.fn.isdirectory(dir) ~= 1 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

autocmd("FileType", {
  desc = "Disable indentscope for certain filetypes",
  pattern = {
    "dashboard",
    "help",
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
