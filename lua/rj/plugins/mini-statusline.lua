local M = {
  "echasnovski/mini.statusline",
  enabled = false,
  version = false,
  lazy = false,
}
function M.config()
  -- this is required so that neo-tree doesnt get deactivated while in Lazy
  local set_active_stl = function()
    vim.wo.statusline = "%!v:lua.MiniStatusline.active()"
  end
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "lazy", "neo-tree-popup", "noice" },
    callback = set_active_stl,
  })
  --
  local MiniStatusline = require("mini.statusline")
  local blocked_filetypes = {
    ["alpha"] = true,
    ["man"] = true,
  }
  require("mini.statusline").setup({
    content = {
      active = function()
        if blocked_filetypes[vim.bo.filetype] then
          vim.cmd("highlight StatusLine guibg=NONE guifg=NONE")
          return ""
        end
        local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 75 })
        local git = MiniStatusline.section_git({ trunc_width = 75 })
        local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
        local filename = MiniStatusline.section_filename({ trunc_width = 120 })
        local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
        local location = MiniStatusline.section_location({ trunc_width = 75 })
        local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

        return MiniStatusline.combine_groups({
          { hl = mode_hl, strings = { mode } },
          { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
          "%<", -- Mark general truncate point
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- End left alignment
          { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
          { hl = mode_hl, strings = { search, location } },
        })
      end,
    },
    use_icons = true,

    -- Whether to set Vim's settings for statusline (make it always shown with
    -- 'laststatus' set to 2). To use global statusline in Neovim>=0.7.0, set
    -- this to `false` and 'laststatus' to 3.
    set_vim_settings = false,
  })
end

return M
