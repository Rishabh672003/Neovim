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

-- example using a list of specs with the default options
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
        git = {
		-- defaults for the `Lazy log` command
		log = { "--since=3 days ago" }, -- show commits from the last 3 days
		timeout = 600,
	},
  	"folke/which-key.nvim",
	{"catppuccin/nvim",
	name = "catppuccin",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		vim.cmd("colorscheme catppuccin")
	end,
	},
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",

        --cmp stuff
        {
                "hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("rj.plugins.cmp")
		end,
	},
	{ "L3MON4D3/LuaSnip", dependencies = {
		"rafamadriz/friendly-snippets",
	} },


	"neovim/nvim-lspconfig",
	{
		"williamboman/mason.nvim",
		config = function()
			require("rj.plugins.lsp.mason")
			require("rj.plugins.lsp.diagnostic")
			require("rj.plugins.lsp.attach")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		-- event = "InsertEnter",
		config = function()
			require("rj.plugins.lsp.null-ls")
		end,
	},
	{
		"p00f/clangd_extensions.nvim",
		lazy = false,
		event = "Bufenter",
		config = function()
			require("rj.plugins.lsp.clangd")
		end,
	},
  {"nvim-telescope/telescope.nvim"},
  {"nvim-telescope/telescope-media-files.nvim"},
  { "folke/tokyonight.nvim", event = "VeryLazy" },
})
