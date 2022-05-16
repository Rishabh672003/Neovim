local colorizer_status_ok, colorizer = pcall(require, "colorizer")
if not colorizer_status_ok then
  return
end
require "colorizer".setup()
