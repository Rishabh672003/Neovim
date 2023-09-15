local M = {
  "chrisgrieser/nvim-early-retirement",
  event = { "InsertEnter", "BufReadPre", "BufAdd", "BufNew" },
  opts = {
    retirementAgeMins = 60,
    ignoreAltFile = true,
    notificationOnAutoClose = true,
  },
}

return M
