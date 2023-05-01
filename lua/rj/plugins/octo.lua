local M = {
	"pwntester/octo.nvim",
	enabled = true,
	-- event = "BufReadPost",
}

function M.config()
	require("octo").setup()
end

return M
