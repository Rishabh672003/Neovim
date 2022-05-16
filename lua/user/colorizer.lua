local colorizer_status_ok, colorizer = pcall(require, "colorizer.setup()")
if not colorizer_status_ok then
  return
end
