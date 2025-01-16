local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
local lopt = vim.opt_local

autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function(args)
    local disable_filetypes = { "terminal", "Jaq", "dashboard", "gitcommit", "man", "help", "checkhealth" }
    if vim.tbl_contains(disable_filetypes, vim.bo.filetype) then
      return
    end
    local dir = vim.fn.expand("%:p:h")
    local root = vim.fs.root(args.buf, { ".git", "Makefile" })
    if root then
      dir = root
    end
    vim.fn.chdir(dir)
  end,
})

autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

autocmd({ "FileType" }, {
  pattern = { "qf", "help", "Jaq", "man" },
  callback = function()
    vim.keymap.set("n", "q", "<Cmd>close!<CR>", { silent = true, buffer = true })
    vim.api.nvim_set_option_value("buflisted", false, { buf = 0 })
  end,
})

autocmd("FileType", {
  pattern = { "lua" },
  command = "setlocal tabstop=2 shiftwidth=2",
})

autocmd({ "FileType" }, {
  pattern = { "python" },
  callback = function()
    lopt.listchars = { multispace = "---+", tab = "> " }
    lopt.list = true
  end,
})

autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "text", "man" },
  callback = function()
    lopt.wrap = true
    lopt.spell = true
    lopt.textwidth = 120
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
