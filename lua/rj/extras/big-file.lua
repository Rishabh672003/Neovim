-- credit to: [vloe](https://github.com/vloe) who got it from [Lazyvim](https://github.com/LazyVim/LazyVim)
-- Disable certain features when opening large files

local big_file = vim.api.nvim_create_augroup("BigFile", { clear = true })
vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        return vim.bo[buf]
            and vim.bo[buf].filetype ~= "bigfile"
            and path
            and vim.fn.getfsize(path) > 1024 * 1000
            and "bigfile"
          or nil -- bigger than 1MB
      end,
    },
  },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = big_file,
  pattern = "bigfile",
  callback = function(ev)
    vim.cmd("syntax off")
    vim.b.minicursorword_disable = true
    vim.b.miniindentscope_disable = true
    vim.opt_local.foldmethod = "manual"
    vim.opt_local.spell = false
    vim.schedule(function()
      vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
    end)
  end,
})
