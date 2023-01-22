require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "c", "toml", "help", "vim" }, -- put the language you want in this array
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
	indent = { enable = true, disable = { "python" } },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
