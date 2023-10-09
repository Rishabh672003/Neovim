local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    -- general
    ["*"] = { "codespell", "injected" },
    ["_"] = { "trim_whitespace" },

    -- prettier filetypes
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    svelte = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
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
    return { timeout_ms = 700, lsp_fallback = true }
  end,
})

vim.g.disable_autoformat = true

vim.api.nvim_create_user_command("FormatToggle", function()
  if vim.b.disable_autoformat or vim.g.disable_autoformat then
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  else
    vim.b.disable_autoformat = true
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Toggle autoformat-on-save",
})
