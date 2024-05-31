local lspconfig = require("lspconfig")

local servers = {
  -- name of server = "name of servers executable"
  bashls = "bash-language-server",
  cmake = "cmake-language-server",
  cssls = "vscode-css-language-server",
  dockerls = "docker-langserver",
  gopls = "gopls",
  html = "vscode-html-language-server",
  jsonls = "vscode-json-language-server",
  lemminx = "lemminx",
  marksman = "marksman",
  sqlls = "sql-language-server",
  taplo = "taplo",
  tsserver = "typescript-language-server",
}
for k, v in pairs(servers) do
  if vim.fn.executable(v) == 1 then
    lspconfig[k].setup({
      on_attach = require("rj.lsp.attach").on_attach,
      capabilities = require("rj.lsp.attach").capabilities,
    })
  else
    vim.notify("LSP servers are not Installed.")
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
end

if vim.fn.executable("pyright") == 1 then
  lspconfig.pyright.setup({
    on_attach = require("rj.lsp.attach").on_attach,
    capabilities = require("rj.lsp.attach").capabilities,
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
end

if vim.fn.executable("yamlls") == 1 then
  require("lspconfig").yamlls.setup({
    -- other configuration for setup {}
    settings = {
      yaml = {
        -- other settings. note this overrides the lspconfig defaults.
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          -- ["../path/relative/to/file.yml"] = "/.github/workflows/*",
          -- ["/path/from/root/of/project"] = "/.github/workflows/*",
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
    },
  })
end
