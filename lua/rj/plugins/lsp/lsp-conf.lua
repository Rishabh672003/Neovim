local lspconfig = require("lspconfig")

if vim.fn.executable("lua-language-server") == 1 then
	lspconfig.lua_ls.setup({
		on_attach = require("rj.plugins.lsp.attach").on_attach,
		capabilities = require("rj.plugins.lsp.attach").capabilities,
		settings = {
			Lua = {
				format = {
					enable = false,
				},
				hint = {
					enable = true,
					arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
					await = true,
					paramName = "Disable", -- "All", "Literal", "Disable"
					paramType = false,
					semicolon = "Disable", -- "All", "SameLine", "Disable"
					setType = true,
				},
				-- spell = {"the"}
				runtime = {
					version = "LuaJIT",
					special = {
						reload = "require",
					},
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
						checkThirdParty = false,
					},
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})
else
	print("lua-language-server not found")
end

if vim.fn.executable("pyright") == 1 then
	require("lspconfig").pyright.setup({
		on_attach = require("rj.plugins.lsp.attach").on_attach,
		capabilities = require("rj.plugins.lsp.attach").capabilities,
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "basic",
					-- diagnosticMode = "workspace",
					inlayHints = {
						variableTypes = true,
						functionReturnTypes = true,
					},
				},
			},
		},
	})
else
	print("pyright not found")
end

if vim.fn.executable("vscode-json-language-server") == 1 then
	lspconfig.jsonls.setup({
		on_attach = require("rj.plugins.lsp.attach").on_attach,
		capabilities = require("rj.plugins.lsp.attach").capabilities,
	})
else
	print("vscode-json-language-server not found")
end

if vim.fn.executable("taplo") == 1 then
	lspconfig.taplo.setup({
		on_attach = require("rj.plugins.lsp.attach").on_attach,
		capabilities = require("rj.plugins.lsp.attach").capabilities,
	})
else
	print("taplo not found")
end

if vim.fn.executable("lemminx") == 1 then
	lspconfig.lemminx.setup({
		on_attach = require("rj.plugins.lsp.attach").on_attach,
		capabilities = require("rj.plugins.lsp.attach").capabilities,
	})
else
	print("lemminx not found")
end

if vim.fn.executable("prosemd-lsp") == 1 then
	lspconfig.prosemd_lsp.setup({
		on_attach = require("rj.plugins.lsp.attach").on_attach,
		capabilities = require("rj.plugins.lsp.attach").capabilities,
	})
else
	print("prosemd_lsp not found")
end

if vim.fn.executable("jdtls") == 1 then
	lspconfig.jdtls.setup({
		on_attach = require("rj.plugins.lsp.attach").on_attach,
		capabilities = require("rj.plugins.lsp.attach").capabilities,
	})
else
	print("jdtls not found")
end

if vim.fn.executable("bash-language-server") == 1 then
	lspconfig.bashls.setup({
		on_attach = require("rj.plugins.lsp.attach").on_attach,
		capabilities = require("rj.plugins.lsp.attach").capabilities,
	})
else
	print("bash-language-server not found")
end
