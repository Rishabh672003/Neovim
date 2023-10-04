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
    event = "BufReadPost",
    config = function()
      require("rj.lsp.attach")
      require("rj.lsp.lsp-conf")
      require("rj.lsp.diagnostic")
    end,
  },
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    event = "BufReadPost",
    lazy = true,
    config = function()
      require("rj.lsp.clangd")
    end,
  },
  {
    "Ciel-MC/rust-tools.nvim",
    branch = "inline-inlay-hints",
    ft = { "rust" },
    lazy = true,
    event = "BufReadPost",
    config = function()
      require("rj.lsp.rust-tools")
    end,
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
