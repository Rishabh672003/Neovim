local M = {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  build = ":MasonToolsInstall",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup({
          ui = {
            border = "rounded",
          },
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        })
      end,
    },
  },
  lazy = true,
}

function M.config()
  require("mason-tool-installer").setup({
    ensure_installed = {
      -- language servers
      "bashls",
      "clangd",
      "cmake",
      "cssls",
      "dockerls",
      "gopls",
      "html-lsp",
      "hyprls",
      "jsonls",
      "lemminx",
      "lua_ls",
      "marksman",
      "pyright",
      "tailwindcss",
      "taplo",
      "ts_ls",
      "yamlls",

      -- debug adapters
      "codelldb",

      -- formatters
      -- astyle missing
      "biome",
      "clang-format",
      "cmakelang",
      -- "codespell",
      "goimports",
      "prettier",
      "ruff",
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
end

return M
