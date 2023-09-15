local lualine = require("lualine")

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local utils = require("lualine.utils.utils")
local highlight = require("lualine.highlight")

local diagnostics_message = require("lualine.component"):extend()

diagnostics_message.default = {
  colors = {
    error = utils.extract_color_from_hllist(
      { "fg", "sp" },
      { "DiagnosticError", "LspDiagnosticsDefaultError", "DiffDelete" },
      "#e32636"
    ),
    warning = utils.extract_color_from_hllist(
      { "fg", "sp" },
      { "DiagnosticWarn", "LspDiagnosticsDefaultWarning", "DiffText" },
      "#ffa500"
    ),
    info = utils.extract_color_from_hllist(
      { "fg", "sp" },
      { "DiagnosticInfo", "LspDiagnosticsDefaultInformation", "DiffChange" },
      "#ffffff"
    ),
    hint = utils.extract_color_from_hllist(
      { "fg", "sp" },
      { "DiagnosticHint", "LspDiagnosticsDefaultHint", "DiffAdd" },
      "#273faf"
    ),
  },
}
function diagnostics_message:init(options)
  diagnostics_message.super:init(options)
  self.options.colors = vim.tbl_extend("force", diagnostics_message.default.colors, self.options.colors or {})
  self.highlights = { error = "", warn = "", info = "", hint = "" }
  self.highlights.error = highlight.create_component_highlight_group(
    { fg = self.options.colors.error },
    "diagnostics_message_error",
    self.options
  )
  self.highlights.warn = highlight.create_component_highlight_group(
    { fg = self.options.colors.warn },
    "diagnostics_message_warn",
    self.options
  )
  self.highlights.info = highlight.create_component_highlight_group(
    { fg = self.options.colors.info },
    "diagnostics_message_info",
    self.options
  )
  self.highlights.hint = highlight.create_component_highlight_group(
    { fg = self.options.colors.hint },
    "diagnostics_message_hint",
    self.options
  )
end

function diagnostics_message:update_status(is_focused)
  local r, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local diagnostics = vim.diagnostic.get(0, { lnum = r - 1 })
  if #diagnostics > 0 then
    local diag = diagnostics[1]
    for _, d in ipairs(diagnostics) do
      if d.severity < diag.severity then
        diagnostics = d
      end
    end
    local icons = { " ", " ", " ", " " }
    local hl = { self.highlights.error, self.highlights.warn, self.highlights.info, self.highlights.hint }
    return highlight.component_format_highlight(hl[diag.severity]) .. icons[diag.severity] .. " " .. diag.message
  else
    return ""
  end
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

-- local spaces = function()
-- 	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
-- end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { -- "alpha", "dashboard"
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
      {
        diagnostics_message,
        colors = {
          error = "#BF616A",
          warn = "#EBCB8B",
          info = "#A3BE8C",
          hint = "#88C0D0",
        },
      },
      -- { "filename", file_status = true, path = 3 },
    },
    -- lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_x = { diff, filetype },
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
