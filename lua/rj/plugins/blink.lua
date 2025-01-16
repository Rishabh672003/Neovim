---@diagnostic disable: missing-fields
Later(function()
  Add({
    source = "saghen/blink.cmp",
    depends = {
      "rafamadriz/friendly-snippets",
    },
    checkout = "v0.10.0",
  })

  require("blink.cmp").setup({
    keymap = {
      preset = "default",
      cmdline = {
        preset = "default",
        ["<Tab>"] = {
          function(cmp)
            if not cmp.is_visible() then
              cmp.show()
            end
            return cmp.select_next()
          end,
        },
        ["<S-Tab>"] = {
          function(cmp)
            if not cmp.is_visible() then
              cmp.show()
            end
            return cmp.select_prev()
          end,
        },
      },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "normal",
    },

    completion = {
      list = {
        selection = {
          preselect = function(ctx)
            return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
          end,
          auto_insert = function(ctx)
            return ctx.mode == "cmdline"
          end,
        },
      },
      trigger = {
        prefetch_on_insert = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 150,
      },
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      cmdline = function()
        local type = vim.fn.getcmdtype()
        if type == ":" then
          return { "cmdline" }
        end
        return {}
      end,
    },
    signature = { enabled = false },
  })

  local capabilities = require("blink.cmp").get_lsp_capabilities()
  vim.lsp.config("*", { capabilities = capabilities })
end)
