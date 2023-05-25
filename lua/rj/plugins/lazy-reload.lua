return {
	"MaximilianLloyd/lazy-reload.nvim",
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
	keys = {
		-- Opens the command.
		{ "<leader>v", "<cmd>lua require('lazy-reload').feed()<cr>", desc = "Reload a plugin" },
	},
}
