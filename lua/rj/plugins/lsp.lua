return {
	{
		"neovim/nvim-lspconfig",
		ft = {
			"markdown",
			"lua",
			"c",
			"cpp",
			"java",
			"python",
			"json",
			"xml",
			"bash",
			"sh",
			"toml",
			"zsh",
			"rust",
			"html",
			"javascript",
			"javascriptreact",
			"typescript",
			"python",
		},
		lazy = false,
		config = function()
			require("rj.lsp.attach")
			require("rj.lsp.lsp-conf")
			require("rj.lsp.diagnostic")
		end,
	},
	{
		"p00f/clangd_extensions.nvim",
		ft = { "c", "cpp" },
		lazy = false,
		config = function()
			require("rj.lsp.clangd")
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust" },
		lazy = false,
		config = function()
			require("rj.lsp.rust-tools")
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufRead", "BufNew" },
		lazy = false,
		config = function()
			require("rj.lsp.null-ls")
		end,
	},
}
