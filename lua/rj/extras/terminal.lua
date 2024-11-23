-- Credit to :me :)
-- very much inspired from [chipsenkbeil](https://github.com/chipsenkbeil/neovimconf-2024-talk)

local M = {}

-- Terminal configurations
local terminals = {
  { execn = "zsh", hidden = false, win_id = nil, curr_id = nil },
  { execn = "lazygit", hidden = false, win_id = nil, curr_id = nil },
  { execn = "btop", hidden = false, win_id = nil, curr_id = nil },
}

--- Helper function to create a floating window buffer.
---@return integer buffer ID
local function create_scratch_buf()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
  vim.api.nvim_set_option_value("filetype", "terminal", { buf = buf })
  return buf
end

--- Helper function to calculate the size and position of the floating window.
---@param term_name string terminal name
---@return table win_config
local function calculate_float_win_config(term_name)
  local height = math.ceil(vim.o.lines * 0.75)
  local width = math.ceil(vim.o.columns * 0.9)
  return {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = math.ceil((vim.o.lines - height) / 2.5),
    col = math.ceil((vim.o.columns - width) / 2),
    border = "single",
    ---@diagnostic disable-next-line: undefined-global
    title = { { term_name, visual } },
    title_pos = "left",
  }
end

local function is_valid(win_id)
  return win_id and vim.api.nvim_win_is_valid(win_id)
end

--- Opens a floating terminal window for a given executable.
---@param term_config table Terminal configuration: { execn, hidden, win_id, curr_id }
function M.open_terminal(term_config)
  term_config.curr_id = vim.api.nvim_get_current_win()

  if is_valid(term_config.win_id) then
    pcall(vim.api.nvim_set_current_win, term_config.win_id)
    vim.cmd.startinsert()
    return
  end

  local buf = create_scratch_buf()
  local config = calculate_float_win_config(term_config.execn)
  local win_id = vim.api.nvim_open_win(buf, true, config)

  vim.fn.termopen({ term_config.execn }, {
    on_exit = function(_, _, _)
      if vim.api.nvim_win_is_valid(win_id) then
        vim.api.nvim_win_close(win_id, true)
      end
      term_config.win_id = nil
      term_config.hidden = false
      term_config.curr_id = nil
    end,
  })

  term_config.win_id = win_id
  term_config.hidden = false
  vim.cmd.startinsert()
end

--- Hides a terminal window for a given configuration.
---@param term_config table Terminal configuration: { execn, hidden, win_id, curr_id}
function M.hide_terminal(term_config)
  if not term_config.hidden and is_valid(term_config.win_id) then
    vim.api.nvim_win_set_config(term_config.win_id, { hide = true })
    term_config.hidden = true
    pcall(vim.api.nvim_set_current_win, term_config.curr_id)
  end
end

--- Unhides a terminal window for a given configuration.
---@param term_config table Terminal configuration: { execn, hidden, win_id, curr_id }
function M.unhide_terminal(term_config)
  term_config.curr_id = vim.api.nvim_get_current_win()
  if term_config.hidden and is_valid(term_config.win_id) then
    vim.api.nvim_win_set_config(term_config.win_id, { hide = false })
    term_config.hidden = false
    pcall(vim.api.nvim_set_current_win, term_config.win_id)
    vim.cmd.startinsert()
  end
end

--- Toggles a terminal's visibility for a given configuration.
---@param term_config table Terminal configuration: { execn, hidden, win_id, curr_id }
function M.toggle_terminal(term_config)
  if not term_config.win_id then
    M.open_terminal(term_config)
  elseif term_config.hidden then
    M.unhide_terminal(term_config)
  else
    M.hide_terminal(term_config)
  end
end

--- Finds a terminal configuration by executable name.
---@param exec_name string The name of the executable (e.g., "zsh")
---@return table|nil The terminal configuration, or nil if not found
local function find_terminal_by_exec(exec_name)
  for _, term in ipairs(terminals) do
    if term.execn == exec_name then
      return term
    end
  end
  return nil
end

function M.terminal_lost_focus(term_cofig)
  local track = vim.schedule_wrap(function()
    if vim.api.nvim_get_current_win() == term_cofig.win_id then
      return
    end
    M.hide_terminal(term_cofig)
  end)
  vim.uv.new_timer():start(100, 100, track)
end

--- Toggles a terminal by its executable name.
---@param exec_name string The name of the executable (e.g., "zsh")
function M.toggle(exec_name)
  local term_config = find_terminal_by_exec(exec_name)
  if not term_config then
    vim.notify("No terminal configured for executable: " .. exec_name, vim.log.levels.ERROR)
    return
  end
  M.toggle_terminal(term_config)
  M.terminal_lost_focus(term_config)
end

return M
