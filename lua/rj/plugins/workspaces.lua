Later(function()
  Add({
    source = "natecraddock/workspaces.nvim",
    depends = {"nvim-telescope/telescope.nvim"},
  })

  require("workspaces").setup({
    hooks = {
      open = "Telescope find_files",
    }
  })
end)
