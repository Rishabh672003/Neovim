local M = {}

function M.float_lost_focus(win)
  local track = vim.schedule_wrap(function()
    local win_id = vim.api.nvim_get_current_win()
    if win and win == win_id then
      return
    end
    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end)
  vim.uv.new_timer():start(50, 50, track)
end

function M.get_win()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, false, {
    relative = "cursor",
    width = math.ceil(vim.o.columns / 1.5),
    height = 10,
    row = (vim.fn.line(".") - vim.fn.line("w0") + 1) > 13 and -12 or 1,
    col = 0,
    border = "single",
    title = "Definition",
    title_pos = "center",
    noautocmd = true,
  })
  return win
end

function M.get_doc()
  vim.lsp.buf.definition({
    on_list = function(options)
      if #options.items > 0 then
        local win = M.get_win()
        vim.api.nvim_win_set_option(win, "winblend", 15) -- Adjust transparency level
        vim.api.nvim_set_current_win(win)

        local def = options.items[1]
        vim.cmd("e " .. def.filename)
        vim.api.nvim_win_set_cursor(0, { def.lnum, def.col - 1 })
        M.float_lost_focus(win)
      else
        print("No definition found")
      end
    end,
  })
end

return M
