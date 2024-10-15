Later(function()
  require("mini.git").setup({
    -- General CLI execution
    job = {
      -- Path to Git executable
      git_executable = "git",

      -- Timeout (in ms) for each job before force quit
      timeout = 30000,
    },

    -- Options for `:Git` command
    command = {
      -- Default split direction
      split = "auto",
    },
  })
end)
