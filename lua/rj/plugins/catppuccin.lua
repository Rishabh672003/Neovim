local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  build = ":CatppuccinCompile",
  priority = 1000,
}

function M.config()
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
      LspInlayHint = { bg = "none" },
    },
  })

  M.name = "catppuccin"
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return vim.notify("Catppuccin theme not found")
  end
end

vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

return M
