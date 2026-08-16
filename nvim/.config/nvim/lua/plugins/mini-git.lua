vim.pack.add({ "https://github.com/nvim-mini/mini-git" })

local git = require("mini.git")

git.setup()

local map = vim.keymap.set

map("n", "<Leader>gg", "<Cmd>Git status<CR>", {
	desc = "Git status",
})

map("n", "<Leader>gl", "<Cmd>Git log --oneline --decorate --graph<CR>", {
	desc = "Git log",
})

map("n", "<Leader>gc", "<Cmd>Git commit<CR>", {
	desc = "Git commit",
})

map("n", "<Leader>gd", "<Cmd>Git diff -- %<CR>", {
	desc = "Diff current file",
})

map("n", "<Leader>gD", "<Cmd>Git diff<CR>", {
	desc = "Diff repository",
})

map("n", "<Leader>ga", "<Cmd>Git diff --cached -- %<CR>", {
	desc = "Staged diff current file",
})

map("n", "<Leader>gA", "<Cmd>Git diff --cached<CR>", {
	desc = "Staged diff repository",
})

map("n", "<Leader>gu", "<Cmd>Git restore --staged -- %<CR>", {
	desc = "Unstage current file",
})

map({ "n", "x" }, "<Leader>gs", function()
	git.show_at_cursor()
end, {
	desc = "Show Git at cursor",
})
