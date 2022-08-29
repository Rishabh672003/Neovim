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
	snapshot_path = fn.stdpath("config") .. "/snapshots",
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

-- plugins installed
return packer.startup(function(use)
	-- My plugins here
	use("lewis6991/impatient.nvim")
	use({ "wbthomason/packer.nvim", auto_clean = true, auto_reload_compiled = true })
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter

	--themes that i use and like
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		run = "CatppuccinCompile",
	})
	-- use("EdenEast/nightfox.nvim")
	-- use("marko-cerovac/material.nvim")
	-- use("folke/tokyonight.nvim")
	-- use("Mofiqul/dracula.nvim")

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use -- Automatically set up your configuration after cloning packer.nvim

	-- LSP
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("jose-elias-alvarez/null-ls.nvim")
	use("RRethy/vim-illuminate")
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	-- use({
	-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	config = function()
	-- 		require("lsp_lines").setup()
	-- 	end,
	-- })

	-- Telescope
	use("nvim-telescope/telescope.nvim")

	--Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/playground")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	-- use("nvim-treesitter/nvim-treesitter-context")

	--alpha-nvim-dashboard
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		-- config = function() require("config.alpha") end,
	})

	--indentation-plugin
	use("Darazaki/indent-o-matic")

	--neovim-ui-enhancerususe
	use("MunifTanjim/nui.nvim")

	--comments
	use({
		"numToStr/Comment.nvim",
		-- tag = "v0.6.1"
	})

	--git-support
	use("lewis6991/gitsigns.nvim")

	--nvim-tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})
	--use "nvim-neo-tree/neo-tree"

	--bufferline
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")

	--which-key
	use("folke/which-key.nvim")

	--toggle-term
	use("akinsho/toggleterm.nvim")

	--Statuslines
	use({
		"nvim-lualine/lualine.nvim",
		-- commit = "8d956c18258bb128ecf42f95411bb26efd3a5d23"
	})
	--use "feline-nvim/feline.nvim"

	--project-manager
	use("ahmedkhalf/project.nvim")

	--indenter
	use("lukas-reineke/indent-blankline.nvim")

	--colorizer
	use("norcalli/nvim-colorizer.lua")

	--markdown viewer
	use("ellisonleao/glow.nvim")

	--used to give notifications
	use("rcarriga/nvim-notify")

	use("stevearc/dressing.nvim")

	use({
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker")
		end,
	})

	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})

	--java
	-- use("mfussenegger/nvim-jdtls")

	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
