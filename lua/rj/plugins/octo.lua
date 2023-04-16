local M = {
	"pwntester/octo.nvim",
	event = "BufReadPre",
}

function M.config()
	require("octo").setup()
end

return M
