local M = {
  "echasnovski/mini.completion",
  version = false,
  event = { "VeryLazy", "LspAttach" },
  lazy = true,
  enabled = true,
}

M.config = function()
  require("mini.completion").setup({
    delay = { completion = 100, info = 100, signature = 50 },

    window = {
      info = { height = 25, width = 80, border = "rounded" },
      signature = { height = 25, width = 80, border = "rounded" },
    },

    -- Way of how module does LSP completion
    lsp_completion = {
      -- `source_func` should be one of 'completefunc' or 'omnifunc'.
      source_func = "completefunc",

      -- `auto_setup` should be boolean indicating if LSP completion is set up
      -- on every `BufEnter` event.
      auto_setup = true,
    },
    mappings = {
      force_twostep = "<C-Space>", -- Force two-step completion
      force_fallback = "<A-Space>", -- Force fallback completion
    },

    -- Whether to set Vim's settings for better experience (modifies
    -- `shortmess` and `completeopt`)
    set_vim_settings = true,
  })

  -- mini.completions
  local keycode = vim.keycode or function(x)
    return vim.api.nvim_replace_termcodes(x, true, true, true)
  end
  local keys = {
    ["cr"] = keycode("<CR>"),
    ["ctrl-y"] = keycode("<C-y>"),
    ["ctrl-y_cr"] = keycode("<C-y><CR>"),
  }

  _G.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
      -- If popup is visible, confirm selected item or add new line otherwise
      local item_selected = vim.fn.complete_info()["selected"] ~= -1
      return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
    else
      -- If popup is not visible, use plain `<CR>`. You might want to customize
      -- according to other plugins. For example, to use 'mini.pairs', replace
      -- next line with `return require('mini.pairs').cr()`
      return keys["cr"]
    end
  end
end

return M
