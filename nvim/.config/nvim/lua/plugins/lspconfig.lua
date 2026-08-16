vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

local completion = require("mini.completion")
local schemastore = require("schemastore")

vim.lsp.config("*", {capabilities = completion.get_lsp_capabilities(),})

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name

			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},

			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
		})
	end,

	settings = {Lua = {},},
})

vim.lsp.config("jsonls", {
	settings = {
		json = {schemas = schemastore.json.schemas(), validate = { enable = true, },},
	},
})

vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = schemastore.yaml.schemas(),
		},
	},
})

vim.lsp.config("pyright", {
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "standard",
				useLibraryCodeForTypes = true,
			},
		},
	},
})

vim.lsp.config("ruff", {
	on_attach = function(client)
		client.server_capabilities.hoverProvider = false
	end,
})

local function toggle_inlay_hints()
	local bufnr = vim.api.nvim_get_current_buf()
	local filter = {
		bufnr = bufnr,
	}

	local supported = vim.iter(vim.lsp.get_clients(filter)):any(function(client)
		return client:supports_method("textDocument/inlayHint")
	end)

	if not supported then
		vim.notify("No LSP inlay hints available", vim.log.levels.INFO)
		return
	end

	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
end

local function format_buffer()
	local bufnr = vim.api.nvim_get_current_buf()

	local supported = vim.iter(vim.lsp.get_clients({
		bufnr = bufnr,
	})):any(function(client)
		return client:supports_method("textDocument/formatting")
	end)

	if not supported then
		vim.notify("No LSP formatter available", vim.log.levels.INFO)
		return
	end

	vim.lsp.buf.format({
		bufnr = bufnr,
		async = false,
	})
end

vim.keymap.set("n", "<Leader>ch", toggle_inlay_hints, {
	desc = "Toggle inlay hints",
})

vim.keymap.set("n", "<Leader>cf", format_buffer, {
	desc = "Format with LSP",
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("bashls")
vim.lsp.enable("marksman")
vim.lsp.enable("jsonls")
vim.lsp.enable("taplo")
vim.lsp.enable("yamlls")
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
