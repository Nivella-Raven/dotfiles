vim.pack.add({
	"https://github.com/nvim-mini/mini.files",
})

local files = require("mini.files")

files.setup({
	options = {
		permanent_delete = false,
	},
})

vim.keymap.set("n", "<Leader>e", function()
	if files.close() then
		return
	end

	local path = vim.api.nvim_buf_get_name(0)

	if path == "" or vim.uv.fs_stat(path) == nil then
		path = vim.fn.getcwd()
	end

	files.open(path)
end, {
	desc = "File explorer",
})
