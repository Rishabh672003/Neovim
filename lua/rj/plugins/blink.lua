-- use a release tag to download pre-built binaries
Now(function()
  Add({
    source = "saghen/blink.cmp",
    depends = {
      "rafamadriz/friendly-snippets",
    },
    checkout = "v0.3.1", -- check releases for latest tag
  })
  require("blink.cmp").setup()

  -- -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- local function build_blink(params)
  --   vim.notify("Building blink.cmp", vim.log.levels.INFO)
  --   local obj = vim.system({ "cargo", "build", "--release" }, { cwd = params.path }):wait()
  --   if obj.code == 0 then
  --     vim.notify("Building blink.cmp done", vim.log.levels.INFO)
  --   else
  --     vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
  --   end
  -- end

  -- Add({
  --   source = "Saghen/blink.cmp",
  --   hooks = {
  --     post_install = build_blink,
  --     post_checkout = build_blink,
  --   },
  -- })
end)
