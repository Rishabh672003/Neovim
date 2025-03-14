Later(function()
  Add({
    source = "is0n/jaq-nvim",
  })

  require("jaq-nvim").setup({
    -- Commands used with 'Jaq'
    cmds = {
      -- Default UI used (see `Usage` for options)
      default = "term",

      -- Uses external commands such as 'g++' and 'cargo'
      external = {
        typescript = "bun run --hot %",
        javascript = "bun run --hot %",
        java = "java %",
        markdown = "glow %",
        python = "python %",
        -- rust = "rustc % -o $fileBase.out && ./$fileBase.out && rm $fileBase.out",
        rust = "cargo run",
        cpp = "g++ % -o $fileBase.out -std=c++23 && ./$fileBase.out && rm $fileBase.out",
        c = "gcc % -o $fileBase.out && ./$fileBase.out",
        go = "go run %",
        sh = "chmod +x % && sh %",
        zsh = "zsh %",
        lua = "lua %",
      },
      -- Uses internal commands such as 'source' and 'luafile'
      internal = {
        -- lua = "luafile %",
        vim = "source %",
      },
    },

    behavior = {
      -- Default type
      default = "terminal",

      -- Start in insert mode
      startinsert = false,

      -- Use `wincmd p` on startup
      wincmd = false,

      -- Auto-save files
      autosave = false,
    },

    -- UI settings
    ui = {
      -- Floating Window / FTerm settings
      float = {
        -- Floating window border (see ':h nvim_open_win')
        border = "none",

        -- Num from `0 - 1` for measurements
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,

        -- Highlight group for floating window/border (see ':h winhl')
        border_hl = "FloatBorder",
        float_hl = "Normal",

        -- Floating Window Transparency (see ':h winblend')
        blend = 0,
      },

      terminal = {
        -- Position of terminal
        position = "bot",

        -- Open the terminal without line numbers
        line_no = false,

        -- Size of terminal
        size = 10,
      },
    },
  })

  vim.keymap.set("n", "<Leader>j", vim.cmd.Jaq, { silent = true, desc = "Run the File" })
end)
