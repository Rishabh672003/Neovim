-- credit to: [tomtom-aquib](https://github.com/tamton-aquib)

local center = function(dict)
  local new_dict = {}
  for _, v in pairs(dict) do
    local padding = vim.fn.max(vim.fn.map(dict, "strwidth(v:val)"))
    local spacing = (" "):rep(math.floor((vim.o.columns - padding) / 2)) .. v
    table.insert(new_dict, spacing)
  end
  return new_dict
end

local splash_screen = vim.schedule_wrap(function()
  local xdg = vim.fn.fnamemodify(vim.fn.stdpath("config") --[[@as string]], ":h") .. "/"
  local header = {
    "",
    "",
    "",
    "",
    "",
    "",

    [[  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ ]],
    [[  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ]],
    [[ ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ ]],
    [[ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  ]],
    [[ ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ ]],
    [[ ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ]],
    [[ ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ]],
    [[    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ]],
    [[          ░    ░  ░    ░ ░        ░   ░         ░    ]],
    [[                                                ░    ]],
  }
  local text = {
    "",
    "",
    [[Everything will be just fine in the end]],
  }
  local arg = vim.fn.argv(0)
  if (vim.bo.ft ~= "netrw") and (arg == "") then
    vim.fn.matchadd("Error", "[░▒]")
    vim.fn.matchadd("Function", "[▓█▄▀▐▌]")
    local map = function(lhs, rhs)
      vim.keymap.set("n", lhs, rhs, { silent = true, buffer = 0 })
    end
    local keys = {
      G = "ghostty/config",
      I = "nvim/init.lua",
      H = "hypr/hyprland.conf",
    }
    vim.api.nvim_put(center(header), "l", true, true)
    vim.api.nvim_put(center(text), "l", true, true)
    local lopt = vim.opt_local

    lopt.number = false
    lopt.relativenumber = false
    lopt.buflisted = false
    lopt.filetype = "dashboard"
    lopt.bufhidden = "wipe"
    lopt.buftype = "nofile"
    lopt.cursorline = false
    lopt.modifiable = false

    for k, f in pairs(keys) do
      map(k, "<Cmd>e " .. xdg .. f .. "<CR>")
    end
    map("q", "<Cmd>q<CR>")
    map("o", "<Cmd>e #<1<CR>")
    map("p", "<Cmd>Projects<CR>")
    map("r", "<Cmd>lua MiniExtra.pickers.oldfiles()<CR>")
    vim.cmd("norm 2w")
  end
end)

vim.api.nvim_create_autocmd("UIEnter", {
  pattern = "*",
  once = true,
  callback = function()
    if vim.bo.filetype == "man" then return end
    splash_screen()
  end,
})
