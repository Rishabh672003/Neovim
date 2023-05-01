local M = {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	branch = "v2.x",
	event = "BufRead",
	enabled = false,
	keys = {
		{ "<C-\\>", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
	},
}

function M.config()
	require("neo-tree").setup({
		popup_border_style = "rounded",
		window = {
			position = "right",
			width = 40,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
		},
		filesystem = {
			follow_current_file = true,
			hijack_netrw_behavior = "open_current",
		},
	})
end

return M
