vim.pack.add({
	"https://github.com/nvim-mini/mini.pick",
})

local pick = require("mini.pick")

pick.setup()

local map = vim.keymap.set
local builtin = pick.builtin

map("n", "<Leader>ff", builtin.files, {
	desc = "Find files",
})

map("n", "<Leader>fg", builtin.grep_live, {
	desc = "Live grep",
})

map("n", "<Leader>fb", builtin.buffers, {
	desc = "Find buffers",
})

map("n", "<Leader>fh", builtin.help, {
	desc = "Find help",
})

map("n", "<Leader>fR", builtin.resume, {
	desc = "Resume picker",
})
