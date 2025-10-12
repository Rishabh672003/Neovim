Later(function()
  Add({
    source = "WhoIsSethDaniel/mason-tool-installer.nvim",
    depends = { "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim" },
    post_checkout = function()
      vim.cmd("MasonToolsInstall")
    end,
  })
  require("mason").setup({
    ui = {
      border = "single",
    },
    registries = {
      "github:nvim-java/mason-registry",
      "github:mason-org/mason-registry",
    },
  })

  require("mason-tool-installer").setup({
    ensure_installed = {
      -- language servers
      "basedpyright",
      "bashls",
      "clangd",
      "cssls",
      "gopls",
      "html-lsp",
      "lua_ls",
      "tailwindcss",
      "ts_ls",
      "tinymist",

      -- -- debug adapters
      -- "codelldb",

      -- formatters
      -- astyle missing
      "biome",
      "clang-format",
      "cmakelang",
      "goimports",
      "prettier",
      "typstyle",

      "ruff",
      "shfmt",
      "stylua",

      -- linters
      -- "eslint_d",
      -- "luacheck",
      -- "proselint",
      -- "shellcheck",
    },
  })
end)
