return {
  "max397574/care.nvim",
  enabled = false,
  lazy = true,
  event = { "InsertEnter" },
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    "max397574/care-cmp",
    "max397574/cmp-greek",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-path",
  },
  config = function()
    local labels = { "q", "w", "r", "t", "z", "i", "o" }

    require("care").setup({
      ui = {
        menu = {
          max_height = 30,

          format_entry = function(entry, data)
            local labels = { "q", "w", "r", "t", "z", "i", "o" }
            local completion_item = entry.completion_item
            local type_icons = require("care.config").options.ui.type_icons or {}
            local color = require("care.presets.utils").GetColor(entry)
            local entry_kind = type(completion_item.kind) == "string" and completion_item.kind
              or require("care.utils.lsp").get_kind_name(completion_item.kind)
            return {
              {
                {
                  " " .. require("care.presets.utils").LabelEntries(labels)(entry, data) .. " ",
                  "Comment",
                },
              },
              {
                { completion_item.label .. " ", data.deprecated and "Comment" or "@care.entry" },
                color and {
                  " ",
                  require("care.presets.utils").GetHighlightForHex(color) or "@care.entry",
                } or nil,
              },
              {
                {
                  " " .. (type_icons[entry_kind] or type_icons.Text) .. " ",
                  ("@care.type.blended.%s"):format(entry_kind),
                },
              },
              {
                {
                  " (" .. data.source_name .. ") ",
                  ("@care.type.fg.%s"):format(entry_kind),
                },
              },
            }
          end,
          alignments = { "left", "left", "left", "center" },
          scrollbar = {
            -- character = "║",
            character = "┃",
          },
        },
        ghost_text = { enabled = false },
      },
      sources = {
        lsp = {
          filter = function(entry)
            return entry.completion_item.kind ~= 1
          end,
          -- priority = 5,
          -- enabled = false,
        },
        cmp_buffer = {
          -- priority = 5,
          enabled = false,
        },
      },
      -- completion_events = {},
      preselect = false,
      selection_behavior = "insert",
      sorting_direction = "away-from-cursor",
      snippet_expansion = function(body)
        require("luasnip").lsp_expand(body)
      end,

      debug = false,
    })

    -- Keymappings
    for i, label in ipairs(labels) do
      vim.keymap.set("i", "<c-" .. label .. ">", function()
        require("care").api.select_visible(i)
        require("care").api.confirm()
      end)
    end

    vim.keymap.set("i", "<c-n>", function()
      require("luasnip").jump(1)
    end)
    vim.keymap.set("i", "<c-p>", function()
      require("luasnip").jump(-1)
    end)
    vim.keymap.set("i", "<c-space>", function()
      require("care").api.complete()
    end)

    vim.keymap.set("i", "<c-x><c-f>", function()
      require("care").api.complete(function(name)
        return name == "cmp_path"
      end)
    end)

    vim.keymap.set({ "i", "s" }, "<c-f>", function()
      if require("care").api.doc_is_open() then
        require("care").api.scroll_docs(4)
      elseif require("luasnip").choice_active() then
        require("luasnip").change_choice(1)
      else
        vim.api.nvim_feedkeys(vim.keycode("<c-f>"), "n", false)
      end
    end)

    vim.keymap.set({ "i", "s" }, "<c-d>", function()
      if require("care").api.doc_is_open() then
        require("care").api.scroll_docs(-4)
      elseif require("luasnip").choice_active() then
        require("luasnip").change_choice(-1)
      else
        vim.api.nvim_feedkeys(vim.keycode("<c-f>"), "n", false)
      end
    end)

    vim.keymap.set("i", "<cr>", "<Plug>(CareConfirm)")
    vim.keymap.set("i", "<c-e>", "<Plug>(CareClose)")
    vim.keymap.set("i", "<c-j>", "<Plug>(CareSelectNext)")
    vim.keymap.set("i", "<c-k>", "<Plug>(CareSelectPrev)")
  end,
}
