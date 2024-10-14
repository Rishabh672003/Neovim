local autocmd = vim.api.nvim_create_autocmd

-- Diagnostics {{{
local config = {
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    suffix = "",
  },
}
vim.diagnostic.config(config)
-- }}}

-- Improve LSPs UI {{{
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "rounded", close_events = { "CursorMoved", "BufHidden", "InsertCharPre" } }
)
vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", close_events = { "CursorMoved", "BufHidden" } })

local icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = " ",
  EnumMember = " ",
  Event = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = "󰊕 ",
  Interface = " ",
  Keyword = " ",
  Method = "ƒ ",
  Module = "󰏗 ",
  Property = " ",
  Snippet = " ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
  completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end
-- }}}

-- Lsp capabilities {{{
-- Here we grab default Neovim capabilities and extend them with ones we want on top
Capabilities = vim.lsp.protocol.make_client_capabilities()

Capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}
Capabilities.textDocument.completion.completionItem.snippetSupport = false
-- }}}

-- Create keybindings, commands and autocommands on LSP attach {{{
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    --- Set omnifunc completion and use LSP for finding tags whenever possible
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    --- Disable semantic tokens
    ---@diagnostic disable-next-line need-check-nil
    client.server_capabilities.semanticTokensProvider = nil

    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true, buffer = true }
    keymap("n", "gD", "<cmd>Telescope lsp_document_symbols<CR>", opts)
    keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
    keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    keymap("n", "gR", '<cmd>lua require("trouble").toggle("lsp_references")<CR>', opts)
    keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap("n", "<leader>lF", "<cmd>FormatToggle<cr>", opts)
    keymap("n", "<leader>lI", "<cmd>Mason<cr>", opts)
    keymap("n", "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts)
    keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    keymap("n", "<leader>lf", "<cmd>Format<cr>", opts)
    keymap("n", "<leader>lh", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))<cr>", opts)
    keymap("n", "<leader>li", "<cmd>checkhealth vim.lsp<cr>", opts)
    keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
    keymap("n", "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", opts)
    keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    keymap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", opts)
  end,
})
-- }}}

