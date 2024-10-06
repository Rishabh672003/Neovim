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
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.snippetSupport = false
-- }}}

-- Servers definition {{{
---@type table<string, vim.lsp.ClientConfig>
local servers = {
  -- Lua {{{
  lua_ls = {
    name = "lua_ls",
    cmd = { "lua-language-server" },
    root_dir = ".git",
    filetypes = { "lua" },
    capabilities = capabilities,
    on_init = function(client)
      local path = client.workspace_folders and client.workspace_folders[1].name or vim.fs.root(0, ".")
      ---@diagnostic disable-next-line undefined-field
      if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
        return
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        hint = {
          enable = true,
        },
        diagnostics = {
          globals = { "_G", "vim" },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          preloadFileSize = 500,
          checkThirdParty = false,
          -- library = {
          --   vim.env.VIMRUNTIME
          -- }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          library = vim.api.nvim_get_runtime_file("", true),
        },
      })
    end,
    settings = {
      Lua = {
        telemetry = {
          enable = false,
        },
      },
    },
  },
  -- }}}
  -- Python {{{
  pyright = {
    name = "pyright",
    cmd = { "pyright-langserver", "--stdio" },
    root_dir = vim.fs.root(
      0,
      { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" }
    ),
    filetypes = { "python" },
    capabilities = capabilities,
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
  },
  -- }}}
  -- Go {{{
  gopls = {
    name = "gopls",
    cmd = { "gopls" },
    root_dir = vim.fs.root(0, { ".git", "go.sum", "go.mod" }),
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
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
  },
  -- }}}
  -- -- C/C++ {{{
  -- -- NOTE: the CORES environment variable is declared in my shell configuration
  clangd = {
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
    root_dir = vim.fs.root(0, {
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac",
      ".git",
      ---@diagnostic disable-next-line undefined-field
      vim.uv.cwd(), -- equivalent of `single_file_mode` in lspconfig
    }),
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    capabilities = capabilities,
  },
  -- -- }}}
  -- TSServer {{{
  tsserver = {
    name = "tsserver",
    cmd = { "typescript-language-server", "--stdio" },
    root_dir = vim.fs.root(0, { "tsconfig.json", "jsconfig.json", "package.json", ".git" }),
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    capabilities = capabilities,
    init_options = {
      hostInfo = "neovim",
    },
  },
  -- }}}
  -- CSSLS {{{
  -- NOTE: install with 'npm i -g vscode-langservers-extracted'
  cssls = {
    name = "cssls",
    cmd = { "vscode-css-language-server", "--stdio" },
    root_dir = vim.fs.root(0, { "package.json", ".git" }),
    filetypes = { "css", "scss" },
    capabilities = capabilities,
    init_options = {
      provideFormatter = true,
    },
  },
  -- }}}
  -- TailwindCSS {{{
  -- NOTE: install with 'npm install -g @tailwindcss/language-server'
  tailwind = {
    name = "tailwindcss",
    cmd = { "tailwindcss-language-server", "--stdio" },
    root_dir = vim.fs.root(0, {
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
    }),
    filetypes = {
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
  },
  -- }}}
  -- HTML {{{
  -- NOTE: installed with 'npm i -g vscode-langservers-extracted'
  html = {
    name = "html",
    cmd = { "vscode-html-language-server", "--stdio" },
    root_dir = vim.fs.root(0, { "package.json", ".git" }),
    filetypes = { "html", "templ" },
    capabilities = capabilities,
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
      provideFormatter = true,
    },
  },
  -- }}}
}
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
    keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
    keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
    keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
    keymap("n", "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", opts)
    keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    keymap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", opts)
  end,
})
-- }}}

