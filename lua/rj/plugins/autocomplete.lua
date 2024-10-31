Later(function()
  Add({
    source = "deathbeam/autocomplete.nvim",
  })

  -- cmdline autocompletion
  require("autocomplete.cmd").setup({
    mappings = {
      accept = "<C-y>",
      reject = "<C-e>",
      complete = "<C-Space>",
      next = "<C-n>",
      previous = "<C-p>",
    },
    border = nil, -- Cmdline completion border style
    columns = 5, -- Number of columns per row
    rows = 0.3, -- Number of rows, if < 1 then its fraction of total vim lines, if > 1 then its absolute number
    close_on_done = true, -- Close completion window when done (accept/reject)
    debounce_delay = 100,
  })
end)
