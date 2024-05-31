local M = {}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

local function attach_navic(client, bufnr)
  vim.g.navic_silence = true
  local navic = require("nvim-navic")
  navic.attach(client, bufnr)
end

local function lsp_keymaps()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = true }
  keymap("n", "gD", "<cmd>Telescope lsp_document_symbols<CR>", opts)
  keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
  keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
  keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap("n", "<C-n>", "<cmd>ClangdSwitchSourceHeader<CR>", opts)
  keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  keymap("n", "gR", '<cmd>lua require("trouble").toggle("lsp_references")<CR>', opts)
  keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap("n", "<leader>Q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  attach_navic(client, bufnr)
  lsp_keymaps()
  if vim.bo.filetype ~= "rust" then
    vim.lsp.inlay_hint.enable()
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
