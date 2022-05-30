local catppuccin = require("catppuccin")

-- configure it
catppuccin.setup({
	integration = {
		nvimtree = {
			enabled = true,
			show_root = true, -- makes the root folder not transparent
			transparent_panel = false, -- make the panel transparent
		},
	},
})

local colorscheme = "material"
-- vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

--configuration for material theme
vim.g.material_style = "deep ocean"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
