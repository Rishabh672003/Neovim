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

local function ensure_projects_file()
  local projects_file_path = vim.fn.stdpath("data") .. "/projects.json"
  if not vim.uv.fs_stat(projects_file_path) then
    local default_content = { directories = {} }
    vim.fn.writefile({ vim.json.encode(default_content) }, projects_file_path)
  end
  return projects_file_path
end

local function read_projects_file()
  local projects_file_path = ensure_projects_file()
  local content = utils.read_file_to_string(projects_file_path)
  return content and vim.json.decode(content) or { directories = {} }
end

local function write_projects_file(data)
  local projects_file_path = ensure_projects_file()
  vim.fn.writefile({ vim.json.encode(data) }, projects_file_path)
end

function M.projects(_, opts)
  local projects_data = read_projects_file()
  local projects = {}

  for _, dir in ipairs(projects_data.directories) do
    table.insert(projects, { text = " " .. extract_last_two_dirs(dir), dir = dir })
  end

  local function choose(item)
    local dir = item.dir
    if not vim.uv.fs_stat(dir) then
      vim.notify("Directory doesnt exist", vim.log.levels.ERROR)
      return
    end
    vim.schedule(function()
      local choose_file_continue = function(selected_item)
        local target = dir .. "/" .. selected_item
        if not vim.uv.fs_stat(target) then
          return
        end
        vim.api.nvim_win_call(MiniPick.get_picker_state().windows.target, function()
          vim.cmd("edit " .. target)
          MiniPick.set_picker_target_window(vim.api.nvim_get_current_win())
          return true
        end)
      end
      MiniPick.builtin.files({ tool = "fd" }, { source = { cwd = item.dir, choose = choose_file_continue } })
    end)
  end

  local function preview(buf_id, item)
    if not item then
      return
    end
    local files = {}
    for name, type in vim.fs.dir(item.dir) do
      if type == "file" and not name:match("^%.") then
        table.insert(files, MiniIcons.get("file", name) .. " " .. name)
      end
    end
    vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, files)
  end

  local source = { items = projects, name = "Projects", choose = choose, preview = preview }
  opts = vim.tbl_deep_extend("force", { source = source }, opts or {})
  return MiniPick.start(opts)
end

function M.add_project()
  local root = vim.fs.root(0, { ".git", "Makefile", "LICENSE", "Cargo.toml" })
  if not root then
    return
  end
  root = vim.fn.fnamemodify(root, ":p:h")

  local projects_data = read_projects_file()
  if utils.in_array(projects_data.directories, root) then
    return
  end
  table.insert(projects_data.directories, root)
  table.sort(projects_data.directories)
  write_projects_file(projects_data)
end

function M.edit_project()
  local projects_file_path = ensure_projects_file()
  vim.cmd.vsplit()
  vim.cmd.edit(projects_file_path)
end

function M.sanitize_project()
  local projects_data = read_projects_file()
  for index, dir in ipairs(projects_data.directories) do
    if not vim.uv.fs_stat(dir) then
      table.remove(projects_data.directories, index)
    end
  end
  write_projects_file(projects_data)
end

local usercmd = vim.api.nvim_create_user_command
usercmd("Projects", M.projects, { desc = "Choose a project in mini.pick" })
usercmd("AddProject", M.add_project, { desc = "Add the current project to the list" })
usercmd("EditProject", M.edit_project, { desc = "Open the project file" })
usercmd("SanitizeProject", M.sanitize_project, { desc = "Remove the projects that dont exist" })

return M
