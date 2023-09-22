local M = {
  "v1nh1shungry/cppman.nvim",
  lazy = true,
  enabled = true,
  dependencies = "nvim-telescope/telescope.nvim", -- optional, if absent `vim.ui.select()` will be used
  opts = {},
}

function M.config()
  require("cppman").setup({
    -- where the manual window displays
    -- can be 'split', 'vsplit' or 'tab'
    position = "split",
    -- where the index database stores
    -- you can manually set this option to `<cppman-install-directory>/lib/index.db` to avoid downloading
    index_db_path = vim.fs.joinpath(vim.fn.stdpath("data") .. "index.db"),
  })
end

return M
