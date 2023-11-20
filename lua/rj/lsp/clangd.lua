-- Clangd
if vim.fn.executable("clangd") == 1 then
  require("lspconfig").clangd.setup({
    on_attach = require("rj.lsp.attach").on_attach,
    capabilities = require("rj.lsp.attach").capabilities,
    cmd = {
      "clangd",
      "--background-index",
      "--fallback-style=Google",
      "--all-scopes-completion",
      "--clang-tidy",
      "--log=error",
      "--completion-style=detailed",
      "--pch-storage=memory",
      "--enable-config",
      "--offset-encoding=utf-16",
      "--limit-references=1000",
      "--malloc-trim",
      "--header-insertion=never",
      "--query-driver=<list-of-white-listed-complers>",
    },
  })
  require("clangd_extensions").setup({
    ast = {
      -- These require codicons (https://github.com/microsoft/vscode-codicons)
      role_icons = {
        type = "",
        declaration = "",
        expression = "",
        specifier = "",
        statement = "",
        ["template argument"] = "",
      },

      kind_icons = {
        Compound = "",
        Recovery = "",
        TranslationUnit = "",
        PackExpansion = "",
        TemplateTypeParm = "",
        TemplateTemplateParm = "",
        TemplateParamObject = "",
      },

      highlights = {
        detail = "Comment",
      },
    },
    memory_usage = {
      border = "none",
    },
    symbol_info = {
      border = "none",
    },
  })
else
  print("lspconfig: clangd not found")
end
