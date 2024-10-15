Later(function()
  Add({
    source = "utilyre/barbecue.nvim",
    depends = { "SmiteshP/nvim-navic" },
  })

  local barbecue = require("barbecue")

  vim.api.nvim_set_hl(0, "NavicSeparator", { link = "Normal" })

  barbecue.setup({
    ---whether to create winbar updater autocmd
    ---@type boolean
    create_autocmd = true,
    theme = "catppuccin",
    ---buftypes to enable winbar in
    ---@type table
    include_buftypes = { "" },
    ---returns a string to be shown at the end of winbar
    -- param bufnr number
    ---@return string
    -- custom_section = function(bufnr)
    --   return ""
    -- end,

    ---:help filename-modifiers
    modifiers = {
      ---@type string
      -- dirname = ":s?.*??",
      dirname = ":~:.",
      ---@type string
      basename = "",
    },
    symbols = {
      ---string to be shown at the start of winbar
      ---@type string
      prefix = " ",
      ---entry separator
      ---@type string
      separator = ">",
      ---string to be shown when buffer is modified
      ---@type string
      modified = "",
      ---string to be shown when context is available but empty
      ---@type string
      default_context = "",
    },
    ---icons for different context entry kinds
    kinds = {
      Array = "󰅨",
      Boolean = "󰔡",
      Class = "󰌗",
      Color = "󰏘",
      Constant = "󰇽",
      Constructor = "󰆧",
      Enum = "",
      EnumMember = "",
      Event = "",
      Field = "",
      File = "󰈙",
      Folder = "󰉋",
      Function = "󰆧",
      Interface = "",
      Key = "󰉿",
      Keyword = "󰉨",
      Method = "󰆧",
      Module = "󰅩",
      Namespace = "󰅩",
      Null = "󰟢",
      Number = "",
      Object = "󰅩",
      Operator = "󰆕",
      Package = "",
      Property = "",
      Reference = "",
      Snippet = "󰃐",
      String = "󰉿",
      Struct = "",
      Text = "󰉿",
      TypeParameter = "󰊄",
      Unit = "",
      Value = "󰎠",
      Variable = "",
    },
  })
end)
