vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "go", "java", "cpp", "py", "sh" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "lspinfo", "spectre_panel", "oil" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", { silent = true, buffer = true })
    vim.api.nvim_set_option_value("buflisted", false, { buf = 0 })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "TelescopePrompt", "neo-tree-popup", "oil" },
  callback = function()
    require("cmp").setup.buffer({
      completion = { autocomplete = false },
    })
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd("hi link illuminatedWord LspReferenceText")
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 10000 then
      vim.cmd("IlluminatePauseBuf")
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "neo-tree" },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
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

vim.api.nvim_create_autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    if
      ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
      and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
  end,
})

-- make a command to clear registers
vim.cmd([[
command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
]])
