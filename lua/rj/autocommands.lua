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

autocmd({ "FileType" }, {
  pattern = { "TelescopePrompt", "neo-tree-popup", "oil" },
  callback = function()
    require("cmp").setup.buffer({
      completion = { autocomplete = false },
    })
  end,
})
--
-- vim.cmd [[
-- au BufEnter,BufWinEnter,WinEnter,CmdwinEnter *
--                        \ call s:disable_statusline('NvimTree')
-- fun! s:disable_statusline(bn)
--    if a:bn == bufname('%')
--        set laststatus=0
--    else
--        set laststatus=2
--    endif
-- endfunction ]]

autocmd({ "FileType" }, {
  pattern = { "cpp" },
  callback = function()
    require("cmp").setup.buffer({
      experimental = {
        ghost_text = true,
      },
    })
  end,
})

autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd("hi link illuminatedWord LspReferenceText")
  end,
})

autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 10000 then
      vim.cmd("IlluminatePauseBuf")
    end
  end,
})

autocmd({ "FileType" }, {
  pattern = { "neo-tree", "alpha", "dashboard", "man" },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

autocmd({ "BufReadPost" }, {
  pattern = "*.pdf",
  callback = function(ev)
    local filename = ev.file
    vim.fn.jobstart({ "xdg-open", filename }, { detach = true })
    vim.api.nvim_buf_delete(0, {})
  end,
})

vim.filetype.add({
  extension = {
    rasi = "rasi",
    conf = "conf",
  },
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

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = function(event)
    local filepath = vim.fn.expand("<afile>:p")
    if filepath:match("/hypr/") then
      -- vim.notify(string.format("starting hyprls for %s", vim.inspect(event)))
      vim.lsp.start({
        name = "hyprlang",
        cmd = { "hyprls" },
        root_dir = vim.fn.getcwd(),
      })
    end
  end,
})
