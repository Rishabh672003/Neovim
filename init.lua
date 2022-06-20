local core_modules = {
	"user.impatient",
	"user.options",
	"user.keymaps",
	"user.plugins",
	"user.colorschemes.catppuccin",
	"user.cmp",
	"user.lsp",
	"user.telescope",
	"user.treesitter",
	"user.autopairs",
	"user.comment",
	"user.gitsigns",
	"user.nvim-tree",
	"user.bufferline",
	"user.whichkey",
	"user.toggleterm",
	"user.project",
	"user.indentline",
	"user.whichkey",
	"user.autocommands",
	"user.colorizer",
	"user.lualine-themes.lualine1",
	"user.illuminate",
	"user.notify",
	-- "user.startup-screen"
}

-- Using pcall we can handle better any loading issues
for _, module in ipairs(core_modules) do
	local ok, err = pcall(require, module)
	if not ok then
		print("config missing!!, or not loaded, see all config files are available and if they are restart neovim")
		return
	end
end
