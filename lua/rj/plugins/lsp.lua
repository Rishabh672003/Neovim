return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"nvim-lua/plenary.nvim",
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
		lazy = true,
		config = function()
			require("rj.lsp.clangd")
		end,
	},
	{
		"Ciel-MC/rust-tools.nvim",
		-- branch = "inline-inlay-hints",
		ft = { "rust" },
		lazy = true,
		config = function()
			require("rj.lsp.rust-tools")
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufRead", "BufNew" },
		lazy = true,
		config = function()
			require("rj.lsp.null-ls")
		end,
	},
}
