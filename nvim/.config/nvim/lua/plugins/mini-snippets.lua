vim.pack.add({
	"https://github.com/nvim-mini/mini.snippets",
})

local snippets = require("mini.snippets")

snippets.setup({
	snippets = {
		snippets.gen_loader.from_lang({
			lang_patterns = {
				markdown_inline = {
					"markdown.json",
				},
			},
		}),
	},
})

snippets.start_lsp_server({
	match = false,
})
