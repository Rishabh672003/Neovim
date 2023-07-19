local M = {
	"okuuva/auto-save.nvim",
	-- cmd = "ASToggle", -- optional for lazy loading on command
	event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
	opts = {
		-- your config goes here
		-- or just leave it empty :)
		enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
		execution_message = {
			enabled = false,
			message = function() -- message to print on save
				return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
			end,
			dim = 0.18, -- dim the color of `message`
			cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
		},
		trigger_events = { -- See :h events
			immediate_save = { "BufLeave", "FocusLost" }, -- vim events that trigger an immediate save
			defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
			cancel_defered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
		},
		-- function that takes the buffer handle and determines whether to save the current buffer or not
		-- return true: if buffer is ok to be saved
		-- return false: if it's not ok to be saved
		-- if set to `nil` then no specific condition is applied
		condition = nil,
		write_all_buffers = false, -- write all buffers when the current one meets `condition`
		debounce_delay = 1000, -- delay after which a pending save is executed
		-- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
		debug = false,
	},
}

return M
