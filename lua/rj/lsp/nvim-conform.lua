local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    -- general
    ["*"] = { "codespell" },
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
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 700,
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set({ "n", "v" }, "<leader>lf", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 700,
  })
end, { desc = "Format file or range (in visual mode)" })
