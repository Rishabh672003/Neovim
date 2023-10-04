local M = {
  "ethanholz/nvim-lastplace",
  event = "BufEnter",
}

function M.config()
  require("nvim-lastplace").setup({
    lastplace_ignore_buftype = { "quickfix", "nofile", "help", "man" },
    lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit", "alpha" },
    lastplace_open_folds = true,
  })
end

return M
