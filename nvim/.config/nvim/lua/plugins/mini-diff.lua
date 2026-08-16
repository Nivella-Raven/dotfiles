vim.pack.add({ "https://github.com/nvim-mini/mini.diff" })

local diff = require("mini.diff")

diff.setup({
	view = {
		style = "sign",
	},
})

vim.keymap.set("n", "<Leader>go", function()
	diff.toggle_overlay()
end, {
	desc = "Toggle diff overlay",
})
