local mason = require("mason")

local mason_lspconfig = require("mason-lspconfig")

local servers = {
	"lua_ls",
	"pyright",
	"bashls",
	"jsonls",
	"taplo",
	"tsserver",
	"lemminx",
	"prosemd_lsp",
	"jdtls",
}

local settings = {
	ui = {
		border = "rounded",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})
