return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    ft = {
      "bash",
      "cmake",
      "css",
      "go",
      "html",
      "java",
      "javascript",
      "javascriptreact",
      "json",
      "lua",
      "markdown",
      "python",
      "python",
      "sh",
      "toml",
      "typescript",
      "xml",
      "yaml",
      "zsh",
    },
    lazy = true,
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
    version = "^5",
    ft = { "rust" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("rj.lsp.rustaceanvim")
    end,
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "LspAttach",
    opts = {
      excluded_lsp_clients = { "rust-analyzer" },
      grace_period = 60 * 8,
      wakeup_delay = 10,
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "LspAttach",
    cmd = "Trouble",
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
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
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
