Later(function()
  Add({
    source = "natecraddock/workspaces.nvim",
    depends = {"nvim-telescope/telescope.nvim"},
  })

  require("workspaces").setup({
    path = vim.fn.stdpath("data") .. "/workspaces",

    -- controls how the directory is changed. valid options are "global", "local", and "tab"
    --   "global" changes directory for the neovim process. same as the :cd command
    --   "local" changes directory for the current window. same as the :lcd command
    --   "tab" changes directory for the current tab. same as the :tcd command
    --
    -- if set, overrides the value of global_cd
    cd_type = "global",

    -- sort the list of workspaces by name after loading from the workspaces path.
    sort = true,

    -- sort by recent use rather than by name. requires sort to be true
    mru_sort = true,

    -- option to automatically activate workspace when opening neovim in a workspace directory
    auto_open = false,

    -- option to automatically activate workspace when changing directory not via this plugin
    -- set to "autochdir" to enable auto_dir when using :e and vim.opt.autochdir
    -- valid options are false, true, and "autochdir"
    auto_dir = false,

    -- enable info-level notifications after adding or removing a workspace
    notify_info = true,

    -- lists of hooks to run after specific actions
    -- hooks can be a lua function or a vim command (string)
    -- lua hooks take a name, a path, and an optional state table
    -- if only one hook is needed, the list may be omitted
    hooks = {
      open = "Telescope find_files",
    }
  })
end)
