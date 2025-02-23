---@class Module
local M = {}

---@type string
local ORIGINAL_PATH = vim.fn.getenv("PATH") or ""

--- The current virtual environment path, or nil if none is set.
---@type string|nil
M.cur_env = nil

local utils = require("rj.extras.utils")

--- Find the virtual environment directory.
---@return string|nil # The path to the virtual environment, or nil if not found.
local function find_env()
  ---@type string|nil
  local root = vim.fs.root(0, { ".git", "pyproject.toml" })
  if not root then
    return nil
  end
  ---@type string
  local path = root .. "/.venv"

  local stat = vim.loop.fs_stat(path)
  if stat then
    if stat.type == "directory" then
      return path
    elseif stat.type == "file" then
      local env_path = utils.read_file_to_string(path)
      if env_path and #env_path > 0 then
        return vim.fn.expand("~/.virtualenvs/" .. env_path)
      end
    end
  end
  return nil
end

--- Set the virtual environment for the current project.
function M.setup()
  ---@type string|nil
  local virtual_env = find_env()

  if not virtual_env then
    return
  end

  if M.cur_env ~= virtual_env then
    M.cur_env = virtual_env
  else
    return
  end

  vim.fn.setenv("PATH", virtual_env .. "/bin:" .. ORIGINAL_PATH)
  vim.fn.setenv("VIRTUAL_ENV", virtual_env)
end

return M
-- vim: fdm=marker fdl=0
