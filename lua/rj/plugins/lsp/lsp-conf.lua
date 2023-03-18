local lspconfig = require("lspconfig")

local servers = {
	-- name of server = "name of servers executable"
	taplo = "taplo",
	lemminx = "lemminx",
	prosemd_lsp = "prosemd-lsp",
	jdtls = "jdtls",
	bashls = "bash-language-server",
	html = "vscode-html-language-server",
	jsonls = "vscode-json-language-server",
}
for k, v in pairs(servers) do
	if vim.fn.executable(v) == 1 then
		lspconfig[k].setup({
			on_attach = require("rj.plugins.lsp.attach").on_attach,
			capabilities = require("rj.plugins.lsp.attach").capabilities,
		})
	else
		print("lspconfig: " .. v .. " not found")
	end
end

if vim.fn.executable("rust-analyzer") == 1 then
	lspconfig.rust_analyzer.setup({
		settings = {
			["rust-analyzer"] = {
				diagnostics = {
					enable = false,
				},
			},
		},
	})
else
	print("lspconfig: rust-analyzer not found")
end

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
	print("lspconfig: lua-language-server not found")
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
	print("lspconfig: pyright not found")
end
