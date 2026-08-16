vim.pack.add({
	"https://github.com/nvim-mini/mini.extra",
})

local extra = require("mini.extra")

extra.setup()

local map = vim.keymap.set
local pickers = extra.pickers

map("n", "<Leader>fr", pickers.oldfiles, {
	desc = "Recent files",
})

local function current_file()
	local path = vim.api.nvim_buf_get_name(0)

	if path == "" then
		return nil
	end

	return path
end

map("n", "<Leader>fm", function()
	local path = current_file()

	if path then
		pickers.git_hunks({ path = path })
	end
end, {
	desc = "Find buffer modified hunks",
})

map("n", "<Leader>fM", function()
	pickers.git_hunks()
end, {
	desc = "Find repository modified hunks",
})

map("n", "<Leader>fa", function()
	local path = current_file()

	if path then
		pickers.git_hunks({
			path = path,
			scope = "staged",
		})
	end
end, {
	desc = "Find buffer staged hunks",
})

map("n", "<Leader>fA", function()
	pickers.git_hunks({ scope = "staged" })
end, {
	desc = "Find repository staged hunks",
})

map("n", "<Leader>fc", function()
	local path = current_file()

	if path then
		pickers.git_commits({ path = path })
	end
end, {
	desc = "Find buffer commits",
})

map("n", "<Leader>fC", function()
	pickers.git_commits()
end, {
	desc = "Find repository commits",
})

map("n", "<Leader>fd", function()
	pickers.diagnostic({ scope = "current" })
end, {
	desc = "Find buffer diagnostics",
})

map("n", "<Leader>fD", function()
	pickers.diagnostic({ scope = "all" })
end, {
	desc = "Find all diagnostics",
})

local function lsp_picker(scope)
	return function()
		pickers.lsp({ scope = scope })
	end
end

map("n", "grd", lsp_picker("definition"), {
	desc = "LSP definitions",
})

map("n", "grD", lsp_picker("declaration"), {
	desc = "LSP declarations",
})

map("n", "gri", lsp_picker("implementation"), {
	desc = "LSP implementations",
})

map("n", "grr", lsp_picker("references"), {
	desc = "LSP references",
})

map("n", "grt", lsp_picker("type_definition"), {
	desc = "LSP type definitions",
})

map("n", "gO", lsp_picker("document_symbol"), {
	desc = "LSP document symbols",
})

map("n", "<Leader>fs", lsp_picker("workspace_symbol_live"), {
	desc = "Find workspace symbols",
})
