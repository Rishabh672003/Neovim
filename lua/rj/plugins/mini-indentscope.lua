Now(function()
  require("mini.indentscope").setup({
    -- Draw options
    draw = {
      -- Delay (in ms) between event and start of drawing scope indicator
      delay = 20,

      -- Symbol priority. Increase to display on top of more symbols.
      priority = 2,
    },

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Textobjects
      object_scope = "ii",
      object_scope_with_border = "ai",

      -- Motions (jump to respective border line; if not present - body line)
      goto_top = "[i",
      goto_bottom = "]i",
    },

    -- Options which control scope computation
    options = {
      -- Type of scope's border: which line(s) with smaller indent to
      -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
      border = "both",

      -- Whether to use cursor column when computing reference indent.
      -- Useful to see incremental scopes with horizontal cursor movements.
      indent_at_cursor = true,

      -- Whether to first check input line to be a border of adjacent scope.
      -- Use it if you want to place cursor on function header to get scope of
      -- its body.
      try_as_border = true,
    },

    -- Which character to use for drawing scope indicator
    --[[ "|" ]]
    symbol = "▏",
    -- symbol = "│",
  })
  vim.api.nvim_create_autocmd("FileType", {
    desc = "Disable indentscope for certain filetypes",
    pattern = {
      "man",
      "terminal",
      "help",
      "Trouble",
      "trouble",
      "lazy",
      "mason",
      "notify",
      "better_term",
      "toggleterm",
      "lazyterm",
      "dashboard",
      "leetcode.nvim",
    },
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
end)
