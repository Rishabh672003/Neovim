local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup("rj.plugins", {
	git = {
		log = { "--since=3 days ago" }, -- show commits from the last 3 days
		timeout = 600,
	},
	defaults = {
		lazy = true,
	},
	install = { colorscheme = { "catppuccin-mocha" } },
	performance = {
		rtp = {
			paths = {
				vim.fn.expand("~") .. "/.config/nvim",
			},
		},
	},
})
