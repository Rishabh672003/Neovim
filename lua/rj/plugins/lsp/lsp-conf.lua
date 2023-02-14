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

local lspconfig = require("lspconfig")

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
