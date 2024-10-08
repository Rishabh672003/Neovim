local opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "\\", "<cmd>noh<cr>", opts)

keymap("n", "[n", "<cmd>cnext<cr>", opts)
keymap("n", "[p", "<cmd>cprevious<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)

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

--keymaps for toggleterm
keymap("n", "<C-1>", "<cmd>ToggleTerm direction=horizontal size=12<cr>", opts)
keymap("t", "<C-1>", "<cmd>ToggleTerm direction=horizontal size=12<cr>", opts)
keymap("n", "<C-2>", "<cmd>ToggleTerm direction=vertical size=50<cr>", opts)
keymap("t", "<C-2>", "<cmd>ToggleTerm direction=vertical size=50<cr>", opts)
keymap("n", "<C-3>", "<cmd>ToggleTerm direction=float<cr>", opts)
keymap("t", "<C-3>", "<cmd>ToggleTerm direction=float<cr>", opts)

--keymaps for tabs
keymap("n", "<M-l>", "<cmd>tabnext<CR>", opts)
keymap("n", "<M-h>", "<cmd>tabprevious<CR>", opts)
keymap("n", "<A-q>", "<cmd>tabclose<CR>", opts)
keymap("n", "<A-i>", "<cmd>tabnew<CR>", opts)

keymap("n", "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory" })

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
