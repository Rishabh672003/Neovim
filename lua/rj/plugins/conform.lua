Later(function()
  Add({
    source = "stevearc/conform.nvim",
  })
  local conform = require("conform")

  conform.setup({
    formatters_by_ft = {
      -- general
      ["*"] = { --[[ "codespell", ]]
        "injected",
      },
      ["_"] = { "trim_whitespace" },

      -- biome filetypes
      javascript = { "biome" },
      typescript = { "biome" },
      javascriptreact = { "biome" },
      json = { "biome" },
      jsonc = { "biome" },

      -- prettier filetypes
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      vue = { "prettier" },

      lua = { "stylua" },
      python = {
        "pyfix_imports",
        "ruff_fix",
        "ruff_organize_imports",
        "ruff_format",
      },
      java = { "astyle" },
      rust = { "rustfmt" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      cpp = { "clang_format" },
      go = { "gofmt", "goimports" },
      cmake = { "cmake_format" },
    },

    format_on_save = function(bufnr)
      local function myCallback(err)
        if err then
          vim.notify("Error during formatting: ", err)
        else
          vim.notify("Formatting completed successfully.")
        end
      end
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("/node_modules/") then
        return
      end
      return { timeout_ms = 1000, lsp_fallback = true }, myCallback()
    end,

    formatters = {
      pyfix_imports = {
        command = "pyfix-imports",
        args = { "$FILENAME" },
        stdin = true,
        cwd = require("conform.util").root_file({ "requirements.txt", "pyproject.toml", ".git" }),
      },
    },
  })

  vim.g.disable_autoformat = true

  vim.api.nvim_create_user_command("Format", function()
    local function myCallback(err)
      if err then
        vim.notify("Error during formatting: ", string(err))
      else
        vim.notify("Formatting completed successfully.")
      end
    end
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    }, myCallback())
  end, {
    desc = "format",
  })

  vim.api.nvim_create_user_command("FormatToggle", function()
    if vim.b.disable_autoformat or vim.g.disable_autoformat then
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
      vim.notify("AutoFormat Enabled")
    else
      vim.b.disable_autoformat = true
      vim.g.disable_autoformat = true
      vim.notify("AutoFormat Disabled")
    end
  end, {
    desc = "Toggle autoformat-on-save",
  })

  vim.keymap.set("n", "<Leader>lf", "<Cmd>silent Format<CR>", { desc = "Format the current file", silent = true })
end)
