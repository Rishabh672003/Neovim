local M = {
  "trimclain/builder.nvim",
  cmd = "Build",
    -- stylua: ignore
    keys = {
        { "<leader>j", function() require("builder").build() end, desc = "Build" }
    },
  enabled = false,
  config = true,
}

function M.config()
  require("builder").setup({
    -- location of Builder buffer; opts: "bot", "top", "vert" or float
    type = "bot",
    -- percentage of width/height for type = "vert"/"bot" between 0 and 1
    size = 0.25,
    -- size of the floating window for type = "float"
    float_size = {
      height = 0.8,
      width = 0.8,
    },
    -- which border to use for the floating window (see `:help nvim_open_win`)
    float_border = "none",
    -- show/hide line numbers in the Builder buffer
    line_number = false,
    -- automatically save before building
    autosave = true,
    -- keymaps to close the builder buffer, same format as for vim.keymap.set
    close_keymaps = { "q", "<Esc>" },
    -- measure the time it took to build (currently enabled only on linux)
    measure_time = true,
    -- commands for building each filetype; see below
    -- for lua and vim filetypes `:source %` will be used by default
    commands = {
      typescript = "deno run %",
      javascript = "node %",
      java = "java %",
      markdown = "glow %",
      python = "python %",
      rust = "rustc % -o $fileBase.out && ./$fileBase.out",
      -- rust = "cargo run",
      cpp = "g++ % -o $fileBase.out && ./$fileBase.out",
      c = "gcc % -o $fileBase.out && ./$fileBase.out",
      go = "go run %",
      sh = "chmod +x % && sh %",
      zsh = "zsh %",
      -- lua = "lua %",
    },
  })
end

return M
