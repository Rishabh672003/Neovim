Later(function()
  Add({
    source = "lewis6991/gitsigns.nvim",
  })
  require("gitsigns").setup({
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "󰐊" },
      topdelete = { text = "󰐊" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  })
  vim.keymap.set( "n", "<Leader>gp", "<Cmd>Gitsigns preview_hunk_inline<CR>", { silent = true, desc = "Preview Hunk Inline" })
  vim.keymap.set("n", "<Leader>gP", "<Cmd>Gitsigns preview_hunk<CR>", { silent = true, desc = "Preview Hunk Float" })
  vim.keymap.set("n", "<Leader>gb", "<Cmd>Gitsigns blame_line<CR>", { silent = true, desc = "Blame Line" })
  vim.keymap.set("n", "<Leader>gn", "<Cmd>Gitsigns next_hunk<CR>", { silent = true, desc = "Next Hunk" })
  vim.keymap.set("n", "<Leader>gh", "<Cmd>Gitsigns prev_hunk<CR>", { silent = true, desc = "Prev Hunk" })
end)
