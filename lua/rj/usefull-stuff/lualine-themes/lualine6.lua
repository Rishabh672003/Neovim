local function location()
  return [[%04l:%04c:%04L]]
end

-- local theme = require 'lualine.themes.kanagawa'
-- local theme = require 'lualine.themes.github'
-- theme.inactive.a.fg = '#23d18b' -- green
-- theme.inactive.b.fg = '#23d18b' -- green
-- theme.inactive.c.fg = '#23d18b' -- green

require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = "",
    component_separators = "",
    icons_enabled = true,
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "hostname",
      "branch",
      { "diagnostics", update_in_insert = true, always_visible = true, cond = vim.lsp.buf.server_ready },
    },
    lualine_c = {
      "diff",
      { "filename", file_status = true, path = 1 },
      { "require'nvim-navic'.get_location()", cond = require("nvim-navic").is_available },
      -- { "require'goldsmith'.status()" },
    },
    lualine_x = { "lsp_progress", "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { location },
  },
  -- extensions = { 'fugitive' },
})
