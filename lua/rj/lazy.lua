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
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("rj.plugins.catppuccin")
		end,
		dependencies = {},
	},
	-- { "folke/tokyonight.nvim", event = "VeryLazy" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("rj.plugins.whichkey")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = function()
			require("rj.plugins.indentline")
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("rj.plugins.noice")
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				-- event = "VeryLazy",
				config = function()
					require("rj.plugins.notify")
				end,
			},
		},
	},
	"nvim-lua/popup.nvim",
	{ "nvim-lua/plenary.nvim", lazy = true },
	--cmp stuff
	{
		"hrsh7th/nvim-cmp",
		event = {
			"InsertEnter",
			-- "CmdlineEnter",
		},
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			{
				"jcdickinson/codeium.nvim",
				dependencies = {
					"nvim-lua/plenary.nvim",
					"MunifTanjim/nui.nvim",
					"hrsh7th/nvim-cmp",
				},
				config = function()
					require("codeium").setup({})
				end,
			},
		},
		config = function()
			require("rj.plugins.nvim-cmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		config = function()
			require("rj.plugins.nvim-luasnip")
		end,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},
	{ "neovim/nvim-lspconfig", lazy = true },
	{
		"williamboman/mason.nvim",
		config = function()
			require("rj.plugins.lsp.mason")
		end,
		dependencies = {
			{ "b0o/schemastore.nvim", lazy = true },
			{
				"williamboman/mason-lspconfig.nvim",
				lazy = true,
			},
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		config = function()
			require("rj.plugins.lsp.null-ls")
		end,
	},
	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
		ft = { "c", "cpp" },
		config = function()
			require("rj.plugins.lsp.clangd")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "BufEnter",
		cmd = { "Telescope" },
		dependencies = {
			{ "nvim-telescope/telescope-file-browser.nvim", lazy = true },
			{
				"ahmedkhalf/project.nvim",
			},
		},
		config = function()
			require("rj.plugins.nvim-telescope")
		end,
	},
	{ "folke/tokyonight.nvim", event = "VeryLazy" },
	{
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		config = function()
			require("rj.plugins.illuminate")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPost",
		dependencies = {
			"nvim-treesitter/playground",
			{
				"JoosepAlviste/nvim-ts-context-commentstring", --[[ event = "VeryLazy" ]]
			},
			{
				"kyazdani42/nvim-web-devicons",
				config = function()
					require("nvim-web-devicons").setup({
						override = {
							zsh = {
								icon = "",
								color = "#428850",
								cterm_color = "65",
								name = "Zsh",
							},
						},
						color_icons = true,
						default = true,
					})
				end,
			},
		},
		config = function()
			require("rj.plugins.treesitter")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("rj.plugins.colorizer")
		end,
	},
	{
		"utilyre/barbecue.nvim",
		event = { "BufReadPre", "BufAdd", "BufNew" },
		config = function()
			require("rj.plugins.barbecue.barbecue")
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
		tag = "nightly",
		config = function()
			require("rj.plugins.nvim-tree")
		end,
	},
	{
		"is0n/jaq-nvim",
		cmd = "Jaq",
		config = function()
			require("rj.plugins.jaq")
		end,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			require("rj.plugins.alpha-themes.startup-screen3")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		-- event = "BufReadPre",
		config = function()
			require("rj.plugins.lualine-themes.lualine1")
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = "BufRead",
		config = function()
			require("rj.plugins.comment")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		config = function()
			require("rj.plugins.gitsigns")
		end,
	},
	{
		"ghillb/cybu.nvim",
		event = "BufReadPre",
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
	{ "LunarVim/bigfile.nvim", event = "BufReadPre" },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("rj.plugins.autopairs")
		end,
	},
	{ "antoinemadec/FixCursorHold.nvim", lazy = false, event = "BufReadPre" },
	{
		"Darazaki/indent-o-matic",
		event = "BufReadPre",
		config = function()
			require("rj.plugins.indent")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		config = function()
			require("rj.plugins.toggleterm")
		end,
	},
	{
		"andweeb/presence.nvim",
		event = "BufReadPre",
		config = function()
			require("rj.plugins.presence")
		end,
	},
	{
		"phaazon/hop.nvim",
		event = "BufReadPre",
		branch = "v2", -- optional but strongly recommended
		config = function()
			require("rj.plugins.hop")
		end,
	},
	{
		"max397574/better-escape.nvim",
		event = "BufRead",
		config = function()
			require("rj.plugins.better-escape")
		end,
	},
	{
		"j-hui/fidget.nvim",
		event = "BufReadPre",
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		config = function()
			require("rj.plugins.zen-mode")
		end,
	},
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
	{
		"mfussenegger/nvim-dap-python",
		commit = "27a0eff2bd3114269bb010d895b179e667e712bd",
		event = "BufReadPost",
		config = function()
			require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		commit = "6b12294a57001d994022df8acbe2ef7327d30587",
		event = "BufReadPost",
		config = function()
			require("rj.plugins.dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13",
		event = "BufReadPost",
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
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		-- event = "VeryLazy",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"nvim-neorg/neorg",
		lazy = true,
		ft = "norg",
		cmd = "Neorg",
		build = ":Neorg sync-parsers",
		opts = {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
				["core.norg.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/notes",
						},
					},
				},
			},
		},
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},
	-- {
	-- 	"lewis6991/satellite.nvim",
	-- 	config = function()
	-- 		require("satellite").setup()
	-- 	end,
	-- },
	-- {
	-- 	"Pocco81/auto-save.nvim",
	-- 	config = function()
	-- 		require("auto-save").setup({
	-- 			enabled = false,
	-- 		})
	-- 	end,
	-- },
})
