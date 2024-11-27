local opts = { silent = true }

local function opt(desc, others)
  return vim.tbl_extend("force", opts, { desc = desc }, others or {})
end

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Shorten function name
local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("n", "<Leader>w", function()
  vim.cmd("silent! write!")
  vim.notify("File saved")
end, opt("Save"))
keymap("n", "<Leader>q", "<Cmd>q!<CR>", opt("Quit"))
keymap("n", "<Leader>c", "<Cmd>bd!<CR>", opt("Close"))

keymap("n", "\\", "<Cmd>noh<CR>", opt("Remove highlight"))

keymap("n", "<C-n>", "<Cmd>silent cnext<CR>", opt("Next QF item"))
keymap("n", "<C-p>", "<Cmd>silent cprevious<CR>", opt("Prev QF item"))

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- pressing C-h,j,k,l will move the cursor in insert mode
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-l>", "<Right>", opts)
keymap("v", "p", "P", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv=gv", opts)
keymap("x", "K", ":move '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv=gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

local term = require("rj.extras.terminal")

-- stylua: ignore start
keymap("t", "<C-q>", [[<C-\><C-n>]], opt("Escape in terminal window"))
keymap({ "n", "t" }, "<A-t>", function() term:new({ execn = "zsh", name = "Shell" }):toggle() end, opt("Open Shell"))
keymap({ "n", "t" }, "<A-g>", function() term:new({ execn = "lazygit",name = "Lazygit" }):toggle() end, opt("Open Lazygit"))
keymap({ "n", "t" }, "<A-b>", function() term:new({ execn = "btop", name = "Btop" }):toggle() end, opt("Open Btop"))
keymap("n", "<Leader>gg", function() term:new({ name = "Lazygit",execn = "lazygit" }):toggle() end, opt("Lazygit"))
keymap("n", "<Leader>tT", "<Cmd>terminal<CR>", opt("Neoterminal"))
keymap({ "n"}, "<A-r>", function()
  term
    :new({ name = "scratch" })
    :run_once(vim.fn.expandcmd(vim.fn.input("Enter the command to execute: ")))
end, opt("Run a command once"))
-- stylua:ignore end



-- Quality of Life stuff --
keymap({ "n", "s", "v" }, "<Leader>yy", '"+y', opt("Yank to clipboard"))
keymap({ "n", "s", "v" }, "<Leader>yY", '"+yy', opt("Yank line to clipboard"))
keymap({ "n", "s", "v" }, "<Leader>yp", '"+p', opt("Paste from clipboard"))
keymap("n", "<Leader>va", "<Cmd>norm! mmggVG<CR>", opt("Select All"))
keymap("n", "<Leader>vs", "<Cmd>%y<CR>", opt("Save All"))
keymap("n", "<Leader>vx", "<Cmd>norm! ggVGx<CR>", opt("Delete All"))

keymap("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true, desc = "properly indent on empty line when insert" })

keymap("n", "<Leader>sw", function()
  require("rj.extras.sudo-write").write()
end, opt("Write File with sudo"))

keymap("i", "<M-i>", function()
  local c = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local indent = line:match("^(%s*)")
  indent = #indent
  vim.v.lnum = c[1]
  local ok, correct_indent = pcall(vim.fn.eval, vim.bo.indentexpr)
  if not ok then
    return
  end

  line = line:gsub("^%s*", (" "):rep(correct_indent))
  vim.api.nvim_buf_set_lines(0, c[1] - 1, c[1], false, { line })
  vim.api.nvim_win_set_cursor(0, { c[1], c[2] + correct_indent - indent })
end)
