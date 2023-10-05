local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  main = "ibl",
}

function M.config()
  require("ibl").setup({
    indent = {
      -- char = "│"
      char = "▏",
    },
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
    scope = {
      show_start = false,
      show_end = false,
    },
  })
end
return M
