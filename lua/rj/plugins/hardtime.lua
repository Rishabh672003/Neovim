-- lazy.nvim
return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  enabled = false,
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {},
}
