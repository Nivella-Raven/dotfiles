local update_group = vim.api.nvim_create_augroup("treesitter-update", {
	clear = true,
})

vim.api.nvim_create_autocmd("PackChanged", {
	group = update_group,
	callback = function(event)
		local data = event.data

		if not data or data.spec.name ~= "nvim-treesitter" or data.kind ~= "update" then
			return
		end

		if vim.fn.executable("tree-sitter") ~= 1 then
			vim.notify(
				"nvim-treesitter updated, but tree-sitter CLI is unavailable. Run :ToolBootstrap and then :TSUpdate.",
				vim.log.levels.WARN
			)
			return
		end

		if not data.active then
			vim.cmd.packadd("nvim-treesitter")
		end

		require("nvim-treesitter").update(nil, {
			max_jobs = 1,
			summary = true,
		})
	end,
})

vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

local treesitter = require("nvim-treesitter")

treesitter.setup()

local parsers = {
	"lua",
	"bash",
	"python",
	"markdown",
	"markdown_inline",
	"json",
	"toml",
	"yaml",
}

local function ensure_parsers()
	if vim.fn.executable("tree-sitter") ~= 1 then
		return
	end

	local installed = treesitter.get_installed("parsers")
	local missing = vim.tbl_filter(function(parser)
		return not vim.tbl_contains(installed, parser)
	end, parsers)

	if #missing == 0 then
		return
	end

	treesitter.install(missing, {
		max_jobs = 1,
		summary = true,
	})
end

local bootstrap_group = vim.api.nvim_create_augroup("treesitter-bootstrap", {
	clear = true,
})

vim.api.nvim_create_autocmd("User", {
	group = bootstrap_group,
	pattern = "MasonTreeSitterReady",
	callback = ensure_parsers,
})

local filetypes = { "lua", "sh", "bash", "python", "markdown", "json", "jsonc", "toml", "yaml" }

local highlight_group = vim.api.nvim_create_augroup("treesitter-highlight", {
	clear = true,
})

vim.api.nvim_create_autocmd("FileType", {
	group = highlight_group,
	pattern = filetypes,
	callback = function(args)
		local filetype = vim.bo[args.buf].filetype
		local language = vim.treesitter.language.get_lang(filetype)

		if language and vim.treesitter.language.add(language) then
			vim.treesitter.start(args.buf, language)
		end
	end,
})
