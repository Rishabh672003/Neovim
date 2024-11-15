-- credit to: [tomtom-aquib](https://github.com/tamton-aquib)

local first = true

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
  first = false
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
    vim.cmd([[silent! setl nonu nornu nobl acd ft=dashboard bh=wipe bt=nofile]])
    for k, f in pairs(keys) do
      map(k, "<Cmd>e " .. xdg .. f .. " | setl noacd<CR>")
    end
    map("q", "<Cmd>q<CR>")
    map("o", "<Cmd>e #<1<CR>")
    map("p", function()
      require("telescope").extensions.projects.projects(require("telescope.themes").get_dropdown({ previewer = false }))
    end)
    map("r", "<Cmd>Telescope oldfiles<CR>")
    vim.cmd("setlocal nomodifiable")
    vim.cmd("norm 2w")
  end
end)

vim.api.nvim_create_autocmd("UIEnter", {
  pattern = "*",
  callback = function()
    -- Have to do this so that splash screen doesnt show and mess up the screen
    -- after <C-z> and `fg`, so we make sure that dashboard only appears once
    if first then splash_screen()
    else return end
  end
})
