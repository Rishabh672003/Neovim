vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")
-- nvim-tree is also there in modified buffers so this function filter it out
local modifiedBufs = function(bufs)
	local t = 0
	for k, v in pairs(bufs) do
		if v.name:match("NvimTree_") == nil then
			t = t + 1
		end
	end
	return t
end

vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if
			#vim.api.nvim_list_wins() == 1
			and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil
			and modifiedBufs(vim.fn.getbufinfo({ bufmodified = 1 })) == 0
		then
			vim.cmd("quit")
		end
	end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
-- 	callback = function()
-- 		vim.cmd("quit")
-- 	end,
-- })

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		vim.lsp.codelens.refresh()
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		vim.cmd("hi link illuminatedWord LspReferenceText")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		local line_count = vim.api.nvim_buf_line_count(0)
		if line_count >= 100000 then
			vim.cmd("IlluminatePauseBuf")
			vim.cmd("Gitsigns detach")
			-- vim.cmd("LspStop")
			-- vim.cmd("set eventignore=all")
		end
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "zsh",
-- 	callback = function()
-- 		-- let treesitter use bash highlight for zsh files as well
-- 		require("nvim-treesitter.highlight").attach(0, "bash")
-- 	end,
-- })

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "*.conf",
	callback = function()
		vim.cmd("set ft=conf")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "*.rasi",
	callback = function()
		vim.cmd("set ft=rasi")
	end,
})
