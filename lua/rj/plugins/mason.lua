local M = {
  "williamboman/mason.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- language servers
          "bashls",
          "cssls",
          "dockerls",
          "gopls",
          "jdtls",
          "jsonls",
          "lemminx",
          "lua_ls",
          "marksman",
          "pyright",
          "tailwindcss",
          "taplo",
          "tsserver",
          "yamlls",

          -- debug adapters
          "codelldb",

          -- formatters
          -- astyle missing
          "biome",
          "prettier",
          "black",
          "shfmt",
          "stylua",

          -- linters
          -- cppcheck missing
          "eslint_d",
          "luacheck",
          "proselint",
          "shellcheck",
        },
      })
    end,
  },
}

function M.config()
  require("mason").setup({
    ui = {
      border = "rounded",
    },
  })
end

return M