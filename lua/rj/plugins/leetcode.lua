Later(function()
  Add({
    source = "kawre/leetcode.nvim",
    depends = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  })
  require("leetcode").setup({
    lang = "python3",
    storage = {
      home = vim.fn.stdpath("data") .. "/leetcode",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },
    plugins = {
      non_standalone = true,
    },
  })
end)
