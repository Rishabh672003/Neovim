local M = {
  "williamboman/mason.nvim",
  lazy = false,
  -- event = "LspAttach",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

M.servers = {
  "bashls",
  "cssls",
  "dockerls",
  "gopls",
  "jdtls",
  "jsonls",
  "lemminx",
  "marksman",
  "taplo",
  "tsserver",
  "lua_ls",
  "pyright",
  "yamlls",
  "tailwindcss",
}

function M.config()
  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })
end

return M
