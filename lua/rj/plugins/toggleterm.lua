Later(function()
  Add({
    source = "akinsho/toggleterm.nvim",
  })

  require("toggleterm").setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  })

  function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, "t", "<C-q>", [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
  end

  vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    on_open = function(_)
      vim.cmd("startinsert!")
    end,
    on_close = function(_) end,
    count = 99,
  })

  function _LAZYGIT_TOGGLE()
    lazygit:toggle()
  end
  -- Function Mappings
  --stylua: ignore start
  local keymap = vim.keymap.set
  keymap("n", "<A-t>", "<cmd>ToggleTerm<cr>", { desc = "Toggle" })
  keymap("n", "<leader>gg", function()_LAZYGIT_TOGGLE()end, {desc = "lazygit"})
  keymap("n", "<leader>tT", "<cmd>terminal<cr>", { desc = "Neoterminal" })
  keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float" })
  keymap("n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "Horizontal" })
  keymap("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle" })
  keymap("n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "Vertical" })
  keymap("t", "<A-t>", "<cmd>ToggleTerm<cr>", { desc = "Toggle" })
  --stylua: ignore end
end)
