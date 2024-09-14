return {
  "Axlefublr/wife.nvim",
  lazy = true,
  commit = "860bdb8f8c39683f39e951bbf144f7ab0037a638",
  -- This is where you should change the plugin's options,
  -- if you want to change any.
  -- If you don't, you don't even have to have `opts`.
  -- (Meaning, the setup() call is not required in that case).
  ---@module "wife"
  opts = {},
  keys = {
    {
      "<leader>is",
      function()
        require("wife").interactive_shell()
      end,
      desc = "Launch command",
    },
  },
}
