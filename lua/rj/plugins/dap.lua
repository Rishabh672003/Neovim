local dap = require("dap")

local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		-- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
		command = "codelldb",
		args = { "--port", "${port}" },

		-- On windows you may have to uncomment this:
		-- detached = false,
	},
}
dap.configurations.c = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			local path
			vim.ui.input({ prompt = "Path to executable: ", default = vim.loop.cwd() .. "/build/" }, function(input)
				path = input
			end)
			vim.cmd([[redraw]])
			return path
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}
