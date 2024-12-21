Later(function()
  Add({
    source = "nvim-treesitter/nvim-treesitter-textobjects",
    depends = { "nvim-treesitter/nvim-treesitter" },
  })

  local gen_spec = require("mini.ai").gen_spec
  local gen_ai_spec = require("mini.extra").gen_ai_spec
  require("mini.ai").setup({
    custom_textobjects = {
      -- Make `|` select both edges in non-balanced way
      ["|"] = gen_spec.pair("|", "|", { type = "non-balanced" }),
      A = require('mini.ai').gen_spec.argument({ brackets = { '%b()' } }),

      -- Tweak function call to not detect dot in function name
      f = gen_spec.function_call({ name_pattern = "[%w_]" }),

      -- Function definition (needs treesitter queries with these captures)
      F = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
      o = gen_spec.treesitter({
        a = { "@conditional.outer", "@loop.outer" },
        i = { "@conditional.inner", "@loop.inner" },
      }),
      c = gen_spec.treesitter({
        i = { "@class.inner" },
        a = { "@class.outer" },
      }),

      a = gen_ai_spec.buffer(),
      D = gen_ai_spec.diagnostic(),
      I = gen_ai_spec.indent(),
      L = gen_ai_spec.line(),
      N = gen_ai_spec.number(),
    },
  })
end)

