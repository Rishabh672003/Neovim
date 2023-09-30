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
      "--suggest-missing-includes",
      "--cross-file-rename",
      "--completion-style=detailed",
      "--pch-storage=memory",
      "--folding-ranges",
      "--enable-config",
      "--offset-encoding=utf-16",
      "--limit-references=1000",
      "--malloc-trim",
      "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
      "--header-insertion=never",
      "--query-driver=<list-of-white-listed-complers>",
    },
  })
  require("clangd_extensions").setup({
    inlay_hints = {
      inline = vim.fn.has("nvim-0.10") == 1,
      -- Options other than `highlight' and `priority' only work
      -- if `inline' is disabled
      -- Only show inlay hints for the current line
      only_current_line = false,
      -- Event which triggers a refresh of the inlay hints.
      -- You can make this { "CursorMoved" } or { "CursorMoved,CursorMovedI" } but
      -- not that this may cause  higher CPU usage.
      -- This option is only respected when only_current_line and
      -- autoSetHints both are true.
      only_current_line_autocmd = { "CursorHold" },
      -- whether to show parameter hints with the inlay hints or not
      show_parameter_hints = true,
      -- prefix for parameter hints
      parameter_hints_prefix = "<- ",
      -- prefix for all the other hints (type, chaining)
      other_hints_prefix = "=> ",
      -- whether to align to the length of the longest line in the file
      max_len_align = false,
      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,
      -- whether to align to the extreme right or not
      right_align = false,
      -- padding from the right if right_align is true
      right_align_padding = 7,
      -- The color of the hints
      highlight = "Comment",
      -- The highlight group priority for extmark
      priority = 100,
    },
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
  local inlay_hints = require("clangd_extensions.inlay_hints")

  inlay_hints.setup_autocmd()
  inlay_hints.set_inlay_hints()
  inlay_hints.toggle_inlay_hints()
else
  print("lspconfig: clangd not found")
end
