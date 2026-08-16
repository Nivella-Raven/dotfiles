local map = vim.keymap.set

map("n", "<Esc>", "<Cmd>nohlsearch<CR>", {
	desc = "Clear search highlight",
})

map("n", "<Leader>bd", "<Cmd>bdelete<CR>", {
	desc = "Delete buffer",
})
