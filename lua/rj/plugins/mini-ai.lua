Later(function()
  Add({
    source = "nvim-treesitter/nvim-treesitter-textobjects",
    depends = { "nvim-treesitter/nvim-treesitter" },
  })

  require("nvim-treesitter.configs").setup({})
  local gen_spec = require("mini.ai").gen_spec
  require("mini.ai").setup({
    custom_textobjects = {
      -- Tweak argument to be recognized only inside `()` between `;`
      a = gen_spec.argument({ brackets = { "%b()" }, separator = ";" }),

      -- Tweak function call to not detect dot in function name
      F = gen_spec.function_call({ name_pattern = "[%w_]" }),

      -- Function definition (needs treesitter queries with these captures)
      f = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
      o = gen_spec.treesitter({
        a = { "@conditional.outer", "@loop.outer" },
        i = { "@conditional.inner", "@loop.inner" },
      }),
      c = gen_spec.treesitter({
        i = { "@class.inner" },
        a = { "@class.outer" },
      }),

      -- Make `|` select both edges in non-balanced way
      ["|"] = gen_spec.pair("|", "|", { type = "non-balanced" }),
    },
  })
end)
