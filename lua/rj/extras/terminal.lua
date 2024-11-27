-- Credit to: [numToStr](https://github.com/numToStr/FTerm.nvim)
-- modified by me and added more functionality and added more functionality

---@alias WinId number # Floating Window's ID
---@alias BufId number # Terminal Buffer's ID

---@class CommandMode
---@field command? string | function Command to execute in terminal
---@field executed boolean Whether the command has been executed
---@field run_once? boolean If true, the command will only run once

---@class M
---@field win? WinId Floating window ID
---@field buf? BufId Buffer ID associated with the terminal
---@field terminal? number Terminal's job ID
---@field execn? string Shell or command to execute in the terminal
---@field name? string Name of the terminal
---@field command_mode CommandMode State of the terminal's command mode
---@field last_tab? number Last tabpage ID
---@field last_win? number Last window ID
---@field prev_win? number Previous window number
---@field last_pos? number[] Cursor position in the last window
local M = {}

local instances = setmetatable({}, { __mode = "v" })

---@class TerminalOpts
---@field execn? string The executable to use for the terminal (defaults to vim.o.shell)
---@field name? string Optional name for the terminal instance

---Creates a new terminal instance
---@param opts? TerminalOpts
---@return M
function M:new(opts)
  opts = opts or {}
  local execn = opts.execn or vim.o.shell
  local name = opts.name

  if instances[name or execn] then
    return instances[name or execn]
  end

  ---@type M
  local instance = setmetatable({
    name = name,
    execn = execn,
    command_mode = {
      command = nil,
      executed = false,
      run_once = false,
    },
    win = nil,
    buf = nil,
    terminal = nil,
  }, { __index = self })

  -- Store the new instance in cache
  instances[name or execn] = instance
  return instance
end

---Store the floating window and buffer IDs.
---@param win_id WinId Window ID
---@param buf_id BufId Buffer ID
---@return M
function M:store(win_id, buf_id)
  self.win = win_id
  self.buf = buf_id
  return self
end

---Create a new buffer for the terminal.
---@return BufId
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

---Create a new floating window for the terminal buffer.
---@param buf BufId Buffer ID
---@return WinId
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
    title = { { self.name, visual } },
    title_pos = "center",
  })
  return win
end

---Switch to terminal mode and start insert mode if needed.
---@return M
function M:prompt()
  if vim.bo.filetype == "terminal" then
    vim.cmd.startinsert()
  end
  return self
end

---Check if a window ID is valid.
---@param win_id WinId
---@return boolean
local function is_valid(win_id)
  return win_id and vim.api.nvim_win_is_valid(win_id)
end

---Open a terminal in a floating window.
---@return M
function M:open_term()
  local term = vim.fn.termopen({ self.execn or vim.o.shell }, {
    on_exit = function(_, _, _)
      if is_valid(self.win) then
        vim.api.nvim_win_close(self.win, true)
      end
      if self.buf and vim.api.nvim_buf_is_valid(self.buf) then
        vim.api.nvim_buf_delete(self.buf, { force = true })
      end

      self.win = nil
      self.buf = nil
      self.terminal = nil
    end,
  })
  self.terminal = term

  return self:prompt()
end

---Remember the current cursor and window positions.
---@return M
function M:remember_cursor()
  self.last_tab = vim.api.nvim_get_current_tabpage()
  self.last_win = vim.api.nvim_get_current_win()
  self.prev_win = vim.fn.winnr("#")
  self.last_pos = vim.api.nvim_win_get_cursor(self.last_win)

  return self
end

---Restore the cursor and window positions.
---@return M
function M:restore_cursor()
  if self.last_win and self.last_pos ~= nil then
    if self.prev_win > 0 then
      vim.api.nvim_command(("silent! %s wincmd w"):format(self.prev_win))
    end

    if is_valid(self.last_win) then
      vim.api.nvim_set_current_win(self.last_win)
      if self.last_tab == vim.api.nvim_get_current_tabpage() then
        vim.api.nvim_set_current_win(self.last_win)
      end
      vim.api.nvim_win_set_cursor(self.last_win, self.last_pos)
    end

    self.last_win = nil
    self.prev_win = nil
    self.last_pos = nil
  end

  return self
end

---Open the terminal manager's floating terminal.
---@return M
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

---Close the floating terminal window.
---@return M
function M:close()
  if not is_valid(self.win) then
    return self
  end
  self:restore_cursor()
  vim.api.nvim_win_close(self.win, false)
  self.win = nil
  return self
end

---Handle terminal losing focus by automatically closing it.
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

---Toggle the terminal between open and closed states.
---@return M
function M:toggle()
  if is_valid(self.win) then
    self:close()
    if self.command_mode.command then
      self.command_mode.executed = true
    end
  else
    self:open()
    self:terminal_lost_focus()
    if self.command_mode.command and not self.command_mode.run_once then
      self.command_mode.executed = false
    end
  end
  return self
end

---Run a command in the terminal.
---@param command string | function Command to run
function M:run(command)
  if not command then
    return
  end
  self.command_mode.command = command
  self:toggle()

  local exec = type(command) == "function" and command() or command
  if self.command_mode.executed then
    return
  end
  vim.defer_fn(function()
    vim.api.nvim_chan_send(
      self.terminal,
      table.concat({
        type(exec) == "table" and table.concat(exec, " ") or exec,
        vim.api.nvim_replace_termcodes("<CR>", true, true, true),
      })
    )
  end, 50)
  return self
end

---Run a command only once in the terminal.
---@param command string | function Command to run once
function M:run_once(command)
  self.command_mode.command = command
  self.command_mode.run_once = true
  return self:run(self.command_mode.command)
end

return M
