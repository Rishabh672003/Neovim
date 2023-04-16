local M = {
	"lewis6991/satellite.nvim",
	event = { "InsertEnter", "BufReadPre" },
}

function M.config()
	require("satellite").setup()
end

return M
