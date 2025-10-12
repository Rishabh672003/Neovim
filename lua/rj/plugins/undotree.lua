Now(function()
  Add({
    source = "mbbill/undotree",
  })
  vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)
end)
