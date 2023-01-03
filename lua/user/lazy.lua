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
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("user.colorschemes.catppuccin")
			vim.cmd("colorscheme catppuccin")
		end,
		dependencies = {
			"lukas-reineke/indent-blankline.nvim",
			event = "InsertEnter",
			config = function()
				require("user.indentline")
			end,
		},
	},
	"neovim/nvim-lspconfig",
	{
		"williamboman/mason.nvim",
		config = function()
			require("user.lsp.mason")
			require("user.lsp.diagnostic")
			require("user.lsp.attach")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"p00f/clangd_extensions.nvim",
		lazy = false,
		event = "Bufenter",
		config = function()
			require("user.lsp.clangd")
		end,
	},
	{
		"lewis6991/satellite.nvim",
		config = function()
			require("satellite").setup({
				excluded_filetypes = { "NvimTree" },
			})
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("user.whichkey")
		end,
	},
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("user.autopairs")
		end,
	},
	{ "folke/tokyonight.nvim", event = "VeryLazy" },
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
	{ "antoinemadec/FixCursorHold.nvim", lazy = false },
	{
		"jose-elias-alvarez/null-ls.nvim",
		-- event = "InsertEnter",
		config = function()
			require("user.lsp.null-ls")
		end,
	},
	{
		"RRethy/vim-illuminate",
		lazy = false,
		config = function()
			require("user.illuminate")
		end,
	},
	{ "b0o/schemastore.nvim", lazy = false },
	{
		"is0n/jaq-nvim",
		lazy = false,
		cmd = "Jaq",
		config = function()
			require("user.jaq")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-file-browser.nvim", lazy = false },
			{
				"ahmedkhalf/project.nvim",
				config = function()
					require("user.project")
				end,
			},
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
	-- { "Darazaki/indent-o-matic" },
	{ "MunifTanjim/nui.nvim", lazy = false },
	{
		"numToStr/Comment.nvim",
		-- lazy=false,
		config = function()
			require("user.comment")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		-- lazy=false,
		config = function()
			require("user.gitsigns")
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		tag = "nightly", -- optional, updated every week. (see issue #1193)
		config = function()
			require("user.nvim-tree")
		end,
	},
	{
		"ghillb/cybu.nvim",
		event = "Bufenter",
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
		"NvChad/nvim-colorizer.lua",
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
		-- commit = "0e65d1521bab8afbd1b2a40a50f859d7bca5ffbd",
		commit = "c9a16e6d8198dccfd9613f338669d1fdd970666a",
		-- commit = "d67e116e6113735fb11f236d4439d7e06b5596af",
		-- commit = "44f5b37da1a27ec06dc9faf7d5a10740ccbf357c",
		config = function()
			require("user.navic")
			require("user.barbeque.barbeque2")
		end,
	},
	{
		"max397574/better-escape.nvim",
		lazy = false,
		config = function()
			require("user.better-escape")
		end,
	},
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			require("user.hop")
		end,
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("user.zen-mode")
		end,
		cmd = "ZenMode",
	},
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
	{
		"andweeb/presence.nvim",
		config = function()
			require("user.presence")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		commit = "6b12294a57001d994022df8acbe2ef7327d30587",
		lazy = false,
		config = function()
			require("user.dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13",
		lazy = false,
		config = function()
			require("user.dapui")
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
		"mfussenegger/nvim-dap-python",
		commit = "27a0eff2bd3114269bb010d895b179e667e712bd",
		lazy = false,
		config = function()
			require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("user.last_place")
		end,
	},
	{ "LunarVim/bigfile.nvim" },
})
