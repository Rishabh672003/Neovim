local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- example using a list of specs with the default options
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	{
		"lewis6991/impatient.nvim",
		config = function()
			require("user.impatient")
		end,
	},
	{
		"folke/which-key.nvim",
		-- lazy = true,
		config = function()
			require("user.whichkey")
		end,
	},
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	{
		"windwp/nvim-autopairs",
		config = function()
			require("user.autopairs")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("user.colorschemes.catppuccin")
		end,
	},
	"folke/tokyonight.nvim",
	"L3MON4D3/LuaSnip",
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
			require("user.cmp")
		end,
	},
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	"antoinemadec/FixCursorHold.nvim",
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("user.lsp.null-ls")
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("user.illuminate")
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("user.lsp.mason")
		end,
	},
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	{ "b0o/schemastore.nvim", lazy = true },
	{
		"is0n/jaq-nvim",
		lazy = true,
		cmd = "Jaq",
		config = function()
			require("user.jaq")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-file-browser.nvim", lazy = true, cmd = "Telescope file_browser" },
		},
		config = function()
			require("user.telescope")
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
			require("user.treesitter")
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("user.startup-screens.startup-screen3")
		end,
	},
	"Darazaki/indent-o-matic",
	"MunifTanjim/nui.nvim",
	{
		"numToStr/Comment.nvim",
		-- lazy = true,
		config = function()
			require("user.comment")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		-- lazy = true,
		config = function()
			require("user.gitsigns")
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		tag = "nightly", -- optional, updated every week. (see issue #1193)
		config = function()
			require("user.nvim-tree")
		end,
	},
	{
		"ghillb/cybu.nvim",
		config = function()
			require("user.cybu")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("user.toggleterm")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("user.lualine-themes.lualine1")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("user.project")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("user.indentline")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		lazy = true,
		config = function()
			require("user.colorizer")
		end,
	},
	{ "ellisonleao/glow.nvim", cmd = "Glow" },
	{
		"rcarriga/nvim-notify",
		config = function()
			require("user.notify")
		end,
	},
	"stevearc/dressing.nvim",
	{
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker")
		end,
	},
	"SmiteshP/nvim-navic",
	{
		"utilyre/barbecue.nvim",
		config = function()
			require("user.navic")
			require("user.barbeque.barbeque2")
		end,
	},
	{
		"max397574/better-escape.nvim",
		config = function()
			require("user.better-escape")
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("user.zen-mode")
		end,
		cmd = "ZenMode",
	},
	"ThePrimeagen/vim-be-good",
	{
		"andweeb/presence.nvim",
		config = function()
			require("user.presence")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		commit = "6b12294a57001d994022df8acbe2ef7327d30587",
		lazy = true,
		config = function()
			require("user.dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13",
		lazy = true,
		config = function()
			require("user.dap")
		end,
	},
	{
		"ravenxrz/DAPInstall.nvim",
		commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de",
		lazy = true,
		config = function()
			require("user.dap")
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		commit = "27a0eff2bd3114269bb010d895b179e667e712bd",
		lazy = true,
		config = function()
			require("user.dap")
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("user.last_place")
		end,
	},
	{
		"p00f/clangd_extensions.nvim",
		config = function()
			require("user.lsp.clangd")
		end,
	},
})
