local lspconfig = require("lspconfig")

lspconfig.bashls.setup({})

require("lspconfig").pyright.setup({
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

lspconfig.jsonls.setup({})

lspconfig.taplo.setup({})
lspconfig.tsserver.setup({})
lspconfig.lemminx.setup({})
lspconfig.prosemd_lsp.setup({})
lspconfig.jdtls.setup({})

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
