vim.pack.add({ "https://github.com/nvim-mini/mini.indentscope" })

local indentscope = require("mini.indentscope")

indentscope.setup({
	draw = {
		animation = indentscope.gen_animation.none(),
		delay = 0,
	},
	options = {
		try_as_border = true,
	},
	symbol = "│",
})

local disable_group = vim.api.nvim_create_augroup("mini-indentscope-disable", {
	clear = true,
})

vim.api.nvim_create_autocmd("FileType", {
	group = disable_group,
	pattern = {
		"help",
		"minifiles",
		"minipick",
		"ministarter",
		"qf",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})
