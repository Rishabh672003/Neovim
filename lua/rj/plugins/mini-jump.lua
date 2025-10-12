Now(function()
  require("mini.jump").setup()
  require('mini.jump2d').setup()
  local jump_stop = function()
    if not MiniJump.state.jumping then
      return "<Esc>"
    end
    MiniJump.stop_jumping()
  end
  local opts = { expr = true, desc = "Stop jumping" }
  vim.keymap.set({ "n", "x", "o" }, "<Esc>", jump_stop, opts)
end)
