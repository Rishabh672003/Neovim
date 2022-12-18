local status_ok, barbecue = pcall(require, "barbecue")
if not status_ok then
	return
end

vim.api.nvim_set_hl(0, "NavicSeparator", { link = "Normal" })

barbecue.setup({
	---whether to create winbar updater autocmd
	---@type boolean
	create_autocmd = true,

	---buftypes to enable winbar in
	---@type table
	include_buftypes = { "" },

	exclude_filetypes = { "toggleterm", "Jaq", "alpha" },

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

	---icons for different context entry kinds
	kinds = {
		---@type string
		File = "",

		---@type string
		Package = "",

		---@type string
		Module = "",

		---@type string
		Namespace = "",

		---@type string
		Class = "",

		---@type string
		Constructor = "",

		---@type string
		Field = "",

		---@type string
		Property = "",

		---@type string
		Method = "",

		---@type string
		Struct = "",

		---@type string
		Event = "",

		---@type string
		Interface = "",

		---@type string
		Enum = "",

		---@type string
		EnumMember = "",

		---@type string
		Constant = "",

		---@type string
		Function = "",

		---@type string
		TypeParameter = "",

		---@type string
		Variable = "",

		---@type string
		Operator = "",

		---@type string
		Null = "",

		---@type string
		Boolean = "",

		---@type string
		Number = "",

		---@type string
		String = "",

		---@type string
		Key = "",

		---@type string
		Array = "",

		---@type string
		Object = "",
	},
})
