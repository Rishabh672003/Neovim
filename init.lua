local core_modules = {
	"user.impatient",
	"user.plugins",
	"user.colorschemes.catppuccin",
	"user.lualine-themes.lualine1",
	"user.startup-screens.startup-screen3",
	"user.barbeque.barbeque1",
	"user.options",
	"user.keymaps",
	"user.cmp",
	"user.lsp",
	"user.telescope",
	"user.treesitter",
	"user.autopairs",
	"user.comment",
	"user.gitsigns",
	"user.nvim-tree",
	"user.navic",
	"user.cybu",
	"user.whichkey",
	"user.toggleterm",
	"user.project",
	"user.indentline",
	"user.autocommands",
	"user.colorizer",
	"user.illuminate",
	"user.notify",
	"user.jaq",
	"user.better-escape",
	"user.hop",
	"user.dap",
}

-- Using pcall we can handle better any loading issues
for _, module in ipairs(core_modules) do
	local ok, _ = pcall(require, module)
	if not ok then
		print("config missing!!, or not loaded, see all config files are available and if they are restart neovim")
		return
	end
end
