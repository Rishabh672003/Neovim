local M = {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  dependencies = {
    "nvim-treesitter/playground",
    "nvim-tree/nvim-web-devicons",
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        require("ts_context_commentstring").setup({
          enable_autocmd = false,
        })
        vim.g.skip_ts_context_commentstring_module = true
      end,
    },
  },
}

function M.config()
  local configs = require("nvim-treesitter.configs")
  configs.setup({
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "go",
      "html",
      "html",
      "java",
      "javascript",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "python",
      "rust",
      "toml",
      "vim",
      "vimdoc",
    }, -- put the language you want in this table
    -- ensure_installed = "all",
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = {}, -- List of parsers to ignore installing
    autopairs = {
      enable = true,
    },
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = function(lang, bufnr) -- Disable in files with more than 10K lines
        return vim.api.nvim_buf_line_count(bufnr) > 10000
      end,
    },
    indent = { enable = true, disable = { --[[ "python", ]] "html", "cpp", "css" } },
  })
end

return M
