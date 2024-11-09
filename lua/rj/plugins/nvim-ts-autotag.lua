Later(function()
  Add({
    source = "windwp/nvim-ts-autotag",
    depends = { "nvim-treesitter/nvim-treesitter" },
  })
  require("nvim-ts-autotag").setup({})
end)
