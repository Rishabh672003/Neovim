local opts = { silent = true }

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
end, opts)
keymap("n", "<Leader>q", "<Cmd>q!<CR>", opts)
keymap("n", "<Leader>c", "<Cmd>bd!<CR>", opts)

keymap("n", "\\", "<Cmd>noh<CR>", opts)

keymap("n", "[n", "<Cmd>cnext<CR>", opts)
keymap("n", "[p", "<Cmd>cprevious<CR>", opts)

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

-- Quality of Life stuff --
keymap({ "n", "s", "v" }, "<Leader>yy", '"+y', { desc = "Yank to clipboard" })
keymap({ "n", "s", "v" }, "<Leader>yY", '"+yy', { desc = "Yank line to clipboard" })
keymap({ "n", "s", "v" }, "<Leader>yp", '"+p', { desc = "Paste from clipboard" })
keymap("n", "<Leader>va", "<Cmd>norm! mmggVG<CR>", opts)
keymap("n", "<Leader>vs", "<Cmd>%y<CR>", opts)
keymap("n", "<Leader>vx", "<Cmd>norm! ggVGx<CR>", opts)

keymap("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true, desc = "properly indent on empty line when insert" })

keymap("n", "<Leader>sw", function ()
  require("rj.extras.sudo-write").write()
end, opts)
