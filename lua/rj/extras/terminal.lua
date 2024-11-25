-- Credit to: [numToStr](https://github.com/numToStr/FTerm.nvim)
local M = {}

local instances = {}

---@alias win_id number Floating Window's ID
---@alias buf_id number Terminal Buffer's ID
---@class M
---@field win WinId
---@field buf BufId
---@field terminal? number Terminal's job id

function M:new(execn)
  if instances[execn] then
    return instances[execn]
  end

  local instance = setmetatable({
    execn = execn,
    win = nil,
    buf = nil,
    terminal = nil,
  }, { __index = self })

  -- Store the new instance in cache
  instances[execn] = instance

  return instance
end

function M:store(win_id, buf_id)
  self.win = win_id
  self.buf = buf_id
  return self
end

function M:create_buf()
  local prev_buf = self.buf
  if prev_buf and vim.api.nvim_buf_is_valid(prev_buf) then
    return prev_buf
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })
  vim.api.nvim_set_option_value("buflisted", false, { buf = buf })
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
  vim.api.nvim_set_option_value("filetype", "terminal", { buf = buf })
  return buf
end

function M:create_win(buf)
  local height = math.ceil(vim.o.lines * 0.75)
  local width = math.ceil(vim.o.columns * 0.9)

  local win = vim.api.nvim_open_win(buf, true, {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = math.ceil((vim.o.lines - height) / 2.5),
    col = math.ceil((vim.o.columns - width) / 2),
    border = "single",
    ---@diagnostic disable-next-line: undefined-global
    title = { { self.execn, visual } },
    title_pos = "left",
  })
  return win
end

function M:prompt()
  if vim.bo.filetype == "terminal" then
    vim.cmd.startinsert()
  end
  return self
end

local function is_valid(win_id)
  return win_id and vim.api.nvim_win_is_valid(win_id)
end

function M:open_term()
  vim.fn.termopen({ self.execn }, {
    on_exit = function(_, _, _)
      if is_valid(self.win) then
        vim.api.nvim_win_close(self.win, true)
      end
      vim.api.nvim_buf_delete(self.buf, { force = true })
      self.win = nil
      self.curr = nil
    end,
  })
  return self:prompt()
end

function M:remember_cursor()
  self.last_win = vim.api.nvim_get_current_win()
  self.prev_win = vim.fn.winnr("#")
  self.last_pos = vim.api.nvim_win_get_cursor(self.last_win)

  return self
end

function M:restore_cursor()
  if self.last_win and self.last_pos ~= nil then
    if self.prev_win > 0 then
      vim.api.nvim_command(("silent! %s wincmd w"):format(self.prev_win))
    end

    if is_valid(self.last_win) then
      vim.api.nvim_set_current_win(self.last_win)
      vim.api.nvim_win_set_cursor(self.last_win, self.last_pos)
    end

    self.last_win = nil
    self.prev_win = nil
    self.last_pos = nil
  end

  return self
end

function M:open()
  if is_valid(self.win) then
    vim.api.nvim_set_current_win(self.win)
  end

  self:remember_cursor()

  local buf = self:create_buf()
  local win = self:create_win(buf)

  if self.buf == buf then
    return self:store(win, buf):prompt()
  end

  return self:store(win, buf):open_term()
end

function M:close()
  if not is_valid(self.win) then
    return self
  end
  if vim.bo.filetype ~= "terminal" then
    self:restore_cursor()
  end
  vim.api.nvim_win_close(self.win, false)
  self.win = nil
end


function M:terminal_lost_focus()
  local track = vim.schedule_wrap(function()
    local ft = vim.bo.filetype
    if ft == "terminal" then
      return
    end
    self:close()
  end)
  vim.uv.new_timer():start(100, 100, track)
end

function M:toggle()
  if is_valid(self.win) then
    self:close()
  else
    self:open()
    self:terminal_lost_focus()
  end
  return self
end

return M
