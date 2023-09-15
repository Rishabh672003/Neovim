local M = {
  "nvim-lualine/lualine.nvim",
  event = { "InsertEnter", "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
}

function M.config()
  local lualine = require("lualine")

  local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
    always_visible = true,
  }

  local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
  }

  local mode = {
    "mode",
    fmt = function(str)
      return "-- " .. str .. " --"
    end,
  }

  local filetype = {
    "filetype",
    icons_enabled = false,
    icon = nil,
  }

  local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
  }

  local location = {
    "location",
    padding = 0,
  }

  -- cool function for progress
  local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end

  local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        -- "alpha", "dashboard"
        statusline = { "alpha", "dashboard" }, -- "toggleterm"},
        -- winbar = {"alpha", "dashboard"}
      },
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { branch, diagnostics },
      lualine_b = { mode },
      lualine_c = {
        -- { "filename", file_status = true, path = 3 },
      },
      -- lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_x = { spaces, diff, filetype },
      lualine_y = { location },
      lualine_z = { progress },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    --[[ winbar = { ]]
    --[[ 	lualine_a = {}, ]]
    --[[ 	lualine_b = {}, ]]
    --[[ 	lualine_c = { { navic.get_location, cond = navic.is_available } }, ]]
    --[[ 	lualine_x = {}, ]]
    --[[ 	lualine_y = {}, ]]
    --[[ 	lualine_z = {}, ]]
    --[[ }, ]]
    --[[]]
    --[[ inactive_winbar = { ]]
    --[[ 	lualine_a = {}, ]]
    --[[ 	lualine_b = {}, ]]
    --[[ 	lualine_c = {}, ]]
    --[[ 	lualine_x = {}, ]]
    --[[ 	lualine_y = {}, ]]
    --[[ 	lualine_z = {}, ]]
    --[[ }, ]]
    tabline = {},
    extensions = {},
  })
end

return M
