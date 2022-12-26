local core_modules = {
	"user.impatient",
	"user.options",
	"user.lazy",
	"user.colorschemes.catppuccin",
	"user.keymaps",
	"user.autocommands",
}

-- Using pcall we can handle better any loading issues
for _, module in ipairs(core_modules) do
	local ok, _ = pcall(require, module)
	if not ok then
		print("config missing!!, or not loaded, see all config files are available and if they are restart neovim")
		return
	end
end
