local colorscheme = "tokyonight-night" -- tokyonight, material --make sure the plugins are installed of these
vim.g.tokyonight_style = "night" -- storm, night, day
vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_italic_keywords = true
vim.api.nvim_create_augroup("tokyonight_overrides", { clear = true })

require("tokyonight").setup({
	on_highlights = function(hl, c)
		hl.IndentBlanklineContextChar = {
			fg = c.dark5,
		}
		hl.TSConstructor = {
			fg = c.blue1,
		}
		hl.TSTagDelimiter = {
			fg = c.dark5,
		}
	end,
})

local status_ok, _ = pcall(vim.cmd.colorscheme, colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