-- Servers {{{
-- Lua_ls {{{
autocmd("FileType", {
  pattern = "lua",
  callback = function()
    local root_dir = vim.fs.root(0, { ".git" })
    local client = vim.lsp.start({
      name = "lua_ls",
      cmd = { "lua-language-server" },
      capabilities = Capabilities,
      on_init = function(client)
        local path = client.workspace_folders and client.workspace_folders[1].name or vim.fs.root(0, ".")
        ---@diagnostic disable-next-line undefined-field
        if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          hint = {
            enable = true,
          },
          diagnostics = {
            globals = { "_G", "vim" },
          },
          workspace = {
            preloadFileSize = 500,
            checkThirdParty = false,
          },
        })
      end,
      root_dir = root_dir,
      settings = {
        Lua = {
          telemetry = {
            enable = false,
          },
        },
      },
    })
    if client then
      vim.lsp.buf_attach_client(0, client)
    end
  end,
})
-- }}}

-- Gopls {{{
autocmd("FileType", {
  pattern = { "go", "gotempl", "gowork", "gomod" },
  callback = function()
    local root_dir = vim.fs.root(0, { "go.mod", "go.work", ".git" })
    local client = vim.lsp.start({
      name = "gopls",
      cmd = { "gopls" },
      root_dir = root_dir,
      capabilities = Capabilities,
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
    if client then
      vim.lsp.buf_attach_client(0, client)
    end
  end,
})

--}}}

-- -- C/C++ {{{
-- autocmd("FileType", {
--   pattern = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
--   callback = function()
--     local root_dir = vim.fs.root(0, {
--       "CMakeLists.txt",
--       ".clangd",
--       ".clang-tidy",
--       ".clang-format",
--       "compile_commands.json",
--       "compile_flags.txt",
--       "configure.ac",
--       ".git",
--       ---@diagnostic disable-next-line undefined-field
--       vim.uv.cwd(), -- equivalent of `single_file_mode` in lspconfig
--     })
--     local client = vim.lsp.start({
--       name = "clangd",
--       cmd = {
--         "clangd",
--         "-j=" .. 2,
--         "--background-index",
--         "--clang-tidy",
--         "--inlay-hints",
--         "--fallback-style=llvm",
--         "--all-scopes-completion",
--         "--completion-style=detailed",
--         "--header-insertion=iwyu",
--         "--header-insertion-decorators",
--         "--pch-storage=memory",
--       },
--       root_dir = root_dir,
--       capabilities = Capabilities,
--     })
--     if client then
--       vim.lsp.buf_attach_client(0, client)
--     end
--   end,
-- })
-- -- }}}

-- Python {{{
autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    local root_dir = vim.fs.root(0, {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "pyrightconfig.json",
      ".git",
      vim.fn.getcwd(),
    })
    local client = vim.lsp.start({
      name = "pyright",
      cmd = { "pyright-langserver", "--stdio" },
      root_dir = root_dir,
      capabilities = Capabilities,
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
    if client then
      vim.lsp.buf_attach_client(0, client)
    end
  end,
})
-- }}}

-- TSServer {{{
autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  callback = function()
    local root_dir = vim.fs.root(0, { "tsconfig.json", "jsconfig.json", "package.json", ".git" })
    local client = vim.lsp.start({
      name = "ts_ls",
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = root_dir,
      capabilities = Capabilities,
      init_options = {
        hostInfo = "neovim",
      },
    })
    if client then
      vim.lsp.buf_attach_client(0, client)
    end
  end,
})
-- }}}

-- CSSls {{{
autocmd("FileType", {
  pattern = { "css", "scss" },
  callback = function()
    local root_dir = vim.fs.root(0, { "package.json", ".git" })
    local client = vim.lsp.start({
      name = "cssls",
      cmd = { "vscode-css-language-server", "--stdio" },
      root_dir = root_dir,
      capabilities = Capabilities,
      init_options = {
        provideFormatter = true,
      },
    })
    if client then
      vim.lsp.buf_attach_client(0, client)
    end
  end,
})
-- }}}

-- TailwindCss {{{
autocmd("FileType", {
  -- pattern {{{
  pattern = {
    "aspnetcorerazor",
    "astro",
    "astro-markdown",
    "blade",
    "clojure",
    "django-html",
    "htmldjango",
    "edge",
    "eelixir",
    "elixir",
    "ejs",
    "erb",
    "eruby",
    "gohtml",
    "gohtmltmpl",
    "haml",
    "handlebars",
    "hbs",
    "html",
    "htmlangular",
    "html-eex",
    "heex",
    "jade",
    "leaf",
    "liquid",
    -- "markdown",
    "mdx",
    "mustache",
    "njk",
    "nunjucks",
    "php",
    "razor",
    "slim",
    "twig",
    "css",
    "less",
    "postcss",
    "sass",
    "scss",
    "stylus",
    "sugarss",
    "javascript",
    "javascriptreact",
    "reason",
    "rescript",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "templ",
  },
  -- }}}
  callback = function()
    local root_dir = vim.fs.root(0, {
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.mjs",
      "tailwind.config.ts",
      "postcss.config.js",
      "postcss.config.cjs",
      "postcss.config.mjs",
      "postcss.config.ts",
      "package.json",
      "node_modules",
      ".git",
    })
    local client = vim.lsp.start({
      name = "tailwindcss",
      cmd = { "tailwindcss-language-server", "--stdio" },
      root_dir = root_dir,
      capabilities = Capabilities,
      settings = {
        tailwindCSS = {
          classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
          includeLanguages = {
            eelixir = "html-eex",
            eruby = "erb",
            htmlangular = "html",
            templ = "html",
          },
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning",
          },
          validate = true,
        },
      },
    })
    if client then
      vim.lsp.buf_attach_client(0, client)
    end
  end,
})
-- }}}

-- HTML {{{
autocmd("FileType", {
  pattern = { "html" },
  callback = function()
    local root_dir = vim.fs.root(0, { "package.json", ".git" })
    local client = vim.lsp.start({
      name = "html",
      cmd = { "vscode-html-language-server", "--stdio" },
      root_dir = root_dir,
      capabilities = Capabilities,
      init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
          css = true,
          javascript = true,
        },
        provideFormatter = true,
      },
    })
    if client then
      vim.lsp.buf_attach_client(0, client)
    end
  end,
})
-- }}}
--}}}

-- Stop, Restart, Log commands {{{
vim.api.nvim_create_user_command("LspStop", function(kwargs)
  local name = kwargs.fargs[1]
  for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
    client.stop()
  end
end, {
  nargs = 1,
  complete = function()
    return vim.tbl_map(function(c)
      return c.name
    end, vim.lsp.get_clients())
  end,
})

vim.api.nvim_create_user_command("LspRestart", function(kwargs)
  local name = kwargs.fargs[1]
  for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
    local bufs = vim.lsp.get_buffers_by_client_id(client.id)
    client.stop()
    vim.wait(10000, function()
      return vim.lsp.get_client_by_id(client.id) == nil
    end)
    local client_id = vim.lsp.start_client(client.config)
    if client_id then
      for _, buf in ipairs(bufs) do
        vim.lsp.buf_attach_client(buf, client_id)
      end
    end
  end
end, {
  nargs = 1,
  complete = function()
    return vim.tbl_map(function(c)
      return c.name
    end, vim.lsp.get_clients())
  end,
})

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {})

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("checkhealth vim.lsp")
end, {})
-- }}}

-- vim: fdm=marker:fdl=0
--- lsp.lua ends here
