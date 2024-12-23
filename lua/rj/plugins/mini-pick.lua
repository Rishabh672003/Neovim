---@diagnostic disable: undefined-global
Now(function()
  require("mini.extra").setup()
  require("mini.pick").setup({
    -- General options
    window = {
      config = {
        width = 70,
        height = 20,
      },
    },
    mappings = {
      choose = "<C-y>",
      -- choose = "<CR>",
    },
    options = {
      content_from_bottom = false,
      use_cache = false,
    },
  })
  require("rj.extras.mini-pickproject")

  vim.ui.select = MiniPick.ui_select
  local keymap = vim.keymap.set
  keymap("n", "<Leader>f", function()
    MiniPick.builtin.files({ tool = "rg", cwd = nil }, { source = { cwd = vim.uv.cwd() } })
  end, { desc = "Find Files" })

  keymap("n", "<Leader>F", function()
    MiniPick.builtin.grep_live({ tool = "rg" }, { source = { cwd = vim.uv.cwd() } })
  end, { desc = "Live Grep" })

  keymap("n", "<Leader>bb", function()
    local wipeout_cur = function()
      vim.api.nvim_buf_delete(MiniPick.get_picker_matches().current.bufnr, {})
    end
    local buffer_mappings = { wipeout = { char = "<C-d>", func = wipeout_cur } }
    MiniPick.builtin.buffers({}, { mappings = buffer_mappings })
  end, { desc = "Buffers" })

  keymap("n", "<Leader>r", function()
    MiniExtra.pickers.oldfiles()
  end, { desc = "Oldfiles" })

  keymap("n", "<Leader>p", "<Cmd>Projects<CR>", { desc = "Projects" })

  keymap("n", "<Leader>sk", function()
    MiniExtra.pickers.keymaps({}, {
      window = {
        config = {
          width = 100,
          height = 20,
        },
      },
    })
  end, { desc = "Search Keymaps" })
  keymap("n", "<Leader>sh", function()
    MiniPick.builtin.help()
  end, { desc = "Search Help" })
end)