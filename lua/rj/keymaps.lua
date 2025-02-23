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

-- stylua: ignore start
local term = require("rj.extras.terminal")

keymap("t", "<C-q>", [[<C-\><C-n>]], opt("Escape in terminal window"))
keymap({ "n", "t" }, "<A-t>", function() term:new({ execn = "zsh", name = "Shell" }):toggle() end, opt("Open Shell"))
keymap({ "n", "t" }, "<A-T>", function() term:new({ execn = "zsh", name = "Shell2" }):toggle() end, opt("Open Shell"))
keymap({ "n", "t" }, "<A-g>", function() term:new({ execn = "lazygit",name = "Lazygit" }):toggle() end, opt("Open Lazygit"))
keymap({ "n", "t" }, "<A-b>", function() term:new({ execn = "btop", name = "Btop" }):toggle() end, opt("Open Btop"))
keymap({ "n", "t" }, "<A-p>", function() term:new({ execn = "python", name = "Python" }):toggle() end, opt("Open Python"))
keymap("n", "<Leader>gg", function() term:new({ name = "Lazygit",execn = "lazygit" }):toggle() end, opt("Lazygit"))
-- stylua:ignore end

-- Quality of Life stuff --
keymap({ "n", "s", "v" }, "<Leader>yy", '"+y', opt("Yank to clipboard"))
keymap({ "n", "s", "v" }, "<Leader>yY", '"+yy', opt("Yank line to clipboard"))
keymap({ "n", "s", "v" }, "<Leader>yp", '"+p', opt("Paste from clipboard"))
keymap({ "n", "s", "v" }, "<Leader>yd", '"+d', opt("Delete into clipboard"))

keymap("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true, desc = "properly indent on empty line when insert" })

keymap("n", "<C-S-s>", function()
  require("rj.extras.sudo-write").write()
end, opt("Write File with sudo"))

keymap("n", "<Leader>x", "<Cmd>so %<CR>", opt("Source the current file"))
