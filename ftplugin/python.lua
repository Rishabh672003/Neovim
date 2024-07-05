local status_ok, _ = pcall(require, "swenv")
if not status_ok then
  return "Swenv not found"
else
  require("swenv.api").auto_venv()
end

local status, wk = pcall(require, "which-key")
if not status then
  return "Whick-key not found"
end

local keymaps = {
  ["<leader>lps"] = {
    function()
      require("swenv.api").pick_venv()
    end,
    "Pick venv",
  },

  ["<leader>lpc"] = {
    function()
      vim.notify(require("swenv.api").get_current_venv().name)
    end,
    "get_current_venv",
  },

  ["<leader>lpr"] = {
    function()
      vim.cmd("LspRestart")
    end,
    "Restart Lsp",
  },
}

wk.register(keymaps)
