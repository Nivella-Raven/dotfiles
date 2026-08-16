vim.pack.add({ "https://github.com/mason-org/mason.nvim" })

local mason = require("mason")
local registry = require("mason-registry")

mason.setup()

local tools = {
	{ package = "tree-sitter-cli", bin = "tree-sitter" },
	{ package = "shellcheck", bin = "shellcheck" },
	{ package = "shfmt", bin = "shfmt" },
	{ package = "lua-language-server", bin = "lua-language-server" },
	{ package = "bash-language-server", bin = "bash-language-server" },
	{ package = "marksman", bin = "marksman" },
	{ package = "json-lsp", bin = "vscode-json-language-server" },
	{ package = "taplo", bin = "taplo" },
	{ package = "yaml-language-server", bin = "yaml-language-server" },
	{ package = "pyright", bin = "pyright-langserver" },
	{ package = "ruff", bin = "ruff" },
}

local mason_bin = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")

local function mason_has_executable(name)
	return vim.uv.fs_stat(vim.fs.joinpath(mason_bin, name)) ~= nil
end

local function notify_treesitter_ready()
	vim.schedule(function()
		vim.api.nvim_exec_autocmds("User", {
			pattern = "MasonTreeSitterReady",
			modeline = false,
		})
	end)
end

local function get_missing_tools()
	local missing = {}

	for _, tool in ipairs(tools) do
		if not mason_has_executable(tool.bin) then
			table.insert(missing, tool)
		end
	end

	return missing
end

local function bootstrap(options)
	options = options or {}

	if mason_has_executable("tree-sitter") then
		notify_treesitter_ready()
	end

	local missing = get_missing_tools()

	if #missing == 0 then
		if options.notify then
			vim.notify("All Mason-managed tools are installed", vim.log.levels.INFO)
		end
		return
	end

	registry.refresh(function()
		local unavailable = {}

		for _, tool in ipairs(missing) do
			local package_name = tool.package
			local executable = tool.bin
			local ok, package = pcall(registry.get_package, package_name)

			if not ok then
				table.insert(unavailable, package_name)
			elseif package:is_installed() then
				vim.schedule(function()
					vim.notify(
						("Mason package %s is installed, but executable %s is missing. Reinstall it with :MasonInstall %s"):format(
							package_name,
							executable,
							package_name
						),
						vim.log.levels.WARN
					)
				end)
			elseif not package:is_installing() then
				package:install({}, function(success, result)
					if success then
						if package_name == "tree-sitter-cli" then
							notify_treesitter_ready()
						end
						return
					end

					vim.schedule(function()
						vim.notify(
							("Mason failed to install %s: %s"):format(package_name, tostring(result)),
							vim.log.levels.ERROR
						)
					end)
				end)
			end
		end

		if #unavailable > 0 then
			vim.schedule(function()
				vim.notify(
					"Mason registry unavailable for: "
						.. table.concat(unavailable, ", ")
						.. "\nRetry with :ToolBootstrap",
					vim.log.levels.WARN
				)
			end)
		end
	end)
end

bootstrap()

vim.api.nvim_create_user_command("ToolBootstrap", function()
	bootstrap({
		notify = true,
	})
end, {
	desc = "Install missing Mason-managed development tools",
})
