local status_ok, file_browser = pcall(require, "file_browser")
if not status_ok then
	return file_browser
end

require("telescope").load_extension "file_browser"
