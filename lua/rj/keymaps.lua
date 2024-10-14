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

keymap("n", "<leader>w", function() vim.cmd("silent! write!") vim.notify("File saved") end, opts)
keymap("n", "<leader>q", "<cmd>q!<cr>", opts)
keymap("n", "<leader>c", "<cmd>bd!<cr>", opts)

keymap("n", "\\", "<cmd>noh<cr>", opts)

keymap("n", "[n", "<cmd>cnext<cr>", opts)
keymap("n", "[p", "<cmd>cprevious<cr>", opts)

keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

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
keymap("n", "dc", "^dg_", opts)

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
keymap({ "n", "s", "v" }, "<leader>yy", '"+y', { desc = "Yank to clipboard" })
keymap({ "n", "s", "v" }, "<leader>yY", '"+yy', { desc = "Yank line to clipboard" })
keymap({ "n", "s", "v" }, "<leader>yp", '"+p', { desc = "Paste from clipboard" })
keymap('n', '<leader>va', '<cmd>norm! mmggVG<cr>', opts)
keymap('n', '<leader>vs', '<cmd>%y<cr>', opts)
keymap('n', '<leader>vx', '<cmd>norm! ggVGx<cr>', opts)

vim.cmd([[
" Using arrow keys is far too ingrained in my muscle memory.
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
]])

keymap("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true, desc = "properly indent on empty line when insert" })
