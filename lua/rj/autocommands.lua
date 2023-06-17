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

vim.cmd([[
autocmd FileType TelescopePrompt lua require'cmp'.setup.buffer {
\   completion = { autocomplete = false }
\ }
]])

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function(data)
		-- buffer is a directory
		local directory = vim.fn.isdirectory(data.file) == 1

		if not directory then
			return
		end

		-- change to the directory
		vim.cmd.cd(data.file)

		-- open the tree
		require("nvim-tree.api").tree.open()
	end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

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

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		local line_count = vim.api.nvim_buf_line_count(0)
		if line_count >= 10000 then
			vim.cmd("IlluminatePauseBuf")
		end
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "neo-tree" },
	callback = function()
		vim.opt_local.number = false
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = "*.pdf",
	callback = function(ev)
		local filename = ev.file
		vim.fn.jobstart({ "xdg-open", filename }, { detach = true })
		vim.api.nvim_buf_delete(0, {})
	end,
})
