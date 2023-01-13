require("zen-mode").setup({
	window = {
		backdrop = 1,
		height = 0.9,
		-- width = 0.5,
		width = 80,
		options = {
			signcolumn = "no",
			number = false,
			relativenumber = false,
			cursorline = true,
			cursorcolumn = false, -- disable cursor column
			-- foldcolumn = "0", -- disable fold column
			-- list = false, -- disable whitespace characters
		},
	},
	plugins = {
		gitsigns = { enabled = false },
		tmux = { enabled = false },
		twilight = { enabled = false },
	},
	on_open = function()
		-- require("lsp-inlayhints").toggle()
		vim.g.cmp_active = false
		vim.cmd([[LspStop]])
		-- vim.opt.sho
	end,
	on_close = function()
		-- require("lsp-inlayhints").toggle()
		vim.g.cmp_active = true
		vim.cmd([[LspStart]])
		-- require("user.winbar").create_winbar()
	end,
})
