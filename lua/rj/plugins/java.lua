local M = {
  "nvim-java/nvim-java",
  ft = "java",
}

M.dependencies = {
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "nvim-java/lua-async-await",
  "nvim-java/nvim-java-core",
  "nvim-java/nvim-java-test",
  "nvim-java/nvim-java-dap",
  "MunifTanjim/nui.nvim",
  "mfussenegger/nvim-dap",
}

function M.config()
  require("java").setup()
  require("lspconfig").jdtls.setup({})
  local opts = { noremap = true, silent = true, buffer = true }
  vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

return M
