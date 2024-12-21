---@diagnostic disable: undefined-global
local M = {}
local utils = require("rj.extras.utils")

local function extract_last_two_dirs(path)
  local components = {}
  for part in string.gmatch(path, "[^/]+") do
    table.insert(components, part)
  end

  local n = #components
  if n >= 2 then
    return components[n - 1] .. "/" .. components[n]
  elseif n == 1 then
    return components[n]
  else
    return ""
  end
end

function M.projects(_, opts)
  local projects = {}
  local projects_file_path = vim.fn.stdpath("data") .. "/projects"
  local projects_dirs = utils.read_file_to_table(projects_file_path)

  for _, dir in ipairs(projects_dirs) do
    table.insert(projects, { text = " " .. extract_last_two_dirs(dir), dir = dir })
  end

  local function choose(item)
    if not item then
      return
    end

    vim.schedule(function()
      MiniPick.builtin.files({ tool = "fd" }, { source = { cwd = item.dir } })
    end)
  end

  local function preview(buf_id, item)
    if not item then
      return
    end

    local files = {}
    for name, type in vim.fs.dir(item.dir) do
      if type == "file" and not name:match("^%.") then
        table.insert(files, name)
      end
    end

    vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, files)
  end

  local source = { items = projects, name = "Projects", choose = choose, preview = preview }
  opts = vim.tbl_deep_extend("force", { source = source }, opts or {})
  return MiniPick.start(opts)
end

function M.add_project()
  local root = vim.fs.root(0, { ".git", "Makefile", "LICENSE" })
  if not root then
    return
  end
  local projects_file_path = vim.fn.stdpath("data") .. "/projects"
  local projects_dirs = utils.read_file_to_table(projects_file_path)

  if utils.in_array(projects_dirs, root) then
    return
  end

  local file = io.open(projects_file_path, "a")
  if file then
    file:write(root .. "\n")
    file:close()
  end
end

local usercmd = vim.api.nvim_create_user_command

usercmd("AddProjects", function() M.add_project() end, {})
usercmd("Projects", function() M.projects() end, {})

return M
