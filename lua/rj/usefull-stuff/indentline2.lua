local M = {
  "lukas-reineke/indent-blankline.nvim",
  -- commit = "8299fe7703dfff4b1752aeed271c3b95281a952d",
  event = "BufReadPre",
}

M.opts = {
  indent = { char = "│" },
  whitespace = {
    remove_blankline_trail = true,
  },

  exclude = {
    filetypes = {
      "help",
      "startify",
      "dashboard",
      "lazy",
      "neogitstatus",
      "NvimTree",
      "Trouble",
      "text",
    },
    buftypes = { "terminal", "nofile" },
  },
  scope = { enabled = false },
}

return M
