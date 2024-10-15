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
  if (vim.bo.ft ~= "lazy") and (vim.bo.ft ~= "netrw") and (arg == "") then
    vim.fn.matchadd("Error", "[░▒]")
    vim.fn.matchadd("Function", "[▓█▄▀▐▌]")
    local map = function(lhs, rhs)
      vim.keymap.set("n", lhs, rhs, { silent = true, buffer = 0 })
    end
    local keys = {
      G = "ghostty/config",
      K = "kitty/kitty.conf",
      W = "wezterm/wezterm.lua",
      I = "nvim/init.lua",
      A = "alacritty/alacritty.toml",
      H = "hypr/hyprland.conf",
    }
    vim.api.nvim_put(center(header), "l", true, true)
    vim.api.nvim_put(center(text), "l", true, true)
    vim.cmd([[silent! setl nonu nornu nobl acd ft=dashboard bh=wipe bt=nofile]])
    for k, f in pairs(keys) do
      map(k, "<cmd>e " .. xdg .. f .. " | setl noacd<CR>")
    end
    map("q", "<cmd>q<CR>")
    map("o", "<cmd>e #<1<CR>") -- edit the last edited file
  end
end)
local au = function(events, ptn, cb)
  vim.api.nvim_create_autocmd(events, { pattern = ptn, [type(cb) == "function" and "callback" or "command"] = cb })
end
au("UIEnter", "*", splash_screen)
