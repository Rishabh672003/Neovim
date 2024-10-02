return {
  "coffebar/neovim-project",
  enabled = false,
  opts = {
    projects = { -- define project roots
      "~/projects/*",
      "~/.config/*",
    },
    picker = {
      type = "fzf-lua", -- or "fzf-lua"
    }
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    -- optional picker
    { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
    -- optional picker
    { "ibhagwan/fzf-lua" },
    { "Shatur/neovim-session-manager" },
  },
  lazy = false,
  priority = 100,
}
