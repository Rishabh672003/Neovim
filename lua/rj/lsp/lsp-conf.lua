local lspconfig = require("lspconfig")

local servers = {
  -- name of server = "name of servers executable"
  bashls = "bash-language-server",
  cmake = "cmake-language-server",
  cssls = "vscode-css-language-server",
  dockerls = "docker-langserver",
  html = "vscode-html-language-server",
  hyprls = "hyprls",
  jsonls = "vscode-json-language-server",
  lemminx = "lemminx",
  marksman = "marksman",
  taplo = "taplo",
  ts_ls = "typescript-language-server",
}
for k, v in pairs(servers) do
  if vim.fn.executable(v) == 1 then
    lspconfig[k].setup({
      on_attach = require("rj.lsp.attach").on_attach,
      capabilities = require("rj.lsp.attach").capabilities,
    })
  else
    vim.notify(string.format("LSP server: %s is not Installed.", k))
    vim.notify("Run - :MasonToolsInstall to install all the LSP")
  end
end

if vim.fn.executable("lua-language-server") == 1 then
  lspconfig.lua_ls.setup({
    on_attach = require("rj.lsp.attach").on_attach,
    capabilities = require("rj.lsp.attach").capabilities,
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
        -- spell = { "the" },
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
end

if vim.fn.executable("pyright") == 1 then
  lspconfig.pyright.setup({
    on_attach = require("rj.lsp.attach").on_attach,
    capabilities = require("rj.lsp.attach").capabilities,
    settings = {
      python = {
        analysis = {
          -- showDiagnostics = true,
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
end

if vim.fn.executable("gopls") == 1 then
  lspconfig.gopls.setup({
    on_attach = require("rj.lsp.attach").on_attach,
    capabilities = require("rj.lsp.attach").capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
        ["ui.inlayhint.hints"] = {
          compositeLiteralFields = true,
          constantValues = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  })
end

if vim.fn.executable("yaml-language-server") == 1 then
  require("lspconfig").yamlls.setup({
    settings = {
      yaml = {
        -- other settings. note this overrides the lspconfig defaults.
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        },
      },
    },
  })
end

if vim.fn.executable("tailwindcss-language-server") == 1 then
  lspconfig.tailwindcss.setup({
    filetypes = {
      "html",
      "css",
      "scss",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
    },
  })
end
