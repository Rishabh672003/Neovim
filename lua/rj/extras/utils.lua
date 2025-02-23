---@class M
local M = {}
local uv = vim.uv

--- Checks if a target value exists in an array.
---@param array any[] The array to search.
---@param target any The value to search for.
---@return boolean #True if the target exists in the array, false otherwise.
function M.in_array(array, target)
  for _, value in ipairs(array) do
    if value == target then
      return true
    end
  end
  return false
end

--- Checks if a key-value pair exists in a table.
---@param tbl table The table to search.
---@param key_value {key: any, value: any} The key-value pair to search for.
---@return boolean #True if the key-value pair exists, false otherwise.
function M.in_table(tbl, key_value)
  for key, value in pairs(tbl) do
    if key == key_value.key and value == key_value.value then
      return true
    end
  end
  return false
end

--- Removes leading and trailing whitespace from a string.
---@param s string The input string.
---@return string #The stripped string.
function M.strip(s)
  return s:match("^%s*(.-)%s*$")
end

--- Reads the contents of a file into a string.
---@param filename string The path to the file.
---@return string|nil #The file contents as a string, or nil if an error occurs.
function M.read_file_to_string(filename)
  local fd = uv.fs_open(filename, "r", 438)
  if not fd then
    print("Error opening file: " .. filename)
    return nil
  end

  local stat = uv.fs_fstat(fd)
  if not stat then
    print("Error getting file stats: " .. filename)
    return nil
  end

  local data = uv.fs_read(fd, stat.size, 0)
  uv.fs_close(fd)
  if not data then return end
  return M.strip(data)
end

function M.read_file_to_table(filename)
  local f = io.open(filename, "r")
  local line_table = {}
  if f then
    while true do
      local line = f:read()
      if line == nil or line == "\n" then
        break
      end
      table.insert(line_table, M.strip(line))
    end
  end

  return line_table
end

return M
