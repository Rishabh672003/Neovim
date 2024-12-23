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
    border = "single",
    source = "always",
    header = "",
    prefix = "",
    suffix = "",
  },
}
vim.diagnostic.config(config)
-- }}}

-- Improve LSPs UI {{{
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

vim.lsp.config("*", {
  capabilities = capabilities,
})
-- }}}

-- Disable the default keybinds {{{
vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
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
    local lsp = vim.lsp
    local opts = { silent = true, buffer = true }
    local function opt(desc, others)
      return vim.tbl_extend("force", opts, { desc = desc }, others or {})
    end

    keymap("n", "<Leader>ls", function() lsp.buf.document_symbol() end, opt("Doument Symbols"))
    keymap("n", "<Leader>lS", function() lsp.buf.workspace_symbol() end, opt("Workspace Symbols"))
    keymap("n", "gd", function() lsp.buf.definition() end, opt("Go to definition"))
    keymap("n", "gD", function() require("rj.extras.definition").get_def() end, opt("Get the definition in a float"))
    keymap("n", "gi", function() lsp.buf.implementation({ border = "single" })  end, opt("Go to implementation"))
    keymap("n", "gr", function() lsp.buf.references() end, opt("Show References"))
    keymap("n", "<Leader>lr", function() lsp.buf.rename() end, opt("Rename"))
    keymap("n", "<C-k>", function() lsp.buf.signature_help() end, opts)
    keymap("n", "K", function() lsp.buf.hover({ border = "single" }) end,opts)
    keymap("n", "<Leader>lh", function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({})) end, opt("Toggle Inlayhints"))
    keymap("n", "gl", function() vim.diagnostic.open_float() end, opt("Open diagnostic in float"))
    keymap("n", "<Leader>la", function() lsp.buf.code_action() end, opt("Code Action"))
    keymap("n", "<Leader>lj", function() vim.diagnostic.jump({ count = 1, float = true }) end, opt("Next Diagnostic"))
    keymap("n", "<Leader>lk", function() vim.diagnostic.jump({ count =-1, float = true }) end, opt("Prev Diagnostic"))
    keymap("n", "<Leader>ll", function() lsp.codelens.run() end, opt("Run CodeLens"))
    keymap("n", "<Leader>lq", function() vim.diagnostic.setloclist() end, opt("Set LocList"))
    keymap("n", "<Leader>lf", "<Cmd>Format<CR>", opt("Format"))
    keymap("n", "<Leader>lF", "<Cmd>FormatToggle<CR>", opt("Toggle AutoFormat"))
    keymap("n", "<Leader>li", "<Cmd>checkhealth vim.lsp<CR>", opt("LspInfo"))
    keymap("n", "<Leader>lI", "<Cmd>Mason<CR>", opt("Mason"))
    -- stylua: ignore end
  end,
})
-- }}}

-- Servers {{{

-- Lua {{{
vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".git", vim.uv.cwd() },
  -- on_init {{{
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
        globals = { "_G", "vim", "MiniFiles", "MiniDeps", "MiniSessions" },
      },
      workspace = {
        preloadFileSize = 500,
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
        -- library = vim.api.nvim_get_runtime_file("*", true)
      },
    })
  end,
  -- }}}

  settings = {
    Lua = {
      telemetry = {
        enable = false,
      },
    },
  },
}
vim.lsp.enable("lua_ls")
-- }}}

-- Python {{{
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    require("rj.extras.venv").set_venv()
    -- start lsp {{{
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
      capabilities = capabilities,
      root_dir = root_dir,
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
    -- }}}
  end,
})
-- }}}

-- Go {{{
vim.lsp.config.gopls = {
  cmd = { "gopls" },
  filetypes = { "go", "gotempl", "gowork", "gomod" },
  root_markers = { ".git", "go.mod", "go.work", vim.uv.cwd() },
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
}
vim.lsp.enable("gopls")
-- }}}

-- C/C++ {{{
vim.lsp.config.clangd = {
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
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = {
    "CMakeLists.txt",
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git",
    vim.uv.cwd(),
  },
}
vim.lsp.enable("clangd")
-- }}}

-- Rust {{{
Now(function()
  Add({
    source = "mrcjkb/rustaceanvim",
  })
end)
-- }}}

-- Bash {{{
vim.lsp.config.bashls = {
  cmd = { "bash-language-server", "start" },
  filetypes = { "bash", "sh", "zsh" },
  root_markers = { ".git", vim.uv.cwd() },
  settings = {
    bashIde = {
      globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
    },
  },
}
vim.lsp.enable("bashls")
-- }}}

-- Web-dev {{{
-- TSServer {{{
vim.lsp.config.ts_ls = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },

  init_options = {
    hostInfo = "neovim",
  },
}
-- }}}

-- CSSls {{{
vim.lsp.config.cssls = {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss" },
  root_markers = { "package.json", ".git" },
  init_options = {
    provideFormatter = true,
  },
}
-- }}}

-- TailwindCss {{{
vim.lsp.config.tailwindcssls = {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "ejs",
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = {
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
  },
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
}
-- }}}

-- HTML {{{
vim.lsp.config.htmlls = {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  root_markers = { "package.json", ".git" },

  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true,
  },
}
-- }}}

vim.lsp.enable({ "ts_ls", "cssls", "tailwindcssls", "htmlls" })

-- }}}

-- }}}

-- Start, Stop, Restart, Log commands {{{
vim.api.nvim_create_user_command("LspStart", function()
  vim.cmd("e")
end, {})

vim.api.nvim_create_user_command("LspStop", function(opts)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if opts.args == "" or client.name == opts.args then
      client:stop()
      vim.notify(client.name .. " stopped")
    end
  end
end, {
  desc = "Stop all LSP clients or a specific client attached to the current buffer.",
  nargs = "?",
})

vim.api.nvim_create_user_command("LspRestart", function()
  local detach_clients = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    client:stop()
    if vim.tbl_count(client.attached_buffers) > 0 then
      detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
    end
  end
  local timer = vim.uv.new_timer()
  timer:start(
    100,
    50,
    vim.schedule_wrap(function()
      for name, client in pairs(detach_clients) do
        -- NOTE: this will be deprecated in 0.11
        -- so will need to change to vim.lsp.start() then
        local client_id = vim.lsp.start(client[1].config, { attach = false })
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
  vim.cmd("silent checkhealth vim.lsp")
end, {
  desc = "Get all the information about all LSP attached",
})
-- }}}

-- vim: fdm=marker:fdl=0
--- lsp.lua ends here
