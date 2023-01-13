local _, scheme = pcall(require, "schemastore")
if not _ then
  return
end

return {
  settings = {
    json = {
      schemas = scheme.json.schemas(),
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
        end,
      },
    },
  },
}
