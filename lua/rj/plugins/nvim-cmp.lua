local M = {
	"hrsh7th/nvim-cmp",
	event = {
		"InsertEnter",
		"CmdlineEnter",
	},
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lua",
		{
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		{
			"jcdickinson/codeium.nvim",
			enabled = false,
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			config = function()
				require("codeium").setup({})
			end,
		},
		{
			"roobert/tailwindcss-colorizer-cmp.nvim",
			-- optionally, override the default options:
			config = function()
				require("tailwindcss-colorizer-cmp").setup({
					color_square_width = 2,
				})
			end,
		},
	},
}

function M.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	local _, cmp_clangd = pcall(require, "clangd_extensions.cmp_scores")
	if not _ then
		return
	end

	-- local status_ok, copilot_cmp = pcall(require, "copilot_cmp.comparators")
	-- if not status_ok then
	--   return
	-- end

	require("luasnip/loaders/from_vscode").lazy_load()

	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	-- 󰃐 󰆩 󰙅 󰛡  󰅲 some other gogin for getting the float window for hovers etcod icons
	local kind_icons = {
		Text = "󰉿",
		Method = "m",
		Function = "󰊕",
		Constructor = "",
		Field = "",
		Variable = "󰆧",
		Class = "󰌗",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "󰎠",
		Enum = "",
		Keyword = "󰌋",
		Snippet = "",
		Color = "󰏘",
		File = "󰈙",
		Reference = "",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰇽",
		Struct = "",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "󰊄",
		Codeium = "󰚩",
		Copilot = "",
	}
	-- find more here: https://www.nerdfonts.com/cheat-sheet
	cmp.setup({
		enabled = function()
			return vim.g.cmp_toggle
		end,
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		sorting = {
			comparators = {
				cmp.config.compare.exact,
				-- copilot_cmp.prioritize,
				-- copilot_cmp.score,
				cmp_clangd,
			},
		},
		mapping = {
			--my-keymappings
			["<Up>"] = cmp.mapping.select_prev_item(),
			["<Down>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-y>"] = cmp.config.disable,
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				-- Kind icons
				vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
				-- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					nvim_lua = "[NVLUA]",
					luasnip = "[SNPT]",
					buffer = "[BFR]",
					path = "[PATH]",
					copilot = "[CPLT]",
					codeium = "[CDEM]",
				})[entry.source.name]

				return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
				-- return vim_item
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "copilot" },
			{ name = "codeium" },
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			documentation = {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			},
		},
		experimental = {
			-- ghost_text = true,
		},
	})
end

return M
