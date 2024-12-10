---@diagnostic disable: missing-fields
Later(function()
  Add({
    source = "saghen/blink.cmp",
    depends = {
      "rafamadriz/friendly-snippets",
    },
    checkout = "v0.7.3", -- check releases for latest tag
  })
  require("blink.cmp").setup({
    keymap = { preset = "default" },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "normal",
    },

    completion = {
      documentation = {
        auto_show = true,
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      signature = {
        enabled = false,
      },
    },
    sources = {
      completion = {
        enabled_providers = { "lsp", "path", "snippets", "buffer" },
      },
    },
  })
end)
