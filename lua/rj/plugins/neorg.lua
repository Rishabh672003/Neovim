local M = {
	"nvim-neorg/neorg",
	ft = "norg",
	cmd = "Neorg",
	build = ":Neorg sync-parsers",
	opts = {
		load = {
			["core.defaults"] = {}, -- Loads default behaviour
			["core.export"] = {},
			["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
			["core.norg.dirman"] = { -- Manages Neorg workspaces
				config = {
					workspaces = {
						notes = "~/notes",
					},
				},
			},
		},
	},
	dependencies = { { "nvim-lua/plenary.nvim" } },
}

return M
