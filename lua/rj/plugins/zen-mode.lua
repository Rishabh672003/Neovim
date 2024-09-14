local M = {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
}

function M.config()
  require("zen-mode").setup({
    window = {
      backdrop = 1,
      height = 0.88,
      -- width = 0.5,
      width = 85,
      options = {
        signcolumn = "no",
        number = false,
        relativenumber = false,
        cursorline = true,
        cursorcolumn = false, -- disable cursor column
        -- foldcolumn = "0", -- disable fold column
        -- list = false, -- disable whitespace characters
      },
    },
    plugins = {
      gitsigns = { enabled = false },
      tmux = { enabled = false },
      twilight = { enabled = false },
      alacritty = {
        enabled = false,
        font = "15", -- font size
      },
    },
    on_open = function(_)
      vim.o.laststatus = 2
      require("lualine").hide()
    end,
    on_close = function()
      vim.o.laststatus = 3
      require("lualine").hide({ unhide = true })
    end,
  })
end

return M
