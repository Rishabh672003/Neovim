local M = {
  "dstein64/nvim-scrollview",
  enabled = false,
  event = { "InsertEnter", "BufReadPre" },
}

function M.config()
  require("scrollview").setup({
    excluded_filetypes = { "neotree", "oil" },
    current_only = true,
    base = "buffer",
    column = 80,
    signs_on_startup = { "all" },
    diagnostics_severities = { vim.diagnostic.severity.ERROR },
  })
end

return M
