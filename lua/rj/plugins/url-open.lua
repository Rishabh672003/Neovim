local M = {
  "sontungexpt/url-open",
  event = "VeryLazy",
  cmd = "URLOpenUnderCursor",
}

function M.config()
  local status_ok, url_open = pcall(require, "url-open")
  if not status_ok then
    return
  end
  -- default values
  url_open.setup({
    open_app = "default",
    open_only_when_cursor_on_url = false,
    highlight_url = {
      all_urls = {
        enabled = false,
        fg = "#21d5ff", -- "text" or "#rrggbb"
        -- fg = "text", -- text will set underline same color with text
        bg = nil, -- nil or "#rrggbb"
        underline = true,
      },
      cursor_move = {
        enabled = false,
        fg = "#89b4fa", -- "text" or "#rrggbb"
        -- fg = "text", -- text will set underline same color with text
        bg = nil, -- nil or "#rrggbb"
        underline = true,
      },
    },
    deep_pattern = false,
  })
end

return M
