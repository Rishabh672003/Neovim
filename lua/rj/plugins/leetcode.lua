Later(function()
  Add({
    source = "kawre/leetcode.nvim",
    depends = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
  })
  require("leetcode").setup({
    lang = "python3",
    storage = {
      home = vim.fn.stdpath("data") .. "/leetcode",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },
    plugins = {
      non_standalone = true,
    },
    injector = {
      ["rust"] = {
        before = { "#[allow(dead_code)]", "fn main(){}", "#[allow(dead_code)]", "struct Solution;" },
      }, ---@type table<lc.lang, lc.inject>
    },
    hooks = {
      ---@type fun(question: lc.ui.Question)[]
      ["question_enter"] = {
        function(question)
          if question.lang ~= "rust" then
            return
          end
          local problem_dir = vim.fn.stdpath("data") .. "/leetcode/Cargo.toml"
          local content = [[
              [package]
              name = "leetcode"
              edition = "2021"
                                                                                                     
              [lib]
              name = "%s"
              path = "%s"
                                                                                                     
              [dependencies]
              rand = "0.8"
              regex = "1"
              itertools = "0.14.0"
            ]]
          local file = io.open(problem_dir, "w")
          if file then
            local formatted = (content:gsub(" +", "")):format(question.q.frontend_id, question:path())
            file:write(formatted)
            file:close()
          else
            print("Failed to open file: " .. problem_dir)
          end
        end,
      },
    },
  })

  local keymap = vim.keymap.set
  keymap("n", "<Leader>lct", "<Cmd>Leet test<Cr>", { desc = "test" })
  keymap("n", "<Leader>lco", "<Cmd>Leet open<Cr>", { desc = "open" })
  keymap("n", "<Leader>lcc", "<Cmd>Leet console<Cr>", { desc = "console" })
  keymap("n", "<Leader>lcs", "<Cmd>Leet submit<Cr>", { desc = "submit" })
  keymap("n", "<Leader>lcr", "<Cmd>Cargo test test_case<Cr>", { desc = "rust test" })
end)
