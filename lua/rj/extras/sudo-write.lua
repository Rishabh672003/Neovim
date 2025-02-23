-- Taken from [NTBBloodbath](https://github.com/NTBBloodbath/nvim/blob/main/lua/utils/sudo_write.lua)
-- Who Extracted and modified it from:
-- https://gist.github.com/oessessnex/d63ebe89380abff5a3ee70d6e76e4ec8

local sudo_write = {}

local uv = vim.uv

local function password()
  vim.fn.inputsave()
  local user = vim.env.USER
  local pw = vim.fn.inputsecret(string.format("password for %s: ", user))
  vim.fn.inputrestore()
  return pw
end

local function test(pw, k)
  local stdin = uv.new_pipe()
  if not stdin then return end
  ---@diagnostic disable-next-line undefined-field
  uv.spawn("sudo", {
    args = { "-S", "-k", "true" },
    stdio = { stdin, nil, nil },
  }, k)

  stdin:write(pw)
  stdin:write("\n")
  stdin:shutdown()
end

local function write(pw, buf, lines, k)
  local stdin = uv.new_pipe()
  if not stdin then return end
  ---@diagnostic disable-next-line undefined-field
  uv.spawn("sudo", {
    args = { "-S", "-k", "tee", buf },
    stdio = { stdin, nil, nil },
  }, k)

  stdin:write(pw)
  stdin:write("\n")
  local last = table.remove(lines)
  for _, line in ipairs(lines) do
    stdin:write(line)
    stdin:write("\n")
  end
  stdin:write(last)
  stdin:shutdown()
end

function sudo_write.write()
  local pw = password()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(bufnr)

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local function exitWrite(code, _)
    if code == 0 then
      vim.schedule(function()
        print('"' .. buf_name .. '" written')
        vim.api.nvim_set_option_value("modified", false, { buf = bufnr })
      end)
    end
  end

  local function exitTest(code, _)
    if code == 0 then
      write(pw, buf_name, lines, exitWrite)
    else
      vim.schedule(function()
        vim.notify("[utils.sudo_write] Incorrect password provided", vim.log.levels.ERROR)
      end)
    end
  end

  test(pw, exitTest)
end

return sudo_write
