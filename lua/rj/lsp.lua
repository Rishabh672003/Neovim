-- Initially taken from [NTBBloodbath](https://github.com/NTBBloodbath/nvim/blob/main/lua/core/lsp.lua)
-- modified almost 80% by me

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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
  close_events = { "CursorMoved", "BufHidden" },
})

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
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}

capabilities.textDocument.completion.completionItem.snippetSupport = true
-- }}}

-- Create keybindings, commands, inlay hints and autocommands on LSP attach {{{
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      -- vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
    end
    ---@diagnostic disable-next-line need-check-nil
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- -- nightly has inbuilt completions, this can replace all completion plugins
    -- if client.supports_method("textDocument/completion") then
    --   -- Enable auto-completion
    --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    -- end

    --- Disable semantic tokens
    ---@diagnostic disable-next-line need-check-nil
    client.server_capabilities.semanticTokensProvider = nil

    -- All the keymaps
    -- stylua: ignore start
    local keymap = vim.keymap.set
    local opts = { silent = true, buffer = true }
    local function opt(desc, others)
      return vim.tbl_extend("force", opts, { desc = desc }, others or {})
    end
    keymap("n", "gD", "<Cmd>Telescope lsp_document_symbols<CR>", opts)
    keymap("n", "gd", "<Cmd>Telescope lsp_definitions<CR>", opts)
    keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover({border='rounded'})<CR>", opts)
    keymap("n", "gI", "<Cmd>Telescope lsp_implementations<CR>", opts)
    keymap("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "gr", "<Cmd>Telescope lsp_references<CR>", opts)
    keymap("n", "gR", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap("n", "gl", "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap("n", "<Leader>la", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opt("Code Action"))
    keymap("n", "<Leader>lf", "<Cmd>Format<CR>", opt("Format"))
    keymap("n", "<Leader>lF", "<Cmd>FormatToggle<CR>", opt("Toggle AutoFormat"))
    keymap( "n", "<Leader>lh", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))<CR>", opt("Toggle Inlayhints"))
    keymap("n", "<Leader>li", "<Cmd>checkhealth vim.lsp<CR>", opt("LspInfo"))
    keymap("n", "<Leader>lI", "<Cmd>Mason<CR>", opt("Mason"))
    keymap("n", "<Leader>lj", "<Cmd>lua vim.diagnostic.goto_next()<CR>", opt("Next Diagnostic"))
    keymap("n", "<Leader>lk", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opt("Prev Diagnostic"))
    keymap("n", "<Leader>ll", "<Cmd>lua vim.lsp.codelens.run()<CR>", opt("Run CodeLens"))
    keymap("n", "<Leader>lq", "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opt("Set LocList"))
    keymap("n", "<Leader>lr", "<Cmd>lua vim.lsp.buf.rename()<CR>", opt("Rename"))
    keymap("n", "<Leader>ls", "<Cmd>Telescope lsp_document_symbols<CR>", opt("Document Symbols"))
    keymap("n", "<Leader>lS", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opt("Workspace Symbols"))
    -- stylua: ignore end
  end,
})
-- }}}

-- Servers {{{
local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_augroup("LSP", {
  clear = false,
})

-- Lua_ls {{{
autocmd("FileType", {
  pattern = "lua",
  group = "LSP",
  callback = function()
    local root_dir = vim.fs.root(0, { ".git", vim.uv.cwd() })
    local client = vim.lsp.start({
      name = "lua_ls",
      cmd = { "lua-language-server" },
      capabilities = capabilities,
      on_init = function(client)
        local path = client.workspace_folders and client.workspace_folders[1].name or vim.fs.root(0, ".")
        ---@diagnostic disable-next-line undefined-field
        if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
          return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            version = "LuaJIT",
          },
          hint = {
            enable = true,
          },
          diagnostics = {
            globals = { "_G", "vim", "MiniFiles", "MiniDeps" },
          },
          workspace = {
            preloadFileSize = 500,
            checkThirdParty = false,
            -- library = vim.api.nvim_get_runtime_file("", true),
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
  group = "LSP",
  callback = function()
    local root_dir = vim.fs.root(0, { "go.mod", "go.work", ".git" })
    local client = vim.lsp.start({
      name = "gopls",
      cmd = { "gopls" },
      root_dir = root_dir,
      capabilities = capabilities,
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

-- C/C++ {{{
autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  group = "LSP",
  callback = function()
    local root_dir = vim.fs.root(0, {
      "CMakeLists.txt",
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac",
      ".git",
      ---@diagnostic disable-next-line undefined-field
      vim.uv.cwd(), -- equivalent of `single_file_mode` in lspconfig
    })
    local client = vim.lsp.start({
      name = "clangd",
      cmd = {
        "clangd",
        "-j=" .. 2,
        "--background-index",
        "--clang-tidy",
        "--inlay-hints",
        "--fallback-style=llvm",
        "--all-scopes-completion",
        "--completion-style=detailed",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
        "--pch-storage=memory",
      },
      root_dir = root_dir,
      capabilities = capabilities,
    })
    if client then
      vim.lsp.buf_attach_client(0, client)
    end
  end,
})
-- }}}

-- Python {{{
autocmd("FileType", {
  pattern = { "python" },
  group = "LSP",
  callback = function()
    local root_dir = vim.fs.root(0, {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "pyrightconfig.json",
      ".git",
      vim.uv.cwd(),
    })
    local client = vim.lsp.start({
      name = "basedpyright",
      cmd = { "basedpyright-langserver", "--stdio" },
      root_dir = root_dir,
      capabilities = capabilities,
      settings = {
        python = {
          venvPath = vim.fn.expand("~") .. "/.virtualenvs",
        },
        basedpyright = {
          disableOrganizeImports = true,
          analysis = {
            autoSearchPaths = true,
            autoImportCompletions = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "openFilesOnly",
            typeCheckingMode = "strict",
            inlayHints = {
              variableTypes = true,
              callArgumentNames = true,
              functionReturnTypes = true,
              genericTypes = false,
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

-- Bash {{{
autocmd("FileType", {
  pattern = { "bash", "sh", "zsh" },
  group = "LSP",
  callback = function()
    local root_dir = vim.fs.root(0, { ".git" })
    local client = vim.lsp.start({
      name = "bashls",
      cmd = { "bash-language-server", "start" },
      root_dir = root_dir,
      capabilities = capabilities,
      settings = {
        bashIde = {
          globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
        },
      },
    })
    if client then
      vim.lsp.buf_attach_client(0, client)
    end
  end,
})
-- }}}

-- Web-dev {{{
-- TSServer {{{
autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  group = "LSP",
  callback = function()
    local root_dir = vim.fs.root(0, { "tsconfig.json", "jsconfig.json", "package.json", ".git" })
    local client = vim.lsp.start({
      name = "ts_ls",
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = root_dir,
      capabilities = capabilities,
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
  group = "LSP",
  callback = function()
    local root_dir = vim.fs.root(0, { "package.json", ".git" })
    local client = vim.lsp.start({
      name = "cssls",
      cmd = { "vscode-css-language-server", "--stdio" },
      root_dir = root_dir,
      capabilities = capabilities,
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
    "ejs",
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  -- }}}
  group = "LSP",
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
    })
    local client = vim.lsp.start({
      name = "tailwindcss",
      cmd = { "tailwindcss-language-server", "--stdio" },
      root_dir = root_dir,
      capabilities = capabilities,
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
  group = "LSP",
  callback = function()
    local root_dir = vim.fs.root(0, { "package.json", ".git" })
    local client = vim.lsp.start({
      name = "html",
      cmd = { "vscode-html-language-server", "--stdio" },
      root_dir = root_dir,
      capabilities = capabilities,
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
-- }}}
--}}}

-- Start, Stop, Restart, Log commands {{{
vim.api.nvim_create_user_command("LspStart", function()
  vim.cmd("e")
end, {})

vim.api.nvim_create_user_command("LspStop", function()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    client.stop()
    vim.notify(client.name .. " stopped")
  end
end, {
  desc = "Stop all LSP clients attached to the current buffer.",
})

vim.api.nvim_create_user_command("LspRestart", function()
  local detach_clients = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    client.stop()
    if vim.tbl_count(client.attached_buffers) > 0 then
      detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
    end
  end
  local timer = vim.uv.new_timer()
  timer:start(
    200,
    50,
    vim.schedule_wrap(function()
      for name, client in pairs(detach_clients) do
        local client_id = vim.lsp.start_client(client[1].config)
        if client_id then
          for _, buf in ipairs(client[2]) do
            vim.lsp.buf_attach_client(buf, client_id)
          end
          vim.notify(name .. ": restarted")
        end
        detach_clients[name] = nil
      end
      if next(detach_clients) == nil and not timer:is_closing() then
        timer:close()
      end
    end)
  )
end, {
  desc = "Restart all the language client(s) attached to the current buffer",
})

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
  desc = "Get all the lsp logs",
})

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("checkhealth vim.lsp")
end, {
  desc = "Get all the information about all LSP attached",
})
-- }}}

-- vim: fdm=marker:fdl=0
--- lsp.lua ends here
