local M = {}

function M.setup()
	-- vim.g.nord_enable_sidebar_background = true
	vim.g.nord_borders = true
	vim.g.nord_contrast = true
	require("nord").set()
end

return M
