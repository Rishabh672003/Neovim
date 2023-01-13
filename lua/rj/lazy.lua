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
	{
		"folke/which-key.nvim",
		config = function()
			require("rj.plugins.whichkey")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("rj.plugins.catppuccin")
		end,
		dependencies = {
			"lukas-reineke/indent-blankline.nvim",
			event = "InsertEnter",
			config = function()
				require("rj.plugins.indentline")
				vim.cmd("colorscheme catppuccin")
			end,
		},
	},
	{ "folke/tokyonight.nvim", event = "VeryLazy" },
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",

	--cmp stuff
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
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
	{ "b0o/schemastore.nvim", lazy = false },
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-file-browser.nvim", lazy = false },
			{
				"ahmedkhalf/project.nvim",
			},
		},
		config = function()
			require("rj.plugins.telescope")
		end,
	},
	{ "nvim-telescope/telescope-media-files.nvim" },
	{ "folke/tokyonight.nvim", event = "VeryLazy" },
	{
		"RRethy/vim-illuminate",
		lazy = false,
		config = function()
			require("rj.plugins.illuminate")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/playground",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("rj.plugins.treesitter")
		end,
	},
	{
		"utilyre/barbecue.nvim",
		--branch = "hotfix/colorscheme-switch",
		config = function()
			require("rj.plugins.barbecue")
		end,
		dependencies = {
			{
				"SmiteshP/nvim-navic",
				config = function()
					require("rj.plugins.navic")
				end,
			},
		},
	},
	{
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		tag = "nightly", -- optional, updated every week. (see issue #1193)
		config = function()
			require("rj.plugins.nvim-tree")
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("rj.plugins.alpha-themes.startup-screen3")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("rj.plugins.lualine-themes.lualine1")
		end,
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("rj.plugins.comment")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("rj.plugins.gitsigns")
		end,
	},
	{
		"ghillb/cybu.nvim",
		event = "Bufenter",
		config = function()
			require("rj.plugins.cybu")
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("rj.plugins.lastplace")
		end,
	},
	{ "LunarVim/bigfile.nvim" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("rj.plugins.autopairs")
		end,
	},
	{ "antoinemadec/FixCursorHold.nvim", lazy = false },
	{
		"is0n/jaq-nvim",
		lazy = false,
		cmd = "Jaq",
		config = function()
			require("rj.plugins.jaq")
		end,
	},
	{
		"Darazaki/indent-o-matic",
		config = function()
			require("rj.plugins.indent")
		end,
	},
	{ "MunifTanjim/nui.nvim", lazy = false },
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("rj.plugins.toggleterm")
		end,
	},
	{
		"andweeb/presence.nvim",
		config = function()
			require("rj.plugins.presence")
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			require("rj.plugins.hop")
		end,
	},
	{
		"max397574/better-escape.nvim",
		lazy = false,
		config = function()
			require("rj.plugins.better-escape")
		end,
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("rj.plugins.zen-mode")
		end,
		cmd = "ZenMode",
	},
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
	{
		"mfussenegger/nvim-dap-python",
		commit = "27a0eff2bd3114269bb010d895b179e667e712bd",
		lazy = false,
		config = function()
			require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		commit = "6b12294a57001d994022df8acbe2ef7327d30587",
		lazy = false,
		config = function()
			require("rj.plugins.dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13",
		lazy = false,
		config = function()
			require("rj.plugins.dapui")
		end,
	},
	{
		"ravenxrz/DAPInstall.nvim",
		commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de",
		lazy = true,
		config = function()
			require("dap_install").setup({})
			require("dap_install").config("python", {})
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({})
		end,
	},
})
