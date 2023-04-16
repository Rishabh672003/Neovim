local M = {
	"Xuyuanp/neochat.nvim",
	event = { "InsertEnter", "BufReadPre", "BufAdd", "BufNew" },
	build = function()
		vim.fn.system({ "pip", "install", "-U", "openai" })
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}

function M.config()
	require("neochat").setup({})
end

return M
