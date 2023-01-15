local mason = require("mason")

local mason_lspconfig = require("mason-lspconfig")

local servers = {
	"sumneko_lua",
	"pyright",
	"bashls",
	"jsonls",
	"taplo",
	"tsserver",
	"lemminx"
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

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("rj.plugins.lsp.attach").on_attach,
		capabilities = require("rj.plugins.lsp.attach").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "rj.plugins.lsp.settings." .. server)
	if require_ok then
	  opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
