local M = {
  "folke/which-key.nvim",
  enabled = true,
  event = "VeryLazy",
}

function M.config()
  local which_key = require("which-key")
  local setup = {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = false, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
    ["b"] = {
      function()
        require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ previewer = false }))
      end,
      "Buffers",
    },
    ["D"] = { "<cmd>Telescope file_browser<cr>", "File browser" },
    ["e"] = { "<cmd>Neotree focus toggle<cr>", "Explorer" },
    ["E"] = { "<cmd>Oil --float .<cr>", "Explorer" },
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["c"] = { "<cmd>bdelete!<CR>", "Close Buffer" },
    ["j"] = { "<cmd>Jaq<CR>", "Jaq" },
    ["f"] = {
      function()
        require("telescope.builtin").find_files(require("telescope.themes"))
      end,
      "Find files",
    },
    ["F"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
    ["p"] = {
      function()
        require("telescope").extensions.projects.projects(
          require("telescope.themes").get_dropdown({ previewer = false })
        )
      end,
      "Projects",
    },
    ["S"] = { "<cmd>source %<cr>", "Source file" },
    L = {
      name = "Lazy",
      s = { "<cmd>Lazy update<cr>", "Update" },
      l = { "<cmd>Lazy log<cr>", "Log" },
      p = { "<cmd>Lazy profile<cr>", "Profile" },
      d = { "<cmd>Lazy debug<cr>", "Debug" },
      c = { "<cmd>Lazy clean<cr>", "Clean" },
      S = { "<cmd>Lazy<cr>", "Lazy" },
    },
    ["r"] = { "<cmd>:Telescope oldfiles<cr>", "Recent Files" },
    g = {
      name = "Git",
      --stylua: ignore start
      g = { function() _LAZYGIT_TOGGLE()end, "Lazygit" },
      j = { function() require 'gitsigns'.next_hunk() end, "Next Hunk" },
      k = { function() require 'gitsigns'.prev_hunk() end, "Prev Hunk" },
      l = { function() require 'gitsigns'.blame_line() end, "Blame" },
      p = { function() require 'gitsigns'.preview_hunk() end, "Preview Hunk" },
      r = { function() require 'gitsigns'.reset_hunk() end, "Reset Hunk" },
      R = { function() require 'gitsigns'.reset_buffer() end, "Reset Buffer" },
      s = { function() require 'gitsigns'.stage_hunk() end, "Stage Hunk" },
      u = { function() require 'gitsigns'.undo_stage_hunk() end, "Undo Stage Hunk", },
      --stylua: ignore end
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
    },
    d = {
      name = "Debug",
      --stylua: ignore start
      b = { function() require'dap'.toggle_breakpoint() end, "Breakpoint" },
      c = { function() require'dap'.continue() end, "Continue" },
      i = { function() require'dap'.step_into() end, "Into" },
      o = { function() require'dap'.step_over() end, "Over" },
      O = { function() require'dap'.step_out() end, "Out" },
      r = { function() require'dap'.repl.toggle() end, "Repl" },
      l = { function() require'dap'.run_last() end, "Last" },
      u = { function() require'dapui'.toggle() end, "UI" },
      x = { function() require'dap'.terminate() end, "Exit" },
      --stylua: ignore end
    },
    ["M"] = { "<cmd>MarkdownPreview<cr>", "Markdown preview" },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      f = {
        function()
          require("conform").format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 700,
          })
        end,
        "Format",
      },
      F = { "<cmd>FormatToggle<cr>", "Toggle Autoformat" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>Mason<cr>", "Installer Info" },
      j = {
        "<cmd>lua vim.diagnostic.goto_next()<CR>",
        "Next Diagnostic",
      },
      k = {
        "<cmd>lua vim.diagnostic.goto_prev()<cr>",
        "Prev Diagnostic",
      },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
      },
    },
    s = {
      name = "Search",
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      m = { "<cmd>lua require('cppman').search()<cr>", "Cpp Man Pages" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
      f = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find in current buffer" },
    },
    T = {
      name = "Treesitter",
      i = { "<cmd>TSInstallInfo<cr>", "Install info" },
      u = { "<cmd>TSUpdate<cr>", "Update" },
      s = { "<cmd>TSUpdateSync<cr>", "Update and sync" },
      e = { "<cmd>TSEnable<cr>", "Enable" },
      d = { "<cmd>TSDisable<cr>", "Disable" },
    },
    t = {
      name = "Terminal",
      --stylua: ignore start
      n = { function() _NODE_TOGGLE() end, "Node" },
      u = { function() _NCDU_TOGGLE() end, "NCDU" },
      H = { function() _HTOP_TOGGLE() end, "Htop" },
      p = { function() _PYTHON_TOGGLE() end, "Python" },
      --stylua: ignore end
      f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
      h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
      v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
      t = { "<cmd>ToggleTerm<cr>", "toggle" },
      T = { "<cmd>terminal<cr>", "Neoterminal" },
    },
    C = {
      name = "Cmp",
      c = { "<cmd>Copilot<cr>", "Copilot" },
      e = { "<cmd>let g:cmp_toggle = v:true<cr>", "Enable" },
      d = { "<cmd>let g:cmp_toggle = v:false<cr>", "Disable" },
      g = { "<cmd>NeoAI<cr>", "ChatGpt" },
    },
    ["z"] = { "<cmd>ZenMode<cr>", "Zen Mode" },
  }

  which_key.setup(setup)
  which_key.register(mappings, opts)
end

return M
