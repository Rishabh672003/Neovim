local status_ok, barbecue = pcall(require, "barbecue")
if not status_ok then
	return
end

vim.api.nvim_set_hl(0, "NavicSeparator", { link = "Normal" })

barbecue.setup({
	---whether to create winbar updater autocmd
	---@type boolean
	create_autocmd = false,

	---buftypes to enable winbar in
	---@type table
	include_buftypes = { "" },

	---returns a string to be shown at the end of winbar
	-- param bufnr number
	---@return string
	-- custom_section = function(bufnr)
	--   return ""
	-- end,

	---:help filename-modifiers
	modifiers = {
		---@type string
		-- dirname = ":s?.*??",
		dirname = ":~:.",

		---@type string
		basename = "",
	},

	symbols = {
		---string to be shown at the start of winbar
		---@type string
		prefix = " ",

		---entry separator
		---@type string
		separator = require("user.icons").ui.ChevronRight,

		---string to be shown when buffer is modified
		---@type string
		modified = require("user.icons").ui.BigCircle,

		---string to be shown when context is available but empty
		---@type string
		default_context = "",
	},

	show_modified = true,

	---icons for different context entry kinds
	kinds = {
		Array = "",
		Boolean = "蘒",
		Class = "",
		Color = "",
		Constant = "",
		Constructor = "",
		Enum = "",
		EnumMember = "",
		Event = "",
		Field = "",
		File = "",
		Folder = "",
		Function = "",
		Interface = "",
		Key = "",
		Keyword = "",
		Method = "",
		Module = "",
		Namespace = "",
		Null = "ﳠ",
		Number = "",
		Object = "",
		Operator = "",
		Package = "",
		Property = "",
		Reference = "",
		Snippet = "",
		String = "",
		Struct = "",
		Text = "",
		TypeParameter = "",
		Unit = "",
		Value = "",
		Variable = "",
	},
})

vim.api.nvim_create_autocmd({
	"WinScrolled",
	"BufWinEnter",
	"CursorHold",
	"InsertLeave",

	-- include these if you have set `show_modified` to `true`
	"BufWritePost",
	"TextChanged",
	"TextChangedI",
}, {
	group = vim.api.nvim_create_augroup("barbecue", {}),
	callback = function()
		require("barbecue.ui").update()
	end,
})
