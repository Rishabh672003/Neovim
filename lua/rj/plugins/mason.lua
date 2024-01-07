local M = {
  "williamboman/mason.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
    },
    {
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
            "cmake",

            -- debug adapters
            "codelldb",

            -- formatters
            -- astyle missing
            "biome",
            "prettier",
            "black",
            "shfmt",
            "stylua",
            "cmakelang",

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
  },
}

function M.config()
  require("mason").setup({
    ui = {
      border = "rounded",
    },
    registries = {
      "github:nvim-java/mason-registry",
      "github:mason-org/mason-registry",
    },
  })
end

return M
