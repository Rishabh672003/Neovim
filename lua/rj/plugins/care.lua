Now(function()
  Add({
    source = "max397574/care.nvim",
    depends = {
      {
        source = "romgrk/fzy-lua-native",
        post_install = function()
          vim.cmd("make")
        end,
      },
    },
  })
  require("care").setup()
  vim.keymap.set("i", "<C-y>", "<Plug>(CareConfirm)")
  vim.keymap.set("i", "<C-e>", "<Plug>(CareClose)")
  vim.keymap.set("i", "<C-n>", "<Plug>(CareSelectNext)")
  vim.keymap.set("i", "<C-p>", "<Plug>(CareSelectPrev)")
  vim.keymap.set("i", "<Tab>", function() vim.snippet.jump(1) end)
  vim.keymap.set("i", "<S-Tab>", function() vim.snippet.jump(-1) end)
  vim.keymap.set("i", "<C-Space>", function() require("care").api.complete() end)

  vim.keymap.set("i", "<C-f>", function()
    if require("care").api.doc_is_open() then
      require("care").api.scroll_docs(4)
    else
      vim.api.nvim_feedkeys(vim.keycode("<c-f>"), "n", false)
    end
  end)

  vim.keymap.set({ "i", "s" }, "<C-d>", function()
    if require("care").api.doc_is_open() then
      require("care").api.scroll_docs(-4)
    elseif require("luasnip").choice_active() then
      require("luasnip").change_choice(-1)
    else
      vim.api.nvim_feedkeys(vim.keycode("<C-f>"), "n", false)
    end
  end)
end)
