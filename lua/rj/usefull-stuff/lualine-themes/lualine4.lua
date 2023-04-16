require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		disabled_filetypes = { -- "alpha", "dashboard"
			statusline = { "alpha", "dashboard" }, -- "toggleterm"},
			-- winbar = {"alpha", "dashboard"}
		},
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
		-- section_separators = { left = "", right = "" },
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"buffers",
				show_filename_only = true, -- Shows shortened relative path when set to false.
				hide_filename_extension = false, -- Hide filename extension when set to true.
				show_modified_status = true, -- Shows indicator when the buffer is modified.

				mode = 2,

				max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,

				filetype_names = {
					TelescopePrompt = "Telescope",
					daohboard = "Dashboard",
					packer = "Packer",
					fzf = "FZF",
					alpha = "Alpha",
				},

				buffers_color = {
					-- active = "lualine_d_normal", -- Color for active buffer.
					inactive = "lualine_d_inactive", -- Color for inactive buffer.
				},
				symbols = {
					modified = " ●", -- Text to show when the buffer is modified
					alternate_file = "", -- Text to show to identify the alternate file
					directory = "", -- Text to show when the buffer is a directory
				},
			},
		},
		lualine_x = { "encoding", "", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
