local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  svelte = { "eslint_d" },
  -- zsh = { "shellcheck" },
  sh = { "shellcheck" },
  markdown = { "proselint" },
  lua = { "luacheck" },
}

local luachecks = require("lint").linters.luacheck
luachecks.args = {
  "--formatter",
  "plain",
  "--codes",
  "--ranges",
  "--globals",
  "vim",
  "-",
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

vim.keymap.set("n", "<leader>l", function()
  lint.try_lint()
end, { desc = "Trigger linting for current file" })
