local M = {
  "folke/which-key.nvim",
  enabled = true,
  event = "VeryLazy",
}

function M.config()
  local which_key = require("which-key")
  local setup = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "helix",
    -- Delay before showing the popup. Can be a number or a function that returns a number.
    ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
    delay = function(ctx)
      return ctx.plugin and 0 or 200
    end,
    --- You can add any mappings here, or use `require('which-key').add()` later
    ---@type wk.Spec
    spec = {},
    -- show a warning when issues were detected with your mappings
    notify = true,
    -- Enable/disable WhichKey for certain mapping modes
    modes = {
      n = true, -- Normal mode
      i = true, -- Insert mode
      x = false, -- Visual mode
      s = true, -- Select mode
      o = true, -- Operator pending mode
      t = true, -- Terminal mode
      c = true, -- Command mode
    },
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      presets = {
        operators = true, -- adds help for operators like d, y, ...
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    ---@type wk.Win
    win = {
      no_overlap = false,
      -- width = 1,
      -- height = { min = 4, max = 25 },
      -- col = 0,
      row = -1,
      -- border = "none",
      padding = { 1, 1 }, -- extra window padding [top/bottom, right/left]
      title = true,
      title_pos = "center",
      zindex = 1000,
      -- Additional vim.wo and vim.bo options
      bo = {},
      wo = {
        -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
    },
    layout = {
      width = { min = 20 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    keys = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    ---@type (string|wk.Sorter)[]
    --- Add "manual" as the first element to use the order the mappings were registered
    --- Other sorters: "desc"
    sort = { "local", "order", "group", "alphanum", "mod", "lower", "icase" },
    expand = 1, -- expand groups when <= n mappings
    ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
    replace = {
      key = {
        function(key)
          return require("which-key.view").format(key)
        end,
        -- { "<Space>", "SPC" },
      },
      desc = {
        { "<Plug>%((.*)%)", "%1" },
        { "^%+", "" },
        { "<[cC]md>", "" },
        { "<[cC][rR]>", "" },
        { "<[sS]ilent>", "" },
        { "^lua%s+", "" },
        { "^call%s+", "" },
        { "^:%s*", "" },
      },
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
      ellipsis = "…",
      --- See `lua/which-key/icons.lua` for more details
      --- Set to `false` to disable keymap icons
      ---@type wk.IconRule[]|false
      rules = false,
      -- use the highlights from mini.icons
      -- When `false`, it will use `WhichKeyIcon` instead
      colors = true,
      -- used by key format
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "󰘴 ",
        M = "󰘵 ",
        S = "󰘶 ",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "⌫",
        Space = "󱁐 ",
        Tab = "󰌒 ",
      },
    },
    show_help = true, -- show a help message in the command line for using WhichKey
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    -- Which-key automatically sets up triggers for your mappings.
    -- But you can disable this and setup the triggers yourself.
    -- Be aware, that triggers are not needed for visual and operator pending mode.
    triggers = true, -- automatically setup triggers
    disable = {
      -- disable WhichKey for certain buf types and file types.
      ft = {},
      bt = {},
      -- disable a trigger for a certain context by returning true
      ---@type fun(ctx: { keys: string, mode: string, plugin?: string }):boolean?
      trigger = function(ctx)
        return false
      end,
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
    --stylua: ignore start
    { "<leader>D", "<cmd>Telescope file_browser<cr>", desc = "File browser", },
    { "<leader>F", "<cmd>Telescope live_grep<cr>", desc = "Find Text", },
    { "<leader>M", "<cmd>MarkdownPreview<cr>", desc = "Markdown preview", },
    { "<leader>a", "<cmd>Alpha<cr>", desc = "Alpha", },

    { "<leader>b", group = "Buffer", },
    { "<leader>bb", function() require("telescope.builtin").buffers(require("telescope.themes").get_dropdown({ previewer = false })) end, desc = "Telescope Buffers", nowait = true, remap = false, },
    { "<leader>bn", "<Plug>(CybuNext)", desc = "Next Buffer", },
    { "<leader>bp", "<Plug>(CybuPrev)", desc = "Previous Buffer", },
    { "<leader>bx", "<cmd>bd<CR>", desc = "Close Buffer", },

    { "<leader>e", "<cmd>Neotree focus toggle<cr>", desc = "Explorer", },

    { "<leader>w", "<cmd>w!<CR>", desc = "Save", },

    { "<leader>q", "<cmd>q!<CR>", desc = "Quit", },
    { "<leader>c", function() vim.cmd("bdelete!") end, desc = "Close Buffer", },
    { "<leader>j", "<cmd>Jaq<CR>", desc = "Jaq", },
    { "<leader>o", "<cmd>URLOpenUnderCursor<CR>", desc = "Open URL", },
    { "<leader>f", function() require("telescope.builtin").find_files(require("telescope.themes")) end, desc = "Find files", nowait = true, remap = false, },
    { "<leader>p", function() require("telescope").extensions.projects.projects( require("telescope.themes").get_dropdown({ previewer = false })) end, desc = "Projects", },
    { "<leader>r", "<cmd>:Telescope oldfiles<cr>", desc = "Recent Files", },

    { "<leader>g", group = "Git", },
    { "<leader>gR", function() require 'gitsigns'.reset_buffer() end, desc = "Reset Buffer", },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff", },
    { "<leader>gg", function() _LAZYGIT_TOGGLE()              end, desc = "Lazygit", },
    { "<leader>gj", function() require 'gitsigns'.next_hunk() end, desc = "Next Hunk", },
    { "<leader>gk", function() require 'gitsigns'.prev_hunk() end, desc = "Prev Hunk", },
    { "<leader>gl", function() require 'gitsigns'.blame_line()end, desc = "Blame", },
    { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", },
    { "<leader>gp", function() require 'gitsigns'.preview_hunk()   end, desc = "Preview Hunk", },
    { "<leader>gr", function() require 'gitsigns'.reset_hunk()     end, desc = "Reset Hunk", },
    { "<leader>gs", function() require 'gitsigns'.stage_hunk()     end, desc = "Stage Hunk", },
    { "<leader>gu", function() require 'gitsigns'.undo_stage_hunk()end, desc = "Undo Stage Hunk", },

    { "<leader>h", group = "Harpoon", },
    { "<leader>ha", function() require("harpoon.mark").add_file()        end, desc = "Add file", },
    { "<leader>hh", function() require("harpoon.ui").nav_file(1)         end, desc = "Goto 1", },
    { "<leader>hj", function() require("harpoon.ui").nav_file(2)         end, desc = "Goto 2", },
    { "<leader>hk", function() require("harpoon.ui").nav_file(3)         end, desc = "Goto 3", },
    { "<leader>hl", function() require("harpoon.ui").nav_file(4)         end, desc = "Goto 4", },
    { "<leader>hn", function() require("harpoon.ui").nav_next()          end, desc = "Goto next", },
    { "<leader>hp", function() require("harpoon.ui").nav_prev()          end, desc = "Goto prev", },
    { "<leader>ht", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle menu", },

    { "<leader>d", group = "Debug", },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Out", nowait = true, remap = false, },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint", nowait = true, remap = false, },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue", nowait = true, remap = false, },
    { "<leader>di", function() require("dap").step_into() end, desc = "Into", nowait = true, remap = false, },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Last", nowait = true, remap = false, },
    { "<leader>do", function() require("dap").step_over() end, desc = "Over", nowait = true, remap = false, },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Repl", nowait = true, remap = false, },
    { "<leader>du", function() require("dapui").toggle() end, desc = "UI", nowait = true, remap = false, },
    { "<leader>dx", function() require("dap").terminate() end, desc = "Exit", nowait = true, remap = false, },

    { "<leader>l", group = "LSP", },
    { "<leader>lF", "<cmd>FormatToggle<cr>", desc = "Toggle Autoformat", },
    { "<leader>lI", "<cmd>Mason<cr>", desc = "Installer Info", },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", },
    { "<leader>lf", "<cmd>Format<cr>", desc = "Format", },
    { "<leader>lh",
      function()
         vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
      end,  desc = "Inlay Hints", },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", },
    { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic", },
    { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic", },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", },
    { "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", desc = "Quickfix", },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", },

    { "<leader>s", group = "Search", },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands", },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", },
    { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers", },
    { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", },
    { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", },
    { "<leader>sf", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in current buffer", },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", },
    { "<leader>sm", "<cmd>lua require('cppman').search()<cr>", desc = "Cpp Man Pages", },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", },

    { "<leader>t", group = "Terminal", },
    { "<leader>tH", function() _HTOP_TOGGLE() end, desc = "Htop", },
    { "<leader>tT", "<cmd>terminal<cr>", desc = "Neoterminal", },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", },
    { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal", },
    { "<leader>tn", function() _NODE_TOGGLE() end, desc = "Node", },
    { "<leader>tp", function() _PYTHON_TOGGLE() end, desc = "Python", },
    { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "toggle", },
    { "<leader>tu", function() _NCDU_TOGGLE() end, desc = "NCDU", },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical", },

    { "<leader>C", group = "Cmp", },
    { "<leader>Cd", function() vim.g.cmp_toggle = false end, desc = "Disable", nowait = true, remap = false, },
    { "<leader>Ce", function() vim.g.cmp_toggle = true end, desc = "Enable", nowait = true, remap = false, },

    { "<leader>v", group = "Visual", },
    { "<leader>va", "<cmd>norm mmggVG<cr>", desc = "Select all", },
    { "<leader>vs", "<cmd>%y<cr>", desc = "Copy all", },
    { "<leader>vx", "<cmd>norm ggVGx<cr>", desc = "Delete all", },

    { "<leader>x", group = "Trouble", },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle focus filter.buf=0<cr>", desc = "Toggle", },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Loclist", },
    { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix", },
    { "<leader>xw", "<cmd>Trouble diagnostics toggle focus<cr>", desc = "Workspace Diagnostics", },
    { "<leader>xx", "<cmd>Trouble diagnostics toggle focus filter.buf=0<cr>", desc = "Toggle", },
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode", },
    --stylua: ignore end
  }

  which_key.setup(setup)
  which_key.add(mappings, opts)
end

return M
