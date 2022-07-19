vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#181825" })

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

-- plugins installed
return packer.startup(function(use)
	-- My plugins here
	use({ "lewis6991/impatient.nvim", commit = "2aa872de40dbbebe8e2d3a0b8c5651b81fe8b235" })
	use({
		"wbthomason/packer.nvim",
		auto_clean = true,
		auto_reload_compiled = true,
		commit = "494fd5999b19e29992eb0978c4fa8988d2023ad8",
	})
	use({ "nvim-lua/popup.nvim", commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac" })
	use({ "nvim-lua/plenary.nvim", commit = "986ad71ae930c7d96e812734540511b4ca838aa2" })
	use({ "windwp/nvim-autopairs", commit = "972a7977e759733dd6721af7bcda7a67e40c010e" })

	--themes that i use and like
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		run = "CatppuccinCompile",
		commit = "5e9358d68b17792821d6f673ab30f6f8633bf2a5",
	})

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "9897465a7663997b7b42372164ffc3635321a2fe" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "981baf9525257ac3269e1b6701e376d6fbff6921" }) -- path completions
	use({ "hrsh7th/cmp-cmdline", commit = "c36ca4bc1dedb12b4ba6546b96c43896fd6e7252" }) -- cmdline completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", commit = "ad7abaeef59ed84d606ec46696096da60bd92ea9" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "8508b996caa9a245efca2ccaeb73e970dafe82cf" }) -- a bunch of snippets to use -- Automatically set up your configuration after cloning packer.nvim

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "347947355ba0a15d803cbd61b18f8bb8f401c793" }) -- enable LSP
	use({ "williamboman/nvim-lsp-installer", commit = "5db1300a98c27a34a8b69ff7c9e768068757326d" }) -- simple to use language server installer
	use({ "antoinemadec/FixCursorHold.nvim", commit = "5aa5ff18da3cdc306bb724cf1a138533768c9f5e" }) -- This is needed to fix lsp doc highlight
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "3651217135b465acb671d404c2534d5c8762af86" })
	use({ "RRethy/vim-illuminate", commit = "6bfa5dc069bd4aa8513a3640d0b73392094749be" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "6bddc38c25af7b50f99cb0c035248d7272971810" })

	--Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		commit = "8b748a7570b89822d47ac0ed0f694efda6523c7d",
	})
	use({ "p00f/nvim-ts-rainbow", commit = "9dd019e84dc3b470dfdb5b05e3bb26158fef8a0c" })
	use({ "nvim-treesitter/playground", commit = "ce7e4b757598f1c785ed0fd94fc65959acd7d39c" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" })

	--alpha-nvim-dashboard
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		commit = "79187fdf8f2a08a7174f237423198f6e75ae213a",
	})

	--indentation-plugin
	use({ "Darazaki/indent-o-matic", commit = "bf37c6e4ccd17197d32dee69cffab4f5bbe4cbf2" })

	--neovim-ui-enhancerususe
	use({ "MunifTanjim/nui.nvim", commit = "2bc2ce904dd7f277c68418ea0d832ec619449ba2" })

	--comments
	use({ "numToStr/Comment.nvim", commit = "2e0572cc35ecc117c0ab6dc0aa3132b109d61047" }) -- Easily comment stuff

	--git-support
	use({ "lewis6991/gitsigns.nvim", commit = "bb6c3bf6f584e73945a0913bb3adf77b60d6f6a2" })

	--nvim-tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
		commit = "ecca8118f8327d66722d8e24361e1ebcacc121dd",
	})

	--bufferline
	use({ "akinsho/bufferline.nvim", commit = "d7b775a35be9c80ed591d3335b35ec84e5c5d81e" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })

	--which-key
	use({ "folke/which-key.nvim", commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71" })

	--toggle-term
	use({ "akinsho/toggleterm.nvim", commit = "5230dde400fd5ef743be7ffcee290012cf5ee6fb" })

	--Statuslines
	use({ "nvim-lualine/lualine.nvim", commit = "655411fb7aa3cf4d46094132d684d815453f5043" })

	--project-manager
	use({ "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" })

	--indenter
	use({ "lukas-reineke/indent-blankline.nvim", commit = "4a58fe6e9854ccfe6c6b0f59abb7cb8301e23025" })

	--colorizer
	use({ "norcalli/nvim-colorizer.lua", commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6" })

	--markdown viewer
	use({ "ellisonleao/glow.nvim", commit = "764527caeb36cd68cbf3f6d905584750cb02229d" })

	--used to give notifications
	use({ "rcarriga/nvim-notify", commit = "74ba257b6cf7fe2b7bb0f6813088ed488baa4a2a" })

	use({ "stevearc/dressing.nvim", commit = "1e60c07ae9a8557ac6395144606c3a5335ad47e0" })
	use({
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker")
		end,
		commit = "fddd49e084d67ed9b98e4c56b1a2afe6bf58f236",
	})

	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
