require("user.options")
require("user.lazy")
require("user.keymaps")
require("user.autocommands")
require("user.colorscheme")

-- this is for the fix of clangd otherwise it keeps giving some error
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.offsetEncoding = { "utf-16" }
-- require("lspconfig").clangd.setup({ capabilities = capabilities })

