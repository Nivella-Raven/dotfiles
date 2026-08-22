vim.pack.add({"https://github.com/nvim-mini/mini.base16",})

-- Main mappings applied by mini.base16; this is not an exhaustive group list.
-- Slots are in hexadecimal order from 00 through 0F.
-- base00 (0):  Normal background
-- base01 (1):  CursorLine, floats, menus, sign column
-- base02 (2):  Visual, MatchParen, LSP references, separators
-- base03 (3):  Comments, line numbers, whitespace, inactive UI
-- base04 (4):  CursorLineNr, StatusLine and WinBar foreground
-- base05 (5):  Normal foreground, operators, Tree-sitter variables
-- base06 (6):  Light foreground and bright UI accents
-- base07 (7):  Brightest foreground, menu thumb, bright UI accents
-- base08 (8):  Errors, deletes, identifiers, statements, return, hipatterns FIXME
-- base09 (9):  Numbers, constants, booleans, current search
-- base0A (10): Types, labels, preprocessors, search, built-in Todo group
-- base0B (11): Strings, additions, success diagnostics
-- base0C (12): Special syntax, info diagnostics, fold column, hipatterns TODO
-- base0D (13): Functions, includes, directories, titles, hints, hipatterns NOTE
-- base0E (14): Keywords, conditionals, structures, warnings, changes, hipatterns HACK
-- base0F (15): Delimiters, special characters, indent scope

local themes = {
	ayu = {
		palette = {
			base00 = "#0b0e14",
			base01 = "#131721",
			base02 = "#202229",
			base03 = "#3e4b59",
			base04 = "#bfbdb6",
			base05 = "#e6e1cf",
			base06 = "#ece8db",
			base07 = "#f2f0e7",
			base08 = "#f07178",
			base09 = "#ff8f40",
			base0A = "#ffb454",
			base0B = "#aad94c",
			base0C = "#95e6cb",
			base0D = "#59c2ff",
			base0E = "#d2a6ff",
			base0F = "#e6b450",
		},
		highlights = {
			Identifier = "base05",
			["@property"] = "base0A",
		},
	},
	noctalia = {
		palette = {
			base00 = "#070722",
			base01 = "#11112d",
			base02 = "#17173c",
			base03 = "#51589b",
			base04 = "#7c80b4",
			base05 = "#f3edf7",
			base06 = "#f3edf7",
			base07 = "#f3edf7",
			base08 = "#fd4663",
			base09 = "#9bfece",
			base0A = "#a9aefe",
			base0B = "#fff59b",
			base0C = "#81fec1",
			base0D = "#fff280",
			base0E = "#8188fe",
			base0F = "#8f0118",
		},
		highlights = {
			Identifier = "base05",
			["@property"] = "base0A",
		},
	},
	tokyonight = {
		palette = {
			base00 = "#1a1b26",
			base01 = "#16161e",
			base02 = "#2f3549",
			base03 = "#444b6a",
			base04 = "#787c99",
			base05 = "#c0caf5",
			base06 = "#cbccd1",
			base07 = "#d5d6db",
			base08 = "#f7768e",
			base09 = "#ff9e64",
			base0A = "#e0af68",
			base0B = "#9ece6a",
			base0C = "#7dcfff",
			base0D = "#7aa2f7",
			base0E = "#bb9af7",
			base0F = "#db4b4b",
		},
		highlights = {
			Identifier = "base05",
			["@property"] = "base05",
		},
	},
}

-- Change this value to switch the complete palette.
local selected_theme = "noctalia"

-- Override only the Base16 slots that need local adjustment.
local palette_overrides = {
	 -- base0F = "#5f66a8",
}

local theme = assert(themes[selected_theme], ("Unknown Base16 theme: %s"):format(selected_theme))
local palette = vim.tbl_extend("force", {}, theme.palette, palette_overrides)

require("mini.base16").setup({
	palette = palette,
	use_cterm = true,
	plugins = {
		default = false,
		["nvim-mini/mini.nvim"] = true,
	},
})

-- Keep identifiers distinct from errors while preserving each theme's intent.
for group, slot in pairs(theme.highlights) do
	vim.api.nvim_set_hl(0, group, { fg = palette[slot] })
end
