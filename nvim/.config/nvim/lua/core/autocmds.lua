local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general_group = augroup("raven-general", {
	clear = true,
})

autocmd("TextYankPost", {
	group = general_group,
	callback = function()
		vim.hl.on_yank()
	end,
})

autocmd({
	"FocusGained",
	"BufEnter",
	"CursorHold",
}, {
	group = general_group,
	callback = function()
		vim.cmd("checktime")
	end,
})
