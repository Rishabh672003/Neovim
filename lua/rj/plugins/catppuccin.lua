Now(function()
  Add({
    source = "catppuccin/nvim",
    name = "catppuccin",
    hooks = {
      post_checkout = function()
        vim.cmd("CatppuccinCompile")
      end,
    },
  })

  require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = {
      -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false,
    term_colors = false,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
    },
    color_overrides = {},
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      mini = true,
      noice = true,
      markdown = true,
    },
    custom_highlights = {
      WhichKeyGroup = { fg = "#FAB387" },
      WhichKeySeparator = { fg = "#cdd6f4" },
      IndentBlankLineContextChar = { fg = "#cdd6f4" },
      LspInlayHint = { bg = "none", italic = true },
      FloatBorder = { fg = "#89b4fa", bg = "none" },
    },
  })
  vim.cmd("colorscheme catppuccin-mocha")
end)
