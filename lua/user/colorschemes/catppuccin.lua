local colorscheme = "catppuccin" -- tokyonight, material --make sure the plugins are installed of these
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
	integrations = {
		telescope = true,
	},
	custom_highlights = {
		NvimTreeRootFolder = { fg = "#89B4FA" },
	},
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
