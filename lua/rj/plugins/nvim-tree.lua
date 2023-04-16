local M = {
	"kyazdani42/nvim-tree.lua",
	cmd = "NvimTreeToggle",
	tag = "nightly",
}

function M.config()
	local tree_cb = require("nvim-tree.config").nvim_tree_callback

	require("nvim-tree").setup({
		disable_netrw = true,
		hijack_netrw = true,
		renderer = {
			group_empty = true,
			icons = {
				webdev_colors = true,
				glyphs = {
					default = "",
					symlink = "",
					folder = {
						arrow_closed = "",
						arrow_open = "",
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
						symlink_open = "",
					},
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						untracked = "★",
						deleted = "",
						ignored = "◌",
					},
				},
			},
		},
		open_on_tab = false,
		hijack_cursor = false,
		update_cwd = true,
		diagnostics = {
			enable = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			update_cwd = true,
			ignore_list = {},
		},
		git = {
			enable = true,
			ignore = true,
			timeout = 500,
		},
		view = {
			width = 25,
			hide_root_folder = false,
			side = "left",
			mappings = {
				custom_only = false,
				list = {
					{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
					{ key = "h", cb = tree_cb("close_node") },
					{ key = "v", cb = tree_cb("vsplit") },
				},
			},
			number = false,
			relativenumber = false,
		},
	})
end

return M
