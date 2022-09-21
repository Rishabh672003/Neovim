local colorscheme = "catppuccin"
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup({
	transparent_background = false,
	styles = { "italic", "bold" },
	integrations = {
		telescope = true,
	},
	custom_highlights = {
		WhichKeyGroup = { fg = "#FAB387" },
		WhichKeySeparator = { fg = "#cdd6f4" },
	},
	-- compile = {
	-- 	enabled = true,
	-- 	path = vim.fn.stdpath("cache") .. "/catppuccin",
	-- 	suffix = "_compiled",
	-- },
})

-- Create an autocmd User PackerCompileDone to update it every time packer is compiled
-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "PackerCompileDone",
-- 	callback = function()
-- 		vim.cmd("CatppuccinCompile")
-- 		vim.defer_fn(function()
-- 			vim.cmd("colorscheme catppuccin")
-- 		end, 50) -- Debounced for live reloading
-- 	end,
-- })

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
