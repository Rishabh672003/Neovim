local M = {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  enabled = true,
  keys = {
    {"<leader>f", "<cmd>Telescope find_files<cr>"}
  }
}

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  telescope.setup({
    defaults = {
      initial_mode = "normal",
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = {
        ".git/",
        "target/",
        "docs/",
        "vendor/*",
        "%.lock",
        "__pycache__/*",
        "%.sqlite3",
        "%.ipynb",
        "node_modules/*",
        "%.jpg",
        "%.jpeg",
        "%.png",
        "%.svg",
        "%.otf",
        "%.ttf",
        "%.webp",
        ".dart_tool/",
        ".github/",
        ".gradle/",
        ".idea/",
        ".settings/",
        ".vscode/",
        "__pycache__/",
        "build/",
        "env/",
        "gradle/",
        "node_modules/",
        "%.pdb",
        "%.dll",
        "%.class",
        "%.exe",
        "%.cache",
        "%.ico",
        "%.pdf",
        "%.dylib",
        "%.jar",
        "%.docx",
        "%.met",
        "smalljre_*/*",
        ".vale/",
        "%.burp",
        "%.mp4",
        "%.mkv",
        "%.rar",
        "%.zip",
        "%.7z",
        "%.tar",
        "%.bz2",
        "%.epub",
        "%.flac",
        "%.tar.gz",
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-b>"] = actions.results_scrolling_up,
          ["<C-f>"] = actions.results_scrolling_down,
          ["<C-c>"] = actions.close,
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["<CR>"] = actions.select_default,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["<c-d>"] = actions.delete_buffer,
          -- ["<C-u>"] = actions.preview_scrolling_up,
          -- ["<C-d>"] = actions.preview_scrolling_down,

          -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<Tab>"] = actions.close,
          ["<S-Tab>"] = actions.close,
          -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-h>"] = actions.which_key, -- keys from pressing <C-h>
          -- ["<esc>"] = actions.close,
        },
        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["<C-b>"] = actions.results_scrolling_up,
          ["<C-f>"] = actions.results_scrolling_down,
          ["<Tab>"] = actions.close,
          ["<S-Tab>"] = actions.close,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,
          ["q"] = actions.close,
          ["dd"] = actions.delete_buffer,
          ["s"] = actions.select_horizontal,
          ["v"] = actions.select_vertical,
          ["t"] = actions.select_tab,
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,
          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,
          ["?"] = actions.which_key,
        },
      },
    },
    pickers = {
      current_buffer_fuzzy_find = {
        theme = "dropdown",
        previewer = true,
      },
      oldfiles = {
        theme = "dropdown",
        previewer = true,
      },
      live_grep = {
        theme = "dropdown",
      },
      grep_string = {
        theme = "dropdown",
      },
      find_files = {
        theme = "dropdown",
        previewer = true,
      },
      buffers = {
        theme = "dropdown",
        previewer = false,
      },
      planets = {
        show_pluto = true,
        show_moon = true,
      },
      lsp_references = {
        theme = "dropdown",
      },
      lsp_definitions = {
        theme = "dropdown",
      },
      lsp_declarations = {
        theme = "dropdown",
      },
      lsp_implementations = {
        theme = "dropdown",
      },
      git_branches = {
        theme = "dropdown",
      },
      git_branches = {
        theme = "dropdown",
        previewer = true,
      },
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      projects = {
        theme = "dropdown",
        previewer = true,
      },
      file_browser = {
        theme = "ivy",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        mappings = {
          ["i"] = {
            -- your custom insert mode mappings
          },
          ["n"] = {
            -- your custom normal mode mappings
          },
        },
        opts = {
          hidden = true,
        },
      },
    },
  })
  require("telescope").load_extension("projects")
end
return M
