local _, nvim_lastplace = pcall(require, "nvim-lastplace")
if not _ then
	return
end

nvim_lastplace.setup({
	lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
	lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
	lastplace_open_folds = true,
})
