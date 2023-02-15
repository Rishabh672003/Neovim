local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			type = {
				-- weakUnionCheck = true,
				-- weakNilCheck = true,
				-- castNumberToInteger = true,
			},
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
					-- [vim.fn.datapath "config" .. "/lua"] = true,
				},
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

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
require("lspconfig").lemminx.setup({})
require("lspconfig").prosemd_lsp.setup({})
require("lspconfig").jdtls.setup({})
