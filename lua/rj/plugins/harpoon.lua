Later(function()
  Add({
    source = "ThePrimeagen/harpoon",
    checkout = "harpoon2",
    depends = { "nvim-lua/plenary.nvim", },
  })
  local harpoon = require("harpoon")
  -- Keybinds
  local keymap = vim.keymap.set
  --stylua: ignore start
  keymap("n", "<leader>ha", function() harpoon:list():add()                        end, { noremap = true, silent = true, desc = "Add file" })
  keymap("n", "<leader>hh", function() harpoon:list():select(1)                    end, { noremap = true, silent = true, desc = "Goto 1" })
  keymap("n", "<leader>hj", function() harpoon:list():select(2)                    end, { noremap = true, silent = true, desc = "Goto 2" })
  keymap("n", "<leader>hk", function() harpoon:list():select(3)                    end, { noremap = true, silent = true, desc = "Goto 3" })
  keymap("n", "<leader>hl", function() harpoon:list():select(4)                    end, { noremap = true, silent = true, desc = "Goto 4" })
  keymap("n", "<leader>hn", function() harpoon:list():next()                       end, { noremap = true, silent = true, desc = "Goto next" })
  keymap("n", "<leader>hp", function() harpoon:list():prev()                       end, { noremap = true, silent = true, desc = "Goto prev" })
  keymap("n", "<leader>ht", function() harpoon.ui:toggle_quick_menu(harpoon:list())end, { noremap = true, silent = true, desc = "Toggle menu" })
  --stylua: ignore end

end)
