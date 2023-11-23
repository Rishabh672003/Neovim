return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = {
      "markdown",
      "lua",
      "java",
      "python",
      "json",
      "xml",
      "bash",
      "sh",
      "toml",
      "zsh",
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
    dependencies = {
      "hrsh7th/cmp-nvim-lsp"
    },

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
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      grace_period = 60*8,
      wakeup_delay = 10,
    },
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
