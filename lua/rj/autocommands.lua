local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

autocmd("FileType", {
  pattern = "dashboard",
  command = "setlocal nocursorline",
})

autocmd({ "BufEnter" }, {
  pattern = "*",
  callback = function(args)
    local dir = vim.fn.expand("%:p:h")
    if vim.bo.filetype == "dashboard" then
      return
    end
    local root = vim.fs.root(args.buf, { ".git", "Makefile" })
    if root then
      dir = root
    end
    vim.fn.chdir(dir)
  end,
})

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
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
    vim.opt_local.listchars = { multispace = "---+", tab = "> " }
    vim.opt_local.list = true
  end,
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

local cmdline_group = vim.api.nvim_create_augroup("CmdlineLinenr", {})
-- debounce cmdline enter events to make sure we dont have flickering for non user cmdline use
-- e.g. mappings using : instead of <cmd>
local cmdline_debounce_timer

autocmd("CmdlineEnter", {
  group = cmdline_group,
  callback = function()
    cmdline_debounce_timer = vim.uv.new_timer()
    cmdline_debounce_timer:start(
      100,
      0,
      vim.schedule_wrap(function()
        if vim.o.number then
          vim.o.relativenumber = false
          vim.api.nvim__redraw({ statuscolumn = true })
        end
      end)
    )
  end,
})

autocmd("CmdlineLeave", {
  group = cmdline_group,
  callback = function()
    if cmdline_debounce_timer then
      cmdline_debounce_timer:stop()
      cmdline_debounce_timer = nil
    end
    if vim.o.number then
      vim.o.relativenumber = true
    end
  end,
})
