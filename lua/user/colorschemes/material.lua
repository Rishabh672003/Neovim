local colorscheme = "material" -- tokyonight, material --make sure the plugins are installed of these
vim.g.material_style = "deep ocean" -- darker, lighter, oceanic, palenight, deep ocean

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
