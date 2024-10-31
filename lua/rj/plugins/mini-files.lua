Later(function()
  require("mini.files").setup()
  vim.keymap.set("n", "<Leader>e", function()
    MiniFiles.open()
  end, { silent = true, desc = "opens mini.files" })
  vim.keymap.set("n", "<Leader><Leader>e", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
  end, { silent = true, desc = "opens mini.files" })

  local map_split = function(buf_id, lhs, direction)
    local rhs = function()
      -- Make new window and set it as target
      local cur_target = MiniFiles.get_explorer_state().target_window
      local new_target = vim.api.nvim_win_call(cur_target, function()
        vim.cmd(direction .. " split")
        return vim.api.nvim_get_current_win()
      end)

      MiniFiles.set_target_window(new_target)
      MiniFiles.go_in()
    end

    -- Adding `desc` will result into `show_help` entries
    local desc = "Split " .. direction
    vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      local buf_id = args.data.buf_id
      -- Tweak keys to your liking
      map_split(buf_id, "<C-s>", "belowright horizontal")
      map_split(buf_id, "<C-v>", "belowright vertical")
    end,
  })
end)
