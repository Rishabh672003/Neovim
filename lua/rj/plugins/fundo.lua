local M = {
  "kevinhwang91/nvim-fundo",
  dependencies = "kevinhwang91/promise-async",
  event = { "InsertEnter", "BufReadPre", "BufAdd", "BufNew" },
  build = function()
    require("fundo").install()
  end,
}

function M.config()
  require("fundo").setup()
end

return M
