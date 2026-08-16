local annotations = {
	{ tag = "TODO", description = "Planned work" },
	{ tag = "FIXME", description = "Broken behavior" },
	{ tag = "HACK", description = "Temporary workaround" },
	{ tag = "NOTE", description = "Important context" },
}

local function insert_annotation()
	local buffer = vim.api.nvim_get_current_buf()
	local window = vim.api.nvim_get_current_win()
	local row = vim.api.nvim_win_get_cursor(window)[1]
	local line = vim.api.nvim_buf_get_lines(buffer, row - 1, row, false)[1] or ""
	local indent = line:match("^%s*") or ""
	local commentstring = vim.bo[buffer].commentstring
	local left, right = commentstring:match("^(.-)%%s(.-)$")

	if not left or not right then
		vim.notify("Current buffer has no valid commentstring", vim.log.levels.WARN)
		return
	end

	vim.ui.select(annotations, {
		prompt = "Annotation kind",
		format_item = function(item)
			return string.format("%-5s %s", item.tag, item.description)
		end,
	}, function(choice)
		if not choice then
			return
		end

		vim.schedule(function()
			if not vim.api.nvim_buf_is_valid(buffer) or not vim.api.nvim_win_is_valid(window) then
				return
			end

			if vim.api.nvim_win_get_buf(window) ~= buffer or not vim.bo[buffer].modifiable then
				vim.notify("Annotation target is no longer editable", vim.log.levels.WARN)
				return
			end

			local payload = choice.tag .. ": "
			local comment = indent .. left .. payload .. right
			local cursor_column = #indent + #left + #payload

			vim.api.nvim_buf_set_lines(buffer, row, row, false, { comment })
			vim.api.nvim_set_current_win(window)
			vim.api.nvim_win_set_cursor(window, { row + 1, cursor_column })
			vim.cmd.startinsert()
		end)
	end)
end

vim.keymap.set("n", "<Leader>cn", insert_annotation, {
	desc = "New annotated comment",
})
