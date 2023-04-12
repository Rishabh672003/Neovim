local M = {
	"ethanholz/nvim-lastplace",
	event = "VimEnter",
}

function M.config()
	require("nvim-lastplace").setup({
		lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
		lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
		lastplace_open_folds = true,
	})
end

return M
