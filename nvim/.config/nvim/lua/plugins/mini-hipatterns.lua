vim.pack.add({ "https://github.com/nvim-mini/mini.hipatterns" })

local hipatterns = require("mini.hipatterns")

local function word_pattern(word)
	return string.format("%%f[%%w]()%s()%%f[%%W]", word)
end

hipatterns.setup({
	highlighters = {
		fixme = {pattern = word_pattern("FIXME"), group = "MiniHipatternsFixme",},
		hack = {pattern = word_pattern("HACK"), group = "MiniHipatternsHack",},
		todo = {pattern = word_pattern("TODO"), group = "MiniHipatternsTodo",},
		note = {pattern = word_pattern("NOTE"), group = "MiniHipatternsNote",},
		hex_color = hipatterns.gen_highlighter.hex_color({style = "full",}),
	},
})
