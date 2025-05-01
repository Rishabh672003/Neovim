Later(function()
  Add({
    source = "chomosuke/typst-preview.nvim",
  })
  require("typst-preview").setup({
    dependencies_bin = {
      ["tinymist"] = "/home/rishabh/.local/share/nvim/mason/bin/tinymist",
      ["websocat"] = nil,
    },
  })
end)
