local M = {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  branch = "v2.x",
  event = "BufRead",
  enabled = true,
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>e", "<cmd>Neotree focus toggle<cr>", desc = "NeoTree" },
  },
}

function M.config()
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "neo-tree" },
    callback = function()
      vim.keymap.set("n", "<leader>e", "<cmd>q!<cr>", { buffer = true, silent = true, noremap = true })
    end,
  })
  require("neo-tree").setup({
    popup_border_style = "rounded",
    window = {
      position = "left",
      width = 27,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_current",
    },
    source_selector = {
      winbar = true,
      content_layout = "center",
      sources = {
        { source = "filesystem", display_name = " 󰈔 File" },
        { source = "buffers", display_name = "  Bufs" },
        { source = "git_status", display_name = "  Git" },
      },
    },
  })
end

return M
