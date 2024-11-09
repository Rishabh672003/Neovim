Later(function()
  Add({
    source = "okuuva/auto-save.nvim",
  })
  require("auto-save").setup({
    enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
    trigger_events = { -- See :h events
      immediate_save = { "BufLeave", "FocusLost", "InsertLeave" }, -- vim events that trigger an immediate save
      defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
      cancel_deffered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
    },
    condition = function(buf)
      local fn = vim.fn

      if fn.getbufvar(buf, "&modifiable") == 1 then
        return true -- met condition(s), can save
      end
      return false -- can't save
    end,
    write_all_buffers = false, -- write all buffers when the current one meets `condition`
    debounce_delay = 1000, -- delay after which a pending save is executed
    -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
    debug = false,
  })
end)
