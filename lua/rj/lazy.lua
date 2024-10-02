local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("rj.plugins", {
  change_detection = {
    enabled = true,
    notify = false,
  },
  git = {
    log = { "--since=3 days ago" }, -- show commits from the last 3 days
    timeout = 600,
  },
  defaults = {
    lazy = true,
  },
  install = { colorscheme = { "catppuccin-mocha" } },
  performance = {
    rtp = {
      paths = {
        vim.fn.expand("~") .. "/.config/nvim",
      },
      disabled_plugins = {},
    },
  },
})
