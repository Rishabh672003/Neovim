local M = {
	"pwntester/octo.nvim",
	enabled = false,
	-- event = "BufReadPost",
}

function M.config()
	require("octo").setup()
end

return M
