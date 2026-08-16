vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.autocmds")
require("core.keymaps")
require("core.diagnostics")
require("core.annotations")

-- Appearance
require("plugins.mini-icons")
require("plugins.mini-base16")
require("plugins.mini-notify")
require("plugins.mini-statusline")

-- Navigation
require("plugins.mini-extra")
require("plugins.mini-pick")
require("plugins.mini-files")

-- Snippets and completion
require("plugins.friendly-snippets")
require("plugins.mini-snippets")
require("plugins.mini-pairs")
require("plugins.mini-completion")

-- Editing
require("plugins.mini-ai")
require("plugins.mini-surround")
require("plugins.mini-splitjoin")
require("plugins.mini-move")
require("plugins.mini-bracketed")

-- Language tooling
require("plugins.treesitter")
require("plugins.mason")
require("plugins.schemastore")
require("plugins.lspconfig")

-- Git review
require("plugins.mini-diff")
require("plugins.mini-git")

-- Visual helpers
require("plugins.mini-hipatterns")
require("plugins.mini-indentscope")

-- Keymap clues
require("plugins.mini-clue")
