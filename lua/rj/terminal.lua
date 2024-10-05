-- Term Toggle Function
local term_buf = nil
local term_win = nil

function TermToggle(width, cmd)
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.cmd("hide")
  else
    vim.cmd("vertical new")
    local new_buf = vim.api.nvim_get_current_buf()
    vim.cmd("vertical resize " .. width)
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
      vim.cmd("buffer " .. term_buf)
      vim.cmd("bd " .. new_buf)
    else
      if not cmd then
        vim.cmd("silent terminal")
      else
        vim.cmd("silent terminal " .. cmd)
      end
      term_buf = vim.api.nvim_get_current_buf()
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.wo.signcolumn = "no"
    end
    vim.cmd("startinsert!")
    term_win = vim.api.nvim_get_current_win()
  end
end

-- Term Toggle Keymaps
vim.keymap.set("n", "<A-t>", function()TermToggle(80)end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-g>", ':lua TermToggle(80, "lazygit")<CR>', { noremap = true, silent = true })
vim.keymap.set("t", "<A-t>", "<C-\\><C-n>:lua TermToggle(80)<CR>", { noremap = true, silent = true })
