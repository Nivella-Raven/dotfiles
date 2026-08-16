vim.pack.add({ "https://github.com/nvim-mini/mini.clue" })

local clue = require("mini.clue")

local ai_objects = {
	{ key = "a", desc = "Argument" },
	{ key = "b", desc = "Brackets" },
	{ key = "f", desc = "Function call" },
	{ key = "q", desc = "Quote" },
	{ key = "t", desc = "Tag" },
	{ key = "?", desc = "Prompt textobject" },
}

local ai_prefixes = {
	{ keys = "a", desc = "Around" },
	{ keys = "an", desc = "+Next" },
	{ keys = "al", desc = "+Previous" },
	{ keys = "i", desc = "Inside" },
	{ keys = "in", desc = "+Next" },
	{ keys = "il", desc = "+Previous" },
}

local function gen_ai_clues()
	local result = {}

	for _, prefix in ipairs(ai_prefixes) do
		if #prefix.keys > 1 then
			table.insert(result, {
				mode = { "x", "o" },
				keys = prefix.keys,
				desc = prefix.desc,
			})
		end

		for _, object in ipairs(ai_objects) do
			table.insert(result, {
				mode = { "x", "o" },
				keys = prefix.keys .. object.key,
				desc = object.desc,
			})
		end
	end

	return result
end

clue.setup({
	triggers = {
		{ mode = { "n", "x" }, keys = "<Leader>" },
		{ mode = { "x", "o" }, keys = "a" },
		{ mode = { "x", "o" }, keys = "i" },
		{ mode = { "n", "x" }, keys = "s" },
		{ mode = { "n", "x" }, keys = "g" },
		{ mode = { "n", "x" }, keys = "z" },
		{ mode = "n", keys = "<C-w>" },
		{ mode = "n", keys = "[" },
		{ mode = "n", keys = "]" },
		{ mode = { "n", "x" }, keys = "'" },
		{ mode = { "n", "x" }, keys = "`" },
		{ mode = { "n", "x" }, keys = '"' },
		{ mode = { "i", "c" }, keys = "<C-r>" },
	},

	clues = {
		{ mode = "n", keys = "<Leader>f", desc = "+Find" },
		{ mode = "n", keys = "<Leader>b", desc = "+Buffer" },
		{ mode = "n", keys = "<Leader>g", desc = "+Git" },
		{ mode = { "n", "x" }, keys = "<Leader>c", desc = "+Code" },
		gen_ai_clues(),
		clue.gen_clues.square_brackets(),
		clue.gen_clues.g(),
		clue.gen_clues.windows(),
		clue.gen_clues.z(),
		clue.gen_clues.marks(),
		clue.gen_clues.registers(),
		{ mode = { "x", "o" }, keys = "ii", desc = "Indent scope" },
		{ mode = { "x", "o" }, keys = "ai", desc = "Indent scope with border" },
		{ mode = "n", keys = "[i", desc = "Indent scope top" },
		{ mode = "n", keys = "]i", desc = "Indent scope bottom" },
	},

	window = {
		delay = 300,
	},
})
