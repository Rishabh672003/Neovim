return {
  "nvim-java/nvim-java",
  ft = "java",
  config = function()
    require("java").setup()
  end,
  dependencies = {
    "nvim-java/lua-async-await",
    "nvim-java/nvim-java-core",
    "nvim-java/nvim-java-test",
    "nvim-java/nvim-java-dap",
    "MunifTanjim/nui.nvim",
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("rj.lsp.attach")
        require("rj.lsp.diagnostic")
        require("lspconfig").jdtls.setup({})
      end,
    },
    "mfussenegger/nvim-dap",
    {
      "williamboman/mason.nvim",
    },
  },
}
