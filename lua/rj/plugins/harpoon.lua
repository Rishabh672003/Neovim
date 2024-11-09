Later(function()
  Add({
    source = "ThePrimeagen/harpoon",
    depends = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  })
  -- Keybinds
  local keymap = vim.keymap.set
  --stylua: ignore start
  keymap("n", "<leader>ha", function() require("harpoon.mark").add_file()       end, { noremap = true, silent = true, desc = "Add file" })
  keymap("n", "<leader>hh", function() require("harpoon.ui").nav_file(1)        end, { noremap = true, silent = true, desc = "Goto 1" })
  keymap("n", "<leader>hj", function() require("harpoon.ui").nav_file(2)        end, { noremap = true, silent = true, desc = "Goto 2" })
  keymap("n", "<leader>hk", function() require("harpoon.ui").nav_file(3)        end, { noremap = true, silent = true, desc = "Goto 3" })
  keymap("n", "<leader>hl", function() require("harpoon.ui").nav_file(4)        end, { noremap = true, silent = true, desc = "Goto 4" })
  keymap("n", "<leader>hn", function() require("harpoon.ui").nav_next()         end, { noremap = true, silent = true, desc = "Goto next" })
  keymap("n", "<leader>hp", function() require("harpoon.ui").nav_prev()         end, { noremap = true, silent = true, desc = "Goto prev" })
  keymap("n", "<leader>ht", function() require("harpoon.ui").toggle_quick_menu()end, { noremap = true, silent = true, desc = "Toggle menu" })
  --stylua: ignore end

  require("telescope").load_extension("harpoon")
  keymap("n", "<leader>hg", function()
    require("telescope").extensions.harpoon.marks(require("telescope.themes").get_dropdown({ previewer = true }))
  end, { noremap = true, silent = true, desc = "Toggle menu" })
end)
