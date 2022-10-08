local colorscheme = "catppuccin"
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
	styles = { "italic", "bold" },
	integrations = {
		telescope = true,
	},
	custom_highlights = {
		WhichKeyGroup = { fg = "#FAB387" },
		WhichKeySeparator = { fg = "#cdd6f4" },
	},
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
