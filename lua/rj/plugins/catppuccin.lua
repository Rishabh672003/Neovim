-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- startup and are optional.
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add({
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

-- later(function()
--   -- Use other plugins with `add()`. It ensures plugin is available in current
--   -- session (installs if absent)
--   add({
--     source = 'neovim/nvim-lspconfig',
--     -- Supply dependencies near target plugin
--     depends = { 'williamboman/mason.nvim' },
--   })
-- end)
--
-- later(function()
--   add({
--     source = 'nvim-treesitter/nvim-treesitter',
--     -- Use 'master' while monitoring updates in 'main'
--     checkout = 'master',
--     monitor = 'main',
--     -- Perform action after every checkout
--   })
--   -- Possible to immediately execute code which depends on the added plugin
--   require('nvim-treesitter.configs').setup({
--     ensure_installed = { 'lua', 'vimdoc' },
--     highlight = { enable = true },
--   })
-- end)
