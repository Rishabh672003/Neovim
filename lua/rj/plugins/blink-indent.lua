Later(function()
  Add({
    source = "saghen/blink.indent",
  })
  require("blink.indent").setup({
    blocked = {
      -- default: 'terminal', 'quickfix', 'nofile', 'prompt'
      buftypes = { include_defaults = true },
      -- default: 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'dashboard', ''
      filetypes = { include_defaults = true },
    },
    static = {
      enabled = true,
      -- char = "▏",
      priority = 1,
      -- specify multiple highlights here for rainbow-style indent guides
      -- highlights = { 'BlinkIndentRed', 'BlinkIndentOrange', 'BlinkIndentYellow', 'BlinkIndentGreen', 'BlinkIndentViolet', 'BlinkIndentCyan' },
      highlights = { "BlinkIndent" },
    },
    scope = {
      enabled = true,
      char = "▏",
      priority = 1000,
      -- set this to a single highlight, such as 'BlinkIndent' to disable rainbow-style indent guides
      highlights = { 'BlinkIndentScope' },
      -- optionally add: 'BlinkIndentRed', 'BlinkIndentCyan', 'BlinkIndentYellow', 'BlinkIndentGreen'
      -- highlights = { "BlinkIndentOrange", "BlinkIndentViolet", "BlinkIndentBlue" },
      -- enable to show underlines on the line above the current scope
      underline = {
        enabled = false,
        -- optionally add: 'BlinkIndentRedUnderline', 'BlinkIndentCyanUnderline', 'BlinkIndentYellowUnderline', 'BlinkIndentGreenUnderline'
        highlights = { "BlinkIndentOrangeUnderline", "BlinkIndentVioletUnderline", "BlinkIndentBlueUnderline" },
      },
    },
  })
end)
