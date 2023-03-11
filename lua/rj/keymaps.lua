local opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

keymap("i", "<C-a>", "<ESC>:0,$y<CR>a", opts)
keymap("n", "<C-a>", ":0,$y<CR>", opts)

keymap("n", "d3", "ddO", opts)

-- vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)
-- vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
--keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)

--keymaps for toggleterm
keymap("n", "<M-1>", "<cmd>ToggleTerm direction=horizontal size=12<cr>", opts)
keymap("t", "<M-1>", "<cmd>ToggleTerm direction=horizontal size=12<cr>", opts)
keymap("n", "<M-2>", "<cmd>ToggleTerm direction=vertical size=50<cr>", opts)
keymap("t", "<M-2>", "<cmd>ToggleTerm direction=vertical size=50<cr>", opts)
keymap("n", "<M-3>", "<cmd>ToggleTerm direction=float<cr>", opts)
keymap("t", "<M-3>", "<cmd>ToggleTerm direction=float<cr>", opts)

keymap("t", "NOP", "<Esc>", opts)
-- keymap("t", "", "", {})

--keymap-bufferline
-- keymap("n", "<TAB>", ":bnext<CR>", opts )
-- keymap("n", "<C-TAB>", ":BufferLineCyclePrev <CR>", opts )

--keymaps for tabs
keymap("n", "<M-h>", ":tabNext<CR>", opts)
keymap("n", "<M-l>", ":tabprevious<CR>", opts)
-- keymap("n", "<A-i>", ":tabnew<CR>", opts)
-- keymap("n", "<leader>j", ":Jaq<CR>", opts)
-- keymap("n", "<leader>q", ":q!<CR>", opts)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

-- keymap("i", "<C-i>", "<cmd>PickIconsInsert<cr>", opts)
-- keymap("i", "<A-i>", "<cmd>PickAltFontAndSymbolsInsert<cr>", opts)

-- keymap('n', '<C-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
-- keymap('n', '<C-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
