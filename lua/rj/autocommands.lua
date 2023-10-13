vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
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
  end,
})

-- For mini.indentscope
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = {
--     "alpha",
--     "neo-tree",
--     "help",
--     "startify",
--     "dashboard",
--     "packer",
--     "neogitstatus",
--     "NvimTree",
--     "Trouble",
--   },
--   callback = function()
--     vim.b.miniindentscope_disable = true
--   end,
-- })

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = "*.pdf",
  callback = function(ev)
    local filename = ev.file
    vim.fn.jobstart({ "xdg-open", filename }, { detach = true })
    vim.api.nvim_buf_delete(0, {})
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "c", "go", "java" },
  callback = function()
    vim.opt.shiftwidth = 4
    vim.opt.tabstop = 4
  end,
})

vim.filetype.add({
  extension = {
    rasi = "rasi",
    conf = "conf",
  },
})
