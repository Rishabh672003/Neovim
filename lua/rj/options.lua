local options = {
  backup = false, -- creates a backup file
  -- clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 0, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 350, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  numberwidth = 2, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 8, -- is one of my fav
  guifont = "JetBrainsMono NF:h14", -- the font used in graphical neovim applications
  sidescrolloff = 8, -- the number of lines to keep visible at the top and bottom of the screen
  laststatus = 0, -- controls how the command line looks when there is no message to display
  virtualedit = "onemore", -- allows the cursor to move beyond the end of a line
  linebreak = true, -- determines whether text will wrap at the edge of the screen
  showtabline = 1, -- determines whether the tab line will be displayed
  spelllang = "en_us", -- sets the language for spell checking
  textwidth = 80, -- limits the width of text that is being inserted
  foldexpr = "v:lua.vim.treesitter.foldexpr()", -- specifies the expression used to calculate folds
  foldtext = "v:lua.vim.treesitter.foldtext()", -- specifies the function used to generate the text displayed for a closed fold
  indentexpr = "nvim_treesitter#indent()", -- specifies the function used to calculate the indentation level
  fillchars = { eob = " " }, -- defines the characters used for certain parts of the screen
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.iskeyword:append("-")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.splitkeep = "screen"
vim.opt.diffopt:append("linematch:60")
vim.opt.shortmess:append({ C = true })
vim.opt.cinkeys:remove(":")
vim.opt.indentkeys:remove(":")
vim.g.c_syntax_for_h = true
