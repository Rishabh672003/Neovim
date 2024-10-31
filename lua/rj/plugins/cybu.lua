Later(function()
  Add({
    source = "ghillb/cybu.nvim",
    depends = { "nvim-tree/nvim-web-devicons" },
  })
  require("cybu").setup({
    position = {
      relative_to = "win", -- win, editor, cursor
      anchor = "topright", -- topleft, topcenter, topright,
    },
    display_time = 1750, -- time the cybu window is displayed
    style = {
      path = "relative", -- absolute, relative, tail (filename only)
      border = "single", -- single, double, rounded, none
      separator = " ", -- string used as separator
      prefix = "…", -- string used as prefix for truncated paths
      padding = 1, -- left & right padding in number of spaces
      hide_buffer_id = true,
      devicons = {
        enabled = true, -- enable or disable web dev icons
        colored = true, -- enable color for web dev icons
      },
    },
  })

  vim.keymap.set("n", "<Leader>bn", "<Cmd>CybuNext<CR>")
  vim.keymap.set("n", "<Leader>bp", "<Cmd>CybuPrev<CR>")
end)
