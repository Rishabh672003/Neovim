local M = {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPost",
	dependencies = {
		"nvim-treesitter/playground",
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-tree/nvim-web-devicons",
		},
	},
}

function M.config()
	local configs = require("nvim-treesitter.configs")
	configs.setup({
		ensure_installed = {
			"lua",
			"markdown",
			"markdown_inline",
			"bash",
			"python",
			"c",
			"cpp",
			"toml",
			"vim",
			"vimdoc",
			"html",
			"python",
			"html",
			"css",
			"javascript",
			"java",
		}, -- put the language you want in this array
		-- ensure_installed = "all",
		sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
		ignore_install = {}, -- List of parsers to ignore installing
		autopairs = {
			enable = true,
		},
		highlight = {
			enable = true, -- false will disable the whole extension
			disable = {}, -- list of language that will be disabled
			-- additional_vim_regex_highlighting = true,
		},
		indent = { enable = true, disable = { "python", "html", "cpp" } },
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
	})
end

return M
