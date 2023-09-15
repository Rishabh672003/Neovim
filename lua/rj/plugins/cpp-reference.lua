local M = {
  "v1nh1shungry/cppreference.nvim",
  dependencies = "nvim-telescope/telescope.nvim",
  enabled = false,
  opts = {},
}

function M.config()
  require("cppreference").setup({
    view = "cppman",
    cppman = {
      position = "split",
    },
  })
end

return M
