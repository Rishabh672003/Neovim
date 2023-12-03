local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    -- general
    ["*"] = { "codespell", "injected" },
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
    python = { "black" },
    java = { "astyle" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    cpp = { "clang_format" },
    go = { "gofmt" },
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
    -- ...additional logic...
    return { timeout_ms = 1000, lsp_fallback = true }, myCallback()
  end,
})

vim.g.disable_autoformat = true

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
