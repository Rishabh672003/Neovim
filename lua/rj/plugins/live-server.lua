local M = {
	"barrett-ruth/live-server.nvim",
	ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css" },
	build = "yarn global add live-server",
	config = true,
}

function M.config()
	require("live-server").setup()
end

return M
