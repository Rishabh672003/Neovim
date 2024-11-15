-- credit to: [Biggybi](https://gitlab.com/Biggybi/neovim-config)
local M = {}

function M.wrap_symbol()
  local is_first_of_group = vim.v.virtnum == 0
  if is_first_of_group then
    return vim.v.lnum and vim.v.lnum .. " " or ""
  end

  local line_length = vim.fn.virtcol({ vim.v.lnum, "$" })
  local text_line_width = vim.fn.winwidth(0) - vim.fn.getwininfo(vim.api.nvim_get_current_win())[1].tex
  local is_last_of_group = text_line_width * (vim.v.virtnum + 1) >= line_length

  if is_last_of_group then
    return "└ "
  end
  return "├ "
end

function M.setup_statuscolumn()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("BestStatusColumn", { clear = true }),
    pattern = "*",
    callback = function()
      local buftype, filetype = vim.bo.buftype, vim.bo.filetype
      if
        buftype == ""
        and not vim.tbl_contains({ "terminal", "nofile" }, buftype)
        and not vim.tbl_contains({ "dashboard", "mason", "toggleterm" }, filetype)
      then
        vim.wo.statuscolumn = "%s%=%{v:lua.require('rj.extras.statuscolumn').wrap_symbol()}"
      elseif not vim.wo.number and not vim.wo.relativenumber then
        vim.wo.statuscolumn = "%s"
      else
        vim.wo.statuscolumn = ""
      end
    end,
  })
end

return M
