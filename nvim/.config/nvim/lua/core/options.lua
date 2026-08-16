local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true

opt.wrap = false
opt.breakindent = true
opt.cursorline = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.showmode = false
opt.termguicolors = true

opt.list = true
opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.undofile = true
opt.autoread = true

opt.splitright = true
opt.splitbelow = true

opt.inccommand = "split"

opt.updatetime = 250
opt.timeoutlen = 300

opt.confirm = true
opt.clipboard = "unnamedplus"

opt.completeopt = {"menuone", "noselect", "fuzzy", "nosort",}
