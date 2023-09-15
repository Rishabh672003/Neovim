local M = {}

local function attach_navic(client, bufnr)
  vim.g.navic_silence = true
  local navic = require("nvim-navic")
  navic.attach(client, bufnr)
end

local function lsp_keymaps(bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true }
  keymap(bufnr, "n", "gD", "<cmd>Telescope lsp_declarations<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
  keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<leader>Q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  attach_navic(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

--this enables an option to format code when you save them
function M.enable_format_on_save()
  vim.cmd([[
    augroup format_on_save
      autocmd! 
      autocmd BufWritePre * lua vim.lsp.buf.format({ async = true }) 
    augroup end
  ]])
  vim.notify("Enabled format on save")
end

function M.disable_format_on_save()
  M.remove_augroup("format_on_save")
  vim.notify("Disabled format on save")
end

function M.toggle_format_on_save()
  if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
  end
end

vim.api.nvim_create_user_command("LspToggleAutoFormat", function()
  require("rj.lsp.attach").toggle_format_on_save()
end, {})
return M
