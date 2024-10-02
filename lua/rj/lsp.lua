if
  not vim
    .iter({ 
      "c", "cpp", "rs", "nix", "lua", "js", "ts", "css", "html"
    })
    :find(vim.fn.expand("%:e"))
then
  return
end

-- Diagnostics {{{
local severity = vim.diagnostic.severity
vim.diagnostic.config({
  underline = {
    severity = {
      min = severity.WARN,
    },
  },
  signs = {
    severity = {
      min = severity.WARN,
    },
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
    },
  },
  virtual_text = false,
  virtual_lines = true, -- lsp_lines.nvim
  update_in_insert = true,
  severity_sort = true,
  float = {
    source = "if_many",
    border = "rounded",
    show_header = false,
  },
})
-- }}}

-- Improve LSPs UI {{{
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "rounded", close_events = { "CursorMoved", "BufHidden", "InsertCharPre" } }
)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = "rounded", close_events = { "CursorMoved", "BufHidden" } }
)

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
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- }}}

-- Servers definition {{{
---@type table<string, vim.lsp.ClientConfig>
local servers = {
  -- Lua {{{
  lua_ls = {
    name = "lua_ls",
    cmd = { "lua-language-server" },
    root_dir = vim.fs.root(0, {
      ".luarc.json",
      ".luarc.jsonc",
      ".luacheckrc",
      ".stylua.toml",
      "stylua.toml",
      "selene.toml",
      "selene.yml",
      ".git",
      ---@diagnostic disable-next-line undefined-field
      vim.uv.cwd(), -- equivalent of `single_file_mode` in lspconfig
    }),
    filetypes = { "lua" },
    capabilities = capabilities,
    on_init = function(client)
      local path = client.workspace_folders and client.workspace_folders[1].name
        or vim.fs.root(0, ".")
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
  -- Zig {{{
  zls = {
    name = "zls",
    cmd = { "zls" },
    root_dir = vim.fs.root(0, { "zls.json", "build.zig", ".git" }),
    filetypes = { "zig", "zir" },
    capabilities = capabilities,
  },
  -- }}}
  -- Nix {{{
  nil_ls = {
    name = "nil_ls",
    cmd = { "nil" },
    -- vim.uv.cwd() is the equivalent of `single_file_mode` in lspconfig
    ---@diagnostic disable-next-line undefined-field
    root_dir = vim.fs.root(0, { "flake.nix", ".git", vim.uv.cwd() }),
    filetypes = { "nix" },
    capabilities = capabilities,
  },
  -- }}}
  -- C/C++ {{{
  -- NOTE: the CORES environment variable is declared in my shell configuration
  clangd = {
    name = "clangd",
    cmd = {
      "clangd",
      "-j=" .. vim.env.CORES,
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
  -- }}}
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
  -- EslintLS {{{
  -- NOTE: install with 'npm i -g vscode-langservers-extracted'
  eslint = {
    name = "eslint",
    cmd = { "vscode-eslint-language-server", "--stdio" },
    root_dir = vim.fs.root(0, { "tsconfig.json", "jsconfig.json", "package.json", ".git" }),
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
      "svelte",
      "astro",
    },
    capabilities = capabilities,
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine",
        },
        showDocumentation = {
          enable = true,
        },
      },
      codeActionOnSave = {
        enable = false,
        mode = "all",
      },
      experimental = {
        useFlatConfig = false,
      },
      format = true,
      nodePath = "",
      onIgnoredFiles = "off",
      problems = {
        shortenToSingleLine = false,
      },
      quiet = false,
      rulesCustomizations = {},
      run = "onType",
      useESLintClass = false,
      validate = "on",
      workingDirectory = {
        mode = "location",
      },
    },
  },
  -- }}}
  -- CSSLS {{{
  -- NOTE: install with 'npm i -g vscode-langservers-extracted'
  cssls = {
    name = "cssls",
    cmd = { "vscode-css-language-server", "--stdio" },
    root_dir = vim.fs.root(0, { "package.json", ".git" }),
    filetypes = { "css", "scss", "less" },
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
      "markdown",
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

    --- Keybindings
    local kbd = vim.keymap.set
    -- Show documentation
    kbd("n", "<leader>lh", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
    -- Open code actions
    kbd("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code actions" })
    -- Rename symbol under cursor
    kbd("n", "<leader>lr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
    -- Show line diagnostics
    kbd("n", "<leader>ldl", function()
      vim.diagnostic.open_float({
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "if_many",
        prefix = " ",
        scope = "cursor",
      })
    end, { buffer = bufnr, desc = "Show line diagnostics" })
    -- Go to diagnostics
    kbd(
      "n",
      "<leader>ldp",
      vim.diagnostic.goto_prev,
      { buffer = bufnr, desc = "Goto next diagnostic" }
    )
    kbd(
      "n",
      "<leader>ldn",
      vim.diagnostic.goto_next,
      { buffer = bufnr, desc = "Goto prev diagnostic" }
    )
    -- Go to definition
    kbd("n", "<leader>lgd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto definition" })
    -- Go to declaration
    kbd("n", "<leader>lgD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Goto declaration" })

    --- Autocommands
    vim.api.nvim_create_augroup("Lsp", { clear = true })
    -- Display line diagnostics on hover
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "Lsp",
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "always",
          prefix = " ",
          scope = "line",
        }
        vim.diagnostic.open_float(opts)
      end,
    })
    -- Fix all eslint offenses on save in JavaScript/TypeScript files
    ---@diagnostic disable-next-line need-check-nil
    if client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = "Lsp",
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end

    --- Commands
    -- Format
    vim.api.nvim_create_user_command(
      "LspFormat",
      vim.lsp.buf.format,
      { desc = "Format current buffer using LSP" }
    )
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
      command = "LspStart",
    })
  end
end
-- }}}

-- vim: fdm=marker:fdl=0
--- lsp.lua ends here
