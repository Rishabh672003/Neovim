local servers = {
	"sumneko_lua",
	"pyright",
	"bashls",
	"autopep8",
	"stylua",
	"beautysh",
	"shellcheck",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

local _, mason = pcall(require, "mason")
if not _ then
	return
end

local _, mason_lspconfig = pcall(require, "mason-lspconfig")
if not _ then
	return
end

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
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	if server == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
		-- opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
	end

	if server == "pyright" then
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "autopep8" then
		return
	end

	if server == "beautysh" then
		return
	end

	if server == "shellcheck" then
		return
	end

	lspconfig[server].setup(opts)
end
