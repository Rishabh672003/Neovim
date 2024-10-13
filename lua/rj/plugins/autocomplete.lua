Later(function()
  Add({
    source = "deathbeam/autocomplete.nvim",
  })
  -- LSP signature help
  require("autocomplete.signature").setup({
    border = nil, -- Signature help border style
    width = 80, -- Max width of signature window
    height = 25, -- Max height of signature window
    debounce_delay = 100,
  })

  -- buffer autocompletion with LSP and Tree-sitter
  require("autocomplete.buffer").setup({
    entry_mapper = nil, -- Custom completion entry mapper
    debounce_delay = 100,
  })

  -- cmdline autocompletion
  require("autocomplete.cmd").setup({
    mappings = {
      accept = "<C-y>",
      reject = "<C-e>",
      complete = "<C-space>",
      next = "<C-n>",
      previous = "<C-p>",
    },
    border = nil, -- Cmdline completion border style
    columns = 5, -- Number of columns per row
    rows = 0.3, -- Number of rows, if < 1 then its fraction of total vim lines, if > 1 then its absolute number
    close_on_done = true, -- Close completion window when done (accept/reject)
    debounce_delay = 100,
  })

  Capabilities = vim.tbl_deep_extend("force", Capabilities, require("autocomplete.capabilities"))
end)
