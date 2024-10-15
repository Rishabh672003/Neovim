Later(function()
  Add({
    source = "ahmedkhalf/project.nvim",
    depends = { "nvim-telescope/telescope.nvim" },
  })
  require("project_nvim").setup({
    active = true,
    on_config_done = nil,
    manual_mode = false,
    detection_methods = { "pattern" },
    ---@usage patterns used to detect root dir, when **"pattern"** is in detection_methods
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "LICENSE", ".venv", "go.mod" },
    show_hidden = false,
    silent_chdir = true,
    ---@usage list of lsp client names to ignore when using **lsp** detection. eg: { "efm", ... }
    ignore_lsp = {},
    ---@type string
    ---@usage path to store the project history for use in telescope
    datapath = vim.fn.stdpath("data"),
  })
end)
