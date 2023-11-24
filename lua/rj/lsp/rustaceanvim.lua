vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr)
      require("rj.lsp.attach").on_attach(client, bufnr)
    end,
    capabilities = require("rj.lsp.attach").capabilities,
    settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        inlayHints = {
          bindingModeHints = {
            enable = true,
          },
          chainingHints = {
            enable = true,
          },
          closingBraceHints = {
            enable = true,
            minLines = 25,
          },
          closureReturnTypeHints = {
            enable = "never",
          },
          lifetimeElisionHints = {
            enable = "never",
            useParameterNames = false,
          },
          maxLength = 25,
          parameterHints = {
            enable = true,
          },
          reborrowHints = {
            enable = "never",
          },
          renderColons = true,
          typeHints = {
            enable = true,
            hideClosureInitialization = false,
            hideNamedConstructor = false,
          },
        },
      },
    },
  },
}