-- Global commands (start, stop, restart, etc) {{{
-- rust-analyzer is handled by rustaceanvim so we save some time ignoring it
if vim.fn.expand("%:e") ~= "rs" then
  -- Start {{{
  -- Initializes all the possible clients for the current buffer if no arguments were passed
  local function start_lsp_client(name, filetypes)
    -- Do not try to initialize the LSP if it is not installed
    if
      vim.iter(filetypes):find(vim.api.nvim_get_option_value("filetype", { buf = 0 }))
      and vim.fn.executable(servers[name].cmd[1]) == 1
    then
      local active_clients_in_buffer = vim
        .iter(vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() }))
        :map(function(client)
          return client.name
        end)
        :totable()
      -- Do not duplicate the server if there is already a server attached to the buffer
      if not vim.iter(active_clients_in_buffer):find(servers[name].name) then
        vim.notify("[core.lsp] Starting " .. name .. ", it could take a bit of time ...")
        ---@diagnostic disable-next-line
        vim.lsp.start(servers[name], { bufnr = vim.api.nvim_get_current_buf() })
      end
    end
  end

  vim.api.nvim_create_user_command("LspStart", function(args)
    if #args.fargs < 1 then
      vim
        .iter(servers)
        :map(function(s)
          return { [s] = servers[s].filetypes }
        end)
        :map(function(s)
          for server, filetypes in pairs(s) do
            start_lsp_client(server, filetypes)
          end
        end)
        :totable()
    else
      for _, server in ipairs(args.fargs) do
        ---@diagnostic disable-next-line undefined-field
        start_lsp_client(server, servers[server].filetypes)
      end
    end
  end, {
    nargs = "*",
    complete = function(args)
      local server_names = vim
        .iter(servers)
        :map(function(s)
          return s
        end)
        :totable()
      if #args < 1 then
        return server_names
      end

      local match = vim
        .iter(server_names)
        :filter(function(server)
          if string.find(server, "^" .. args) then
            return server
            ---@diagnostic disable-next-line missing-return
          end
        end)
        :totable()
      return match
    end,
  })
  -- }}}

  -- Stop {{{
  -- Stops all the active clients in the current buffer if no arguments were passed
  vim.api.nvim_create_user_command("LspStop", function(args)
    local active_clients_in_buffer = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })

    if #args.fargs < 1 then
      for _, client in ipairs(active_clients_in_buffer) do
        vim.notify("[core.lsp] Shutting down " .. client.name .. " ...")
        client.stop(true)
      end
    else
      for _, name in ipairs(args.fargs) do
        for _, client in ipairs(active_clients_in_buffer) do
          if name == client.name then
            vim.notify("[core.lsp] Shutting down " .. client.name .. " ...")
            client.stop(true)
          end
        end
      end
    end
  end, {
    nargs = "*",
    complete = function(args)
      local active_clients_in_buffer = vim
        .iter(vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() }))
        :map(function(s)
          return s.name
        end)
        :totable()
      if #args < 1 then
        return active_clients_in_buffer
      end

      local match = vim
        .iter(active_clients_in_buffer)
        :filter(function(client)
          if string.find(client, "^" .. args) then
            return client
            ---@diagnostic disable-next-line missing-return
          end
        end)
        :totable()
      return match
    end,
  })
  -- }}}

  -- Restart {{{
  vim.api.nvim_create_user_command("LspRestart", function(args)
    local active_clients_in_buffer = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })

    local using_fargs = #args.fargs > 0
    for _, client in ipairs(using_fargs and args.fargs or active_clients_in_buffer) do
      if using_fargs then
        -- NOTE: I don't think I'll ever have more than one instance of the same client in a buffer
        client = vim.lsp.get_clients({ name = client.name })[1]
      end
      if not client.is_stopped() then
        vim.notify("[core.lsp] Restarting " .. client.name .. ", it could take a bit of time ...")
        local server = client.name
        client.stop(true)
        -- We defer the initialization to wait for the client to completely stop
        vim.defer_fn(function()
          ---@diagnostic disable-next-line
          vim.lsp.start(servers[server], { bufnr = vim.api.nvim_get_current_buf() })
        end, 500)
      end
    end
  end, {
    nargs = "*",
    complete = function(args)
      local active_clients_in_buffer = vim
        .iter(vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() }))
        :map(function(s)
          return s.name
        end)
        :totable()
      if #args < 1 then
        return active_clients_in_buffer
      end

      local match = vim
        .iter(active_clients_in_buffer)
        :filter(function(client)
          if string.find(client, "^" .. args) then
            return client
            ---@diagnostic disable-next-line missing-return
          end
        end)
        :totable()
      return match
    end,
  })
  -- }}}

  -- Log {{{
  vim.api.nvim_create_user_command("LspLog", function()
    vim.cmd.vsplit(vim.lsp.log.get_filename())
  end, {})
  -- }}}
end
-- }}}

-- Start LSP servers as soon as possible {{{
-- rust-analyzer is handled by rustaceanvim so we save some time ignoring it
if vim.fn.expand("%:e") ~= "rs" then
  for _, config in pairs(servers) do
    vim.api.nvim_create_autocmd("FileType", {
      pattern = config.filetypes,
      callback = function(ev)
        vim.cmd("LspStart")
        -- local filetype = vim.fn.getbufvar(ev.bufnr, "&filetype")
        -- if filetype == "rust" or filetype == "go" then
        --   vim.lsp.inlay_hint.enable(false)
        -- else
        --   vim.lsp.inlay_hint.enable(true)
        -- end
      end,
    })
  end
end
-- }}}

-- vim: fdm=marker:fdl=0
--- lsp.lua ends here
