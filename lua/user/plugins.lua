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
	use({"lewis6991/impatient.nvim", commit = "2aa872de40dbbebe8e2d3a0b8c5651b81fe8b235"})
	use({ "wbthomason/packer.nvim",
		auto_clean = true,
		auto_reload_compiled = true,
		commit = "494fd5999b19e29992eb0978c4fa8988d2023ad8"})
	use({"nvim-lua/popup.nvim", commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac"}) -- An implementation of the Popup API from vim in Neovim
	use({"nvim-lua/plenary.nvim", commit = "986ad71ae930c7d96e812734540511b4ca838aa2"}) -- Useful lua functions used ny lots of plugins
	use({"windwp/nvim-autopairs", commit = "972a7977e759733dd6721af7bcda7a67e40c010e"}) -- Autopairs, integrates with both cmp and treesitter

	--themes that i use and like
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		run = "CatppuccinCompile",
		commit = "5e9358d68b17792821d6f673ab30f6f8633bf2a5",
	})
	-- use({"marko-cerovac/material.nvim"})
	-- use({"folke/tokyonight.nvim"})
	-- use({"Mofiqul/dracula.nvim"})

	-- cmp plugins
	use({"hrsh7th/nvim-cmp", commit = "9897465a7663997b7b42372164ffc3635321a2fe"}) -- The completion plugin
	use({"hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323"}) -- buffer completions
	use({"hrsh7th/cmp-path", commit = "981baf9525257ac3269e1b6701e376d6fbff6921"}) -- path completions
	use({"hrsh7th/cmp-cmdline", commit = "c36ca4bc1dedb12b4ba6546b96c43896fd6e7252"}) -- cmdline completions
	use({"saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36"}) -- snippet completions
	use({"hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8"})

	-- snippets
	use({"L3MON4D3/LuaSnip", commit = ""}) --snippet engine
	use({"rafamadriz/friendly-snippets"}) -- a bunch of snippets to use -- Automatically set up your configuration after cloning packer.nvim

	-- LSP
	use({"neovim/nvim-lspconfig"}) -- enable LSP
	use({"williamboman/nvim-lsp-installer"}) -- simple to use language server installer
	use({"antoinemadec/FixCursorHold.nvim"}) -- This is needed to fix lsp doc highlight
	use({"jose-elias-alvarez/null-ls.nvim"})
	use({"RRethy/vim-illuminate"})

	-- Telescope
	use({"nvim-telescope/telescope.nvim"})

	--Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({"p00f/nvim-ts-rainbow"})
	use({"nvim-treesitter/playground"})
	use({"JoosepAlviste/nvim-ts-context-commentstring"})
	-- use({"nvim-treesitter/nvim-treesitter-context"})
	--required-for-lualine2
	-- use({{
	-- 	"SmiteshP/nvim-navic",
	-- 	requires = "neovim/nvim-lspconfig",
	-- }})

	--alpha-nvim-dashboard
	use({{
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	}})

	--indentation-plugin
	use({"Darazaki/indent-o-matic"})

	--neovim-ui-enhancerususe
	use({"MunifTanjim/nui.nvim"})

	--comments
	use({"numToStr/Comment.nvim"}) -- Easily comment stuff

	--git-support
	use({"lewis6991/gitsigns.nvim"})

	--nvim-tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		tag = "nightly", -- optional, updated every week. ({see issue #1193})
	})
	--use "nvim-neo-tree/neo-tree"

	--bufferline
	use({"akinsho/bufferline.nvim"})
	use({"moll/vim-bbye"})

	--which-key
	use({"folke/which-key.nvim"})

	--toggle-term
	use({"akinsho/toggleterm.nvim"})

	--Statuslines
	use({"nvim-lualine/lualine.nvim"})
	--use "feline-nvim/feline.nvim"

	--project-manager
	use({"ahmedkhalf/project.nvim"})

	--indenter
	use({"lukas-reineke/indent-blankline.nvim"})

	--colorizer
	use({"norcalli/nvim-colorizer.lua"})

	--markdown viewer
	use({"ellisonleao/glow.nvim"})

	--used to give notifications
	use({"rcarriga/nvim-notify"})

	--this runs code directly from nvim; does not supports most of the languages
	--use({"arjunmahishi/run-code.nvim"})

	use({"stevearc/dressing.nvim"})
	use({
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker")
		end,
	})

	--java
	-- use({"mfussenegger/nvim-jdtls"})

	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
