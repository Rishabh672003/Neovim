Later(function()
  Add({
    source = "kevinhwang91/nvim-bqf",
  })

  -- Adapt fzf's delimiter in nvim-bqf
  require("bqf").setup({
    auto_resize_height = true,
    preview = {
      border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"},
      should_preview_cb = function(bufnr, qwinid)
        local ret = true
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local fsize = vim.fn.getfsize(bufname)
        if fsize > 5000 * 1024 then
          ret = false
        end
        return ret
      end,
    },
    filter = {
      fzf = {
        extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
      },
    },
  })
end)
