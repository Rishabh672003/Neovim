local lint = require("lint")

lint.linters_by_ft = {
  sh = { "shellcheck" },
  markdown = { "proselint" },
  lua = { "luacheck" },
  python = { "ruff" },
}

local cppcheck = require("lint").linters.cppcheck
cppcheck.args = {
  "--enable=warning,style,performance,information",
  "--language=c++",
  "--inline-suppr",
  "--suppress=missingIncludeSystem",
  "--suppress=missingInclude",
  "--cppcheck-build-dir=/home/rishabh/projects/.builds/",
  "--template={file}:{line}:{column}: [{id}] {severity}: {message}",
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

vim.keymap.set("n", "<leader>lt", function()
  lint.try_lint()
end, { desc = "Trigger linting" })
