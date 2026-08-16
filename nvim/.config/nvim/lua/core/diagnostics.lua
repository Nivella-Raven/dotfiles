vim.diagnostic.config({
	severity_sort = true,

	virtual_text = {
		current_line = true,
		spacing = 2,
		source = "if_many",
	},

	float = {
		border = "rounded",
		source = "if_many",
	},
})
