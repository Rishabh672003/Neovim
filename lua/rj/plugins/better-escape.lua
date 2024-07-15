local M = {
  "max397574/better-escape.nvim",
  enabled = true
}

function M.config()
  -- lua, default settings
  require("better_escape").setup({
    timeout = vim.o.timeoutlen,
    mappings = {
      i = {
        j = {
          k = "<Esc>",
          j = false,
        },
      },
      c = {
        j = {
          k = "<Esc>",
          j = false,
        },
      },
      t = {
        j = {
          k = false,
          j = false,
        },
      },
      v = {
        j = {
          k = false,
        },
      },
      s = {
        j = {
          k = false,
        },
      },
    },
  })
end

return M
