local opt = vim.opt
local o = vim.o
local g = vim.g

-----------------------------------------------------------
-- Appearance
-----------------------------------------------------------
o.title = true
o.laststatus = 3
o.showmode = false
o.termguicolors = true
o.number = true
o.relativenumber = true
o.numberwidth = 2
o.ruler = false
o.scrolloff = 8
o.sidescrolloff = 8
o.cmdheight = 1
o.signcolumn = "yes"
o.cursorline = true
o.cursorlineopt = "number"
opt.fillchars = {
	vert = "│",
	fold = "·",
	eob = " ",
}

-----------------------------------------------------------
-- General Behavior
-----------------------------------------------------------
o.hidden = true
o.errorbells = false
o.swapfile = false
o.writebackup = false
o.backup = false
o.undofile = true

o.backspace = "indent,eol,start"
o.splitright = true
o.splitbelow = true
o.splitkeep = "screen"
o.autochdir = false
o.mouse = "a"
o.clipboard = "unnamedplus"
o.modifiable = true

o.encoding = "UTF-8"
o.timeoutlen = 500
o.ttimeoutlen = 50
o.updatetime = 300

-----------------------------------------------------------
-- Indentation
-----------------------------------------------------------
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.shiftround = true
opt.wrap = false
opt.linebreak = true

opt.list = true
opt.listchars = {
	tab = "» ",
	trail = "·",
	extends = "›",
	precedes = "‹",
}

vim.opt.colorcolumn = "80"

-----------------------------------------------------------
-- Search
-----------------------------------------------------------
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-----------------------------------------------------------
-- Navigation
-----------------------------------------------------------
opt.whichwrap:append("<>[]hl")

-----------------------------------------------------------
-- Folding
-----------------------------------------------------------
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-----------------------------------------------------------
-- Markdown
-----------------------------------------------------------
o.conceallevel = 2
o.concealcursor = "nc"

-----------------------------------------------------------
-- Misc
-----------------------------------------------------------
o.history = 100
opt.shortmess:append "sI"

-----------------------------------------------------------
-- File Management
-----------------------------------------------------------
opt.autowrite = true
opt.autoread = true

vim.opt.spelllang = { "en", "es" }
vim.opt.spellsuggest = { "best", 9 }
vim.g.spellfile_URL = "https://ftp.nluug.nl/vim/runtime/spell"

opt.visualbell = true

-----------------------------------------------------------
-- Disable unused providers
-----------------------------------------------------------
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-----------------------------------------------------------
-- Add Mason binaries to PATH
-----------------------------------------------------------
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. ":" .. vim.env.PATH
