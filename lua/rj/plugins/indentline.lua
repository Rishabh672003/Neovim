local M = {
  "lukas-reineke/indent-blankline.nvim",
  enabled = true,
  tag = "v2.20.8",
  event = { "BufReadPost", "BufNewFile" },
}

function M.config()
  vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
  vim.g.indent_blankline_filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "Trouble",
  }
  vim.g.indentLine_enabled = 1
  -- vim.g.indent_blankline_char = "│"
  vim.g.indent_blankline_char = "▏"
  -- vim.g.indent_blankline_char = "▎"
  vim.g.indent_blankline_show_trailing_blankline_indent = false
  vim.g.indent_blankline_show_first_indent_level = true
  -- vim.g.indent_blankline_use_treesitter = true
  vim.g.indent_blankline_show_current_context = true
  -- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
  vim.wo.colorcolumn = "99999"

  require("indent_blankline").setup({
    show_end_of_line = true,
    -- space_char_blankline = " ",
    show_current_context = true,
  })
end

return M
