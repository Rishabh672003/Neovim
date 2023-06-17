return {
	{
		"zbirenbaum/copilot-cmp",
		-- after = { "copilot.lua" },
		enabled = false,
		config = function()
			require("copilot_cmp").setup({
				formatters = {
					insert_text = require("copilot_cmp.format").remove_existing,
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		enabled = false,
		cmd = "Copilot",
		config = function()
			require("copilot").setup({})
		end,
	},
}
