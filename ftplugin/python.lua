local status_ok, _ = pcall(require, "swenv")
if not status_ok then
  return "Swenv not found"
else
  require("swenv.api").auto_venv()
end

local status, wk = pcall(require, "which-key")
if not status then
  return "Whick-key not found"
end

local keymaps = {
  ["<leader>lpo"] = {
    function()
      local function on_exit(job_id, data, event)
        vim.cmd("e")
        vim.notify("AutoImport completed")
      end

      local function on_output(job_id, data, event) end

      -- Start the job asynchronously
      vim.fn.jobstart("autoimport " .. vim.fn.expand("%"), {
        on_exit = on_exit,
        on_stdout = on_output,
        on_stderr = on_output,
      })
    end,
    "Import Symbol",
  },
  ["<leader>lps"] = {
    function()
      require("swenv.api").pick_venv()
    end,
    "Pick venv",
  },

  ["<leader>lpc"] = {
    function()
      vim.notify(require("swenv.api").get_current_venv().name)
    end,
    "get_current_venv",
  },
}

wk.register(keymaps)
