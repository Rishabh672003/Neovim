Later(function()
  Add({
    source = "WhoIsSethDaniel/mason-tool-installer.nvim",
    depends = { "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim" },
  })
  require("mason").setup({
    ui = {
      border = "rounded",
    },
    registries = {
      "github:nvim-java/mason-registry",
      "github:mason-org/mason-registry",
    },
  })
  require("mason-tool-installer").setup({
    ensure_installed = {
      -- language servers
      "bashls",
      "clangd",
      "cssls",
      "gopls",
      "html-lsp",
      "lua_ls",
      "pyright",
      "tailwindcss",
      "ts_ls",

      -- debug adapters
      "codelldb",

      -- formatters
      -- astyle missing
      "biome",
      "clang-format",
      "cmakelang",
      "goimports",
      "prettier",
      "ruff",
      "shfmt",
      "stylua",

      -- linters
      "eslint_d",
      "luacheck",
      "proselint",
      "shellcheck",
    },
  })
end)
