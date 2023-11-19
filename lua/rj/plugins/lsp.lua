return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = {
      "markdown",
      "lua",
      "c",
      "cpp",
      "java",
      "python",
      "json",
      "xml",
      "bash",
      "sh",
      "toml",
      "zsh",
      "rust",
      "html",
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "python",
    },
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("rj.lsp.attach")
      require("rj.lsp.lsp-conf")
      require("rj.lsp.diagnostic")
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    config = function()
      require("rj.lsp.clangd")
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            require("rj.lsp.attach").on_attach(client, bufnr)
          end,
          capabilities = require("rj.lsp.attach").capabilities,
        },
      }
    end,
  },
  {
    "hinell/lsp-timeout.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    enabled = true,
    lazy = true,
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    config = function()
      require("rj.lsp.nvim-conform")
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    enabled = true,
    config = function()
      require("rj.lsp.nvim-lint")
    end,
  },
}
