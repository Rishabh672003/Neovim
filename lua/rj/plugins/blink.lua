-- use a release tag to download pre-built binaries
Later(function()
  Add({
    source = "saghen/blink.cmp",
    depends = {
      "rafamadriz/friendly-snippets",
    },
    checkout = "v0.5.0", -- check releases for latest tag
  })
  require("blink.cmp").setup({
    keymap = "default",
    -- experimental auto-brackets support
    accept = { auto_brackets = { enabled = true } },
    -- experimental signature help support
    trigger = { signature_help = { enabled = true } },

    windows = {
      documentation = {
        auto_show = true,
      },
    },
  })
end)
