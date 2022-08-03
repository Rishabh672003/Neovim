local colorscheme = "tokyonight" -- tokyonight, material --make sure the plugins are installed of these
vim.g.tokyonight_style = "night" -- storm, night, day
vim.g.tokyonight_terminal_colors = false
vim.g.tokyonight_italic_keywords = false
vim.api.nvim_create_augroup("tokyonight_overrides", { clear = true })

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
