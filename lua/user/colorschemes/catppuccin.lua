local colorscheme = "catppuccin"
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

require("catppuccin").setup({
	styles = { "italic", "bold" },
	integrations = {
		telescope = true,
		illuminate = true,
	},
	custom_highlights = {
		WhichKeyGroup = { fg = "#FAB387" },
		-- WhichKeySeparator = { fg = "#cdd6f4" },
	},
})

local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
