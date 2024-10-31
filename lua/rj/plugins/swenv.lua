Later(function()
  Add({
    source = "AckslD/swenv.nvim",
    depends = { "stevearc/dressing.nvim", "nvim-lua/plenary.nvim", "ahmedkhalf/project.nvim" },
  })
  require("swenv").setup({
    -- Should return a list of tables with a `name` and a `path` entry each.
    -- Gets the argument `venvs_path` set below.
    -- By default just lists the entries in `venvs_path`.
    get_venvs = function(venvs_path)
      return require("swenv.api").get_venvs(venvs_path)
    end,
    -- Path passed to `get_venvs`.
    venvs_path = vim.fn.expand("~/.virtualenvs"),
    -- Something to do after setting an environment, for example call vim.cmd.LspRestart
    post_set_venv = nil,
  })

  local swenv = require("swenv.api")
  vim.keymap.set("n", "<Leader>lps", swenv.pick_venv, { desc = "Pick venv" })
  vim.keymap.set("n", "<Leader>lpc", function()
    local venv = swenv.get_current_venv()
    if venv then
      vim.notify(venv.name)
    else
      vim.notify("No virtual environment selected", vim.log.levels.WARN)
    end
  end, { desc = "Current venv" })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python" },
    callback = function()
      require("swenv.api").auto_venv()
    end,
  })
end)
