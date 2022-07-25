return {
  -- cmd = { "pyright" },
  -- root_dir = "util.find_git_ancestor",
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        -- diagnosticMode = "workspace",
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
        },
      },
    },
  },
}

