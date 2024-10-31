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
  vim.keymap.set("i", "<c-e>", "<Plug>(CareClose)")
  vim.keymap.set("i", "<c-n>", "<Plug>(CareSelectNext)")
  vim.keymap.set("i", "<c-p>", "<Plug>(CareSelectPrev)")
  -- vim.keymap.set("i", "<c-n>", function() vim.snippet.jump(1) end)
  -- vim.keymap.set("i", "<c-p>", function() vim.snippet.jump(-1) end)
  vim.keymap.set("i", "<c-Space>", function() require("care").api.complete() end)

  vim.keymap.set("i", "<c-f>", function()
    if require("care").api.doc_is_open() then
      require("care").api.scroll_docs(4)
    else
      vim.api.nvim_feedkeys(vim.keycode("<c-f>"), "n", false)
    end
  end)

  vim.keymap.set({ "i", "s" }, "<c-d>", function()
    if require("care").api.doc_is_open() then
      require("care").api.scroll_docs(-4)
    elseif require("luasnip").choice_active() then
      require("luasnip").change_choice(-1)
    else
      vim.api.nvim_feedkeys(vim.keycode("<c-f>"), "n", false)
    end
  end)
end)
