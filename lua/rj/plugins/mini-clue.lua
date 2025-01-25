Later(function()
  local miniclue = require("mini.clue")
  miniclue.setup({
    window = {
      delay = 500,
    },
    triggers = {
      -- Leader triggers
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },

      -- Built-in completion
      { mode = "i", keys = "<C-x>" },

      -- `g` key
      { mode = "n", keys = "g" },
      { mode = "x", keys = "g" },

      -- Marks
      { mode = "n", keys = "'" },
      { mode = "n", keys = "`" },
      { mode = "x", keys = "'" },
      { mode = "x", keys = "`" },

      -- Registers
      { mode = "n", keys = '"' },
      { mode = "x", keys = '"' },
      { mode = "i", keys = "<C-r>" },
      { mode = "c", keys = "<C-r>" },

      -- Window commands
      { mode = "n", keys = "<C-w>" },

      -- `z` key
      { mode = "n", keys = "z" },
      { mode = "x", keys = "z" },

      { mode = "n", keys = "[" },
      { mode = "n", keys = "]" },
    },

    clues = {
      { mode = "n", keys = "<Leader>g", desc = "+Git" },
      { mode = "n", keys = "<Leader>h", desc = "+Harpoon" },
      { mode = "n", keys = "<Leader>b", desc = "+Buffers" },
      { mode = "n", keys = "<Leader>l", desc = "+LSP" },
      { mode = "n", keys = "<Leader>t", desc = "+Terminal" },
      { mode = "n", keys = "<Leader>n", desc = "+Notify" },
      { mode = "n", keys = "<Leader>m", desc = "+Sessions" },
      { mode = "n", keys = "<Leader>s", desc = "+Search" },
      { mode = "n", keys = "<Leader>y", desc = "+Yank" },
      { mode = "n", keys = "<Leader>d", desc = "+Diagnostic" },

      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
    },
  })
end)
