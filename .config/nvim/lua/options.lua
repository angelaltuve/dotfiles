-- Neovim Options

local opt = vim.opt
local o   = vim.o
local g   = vim.g

-- Appearance
o.termguicolors = true
o.title = true
o.laststatus = 3
o.showmode = false
o.number = true
o.relativenumber = true
o.numberwidth = 2
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

-- General Behavior
o.swapfile = false
o.writebackup = false
o.backup = false
o.undofile = true
opt.undolevels = 10000
o.splitright = true
o.splitbelow = true
o.splitkeep = "screen"
o.autochdir = false
o.mouse = "a"
o.clipboard = "unnamedplus"
o.timeoutlen = 500
o.ttimeoutlen = 50
o.updatetime = 300
vim.o.inccommand = "split"
o.confirm = true
opt.shiftround = true
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.pumheight = 10

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.wrap = false
opt.linebreak = true
opt.list = true
opt.listchars = {
  tab = "» ",
  trail = "·",
  extends = "›",
  precedes = "‹",
}

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Navigation
opt.whichwrap:append("<>[]hl")
vim.opt.iskeyword:append("-")

-- Folding
opt.foldlevel = 99
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Markdown
o.conceallevel = 2
o.concealcursor = "nc"

-- Misc
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.formatoptions = "jcroqlnt"
opt.smoothscroll = true
opt.jumpoptions = "view"

-- Search Tools
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

-- File Management
opt.autowrite = true
opt.autoread = true

-- Spell Checking
vim.opt.spelllang = { "en", "es" }
vim.opt.spellsuggest = { "best", 9 }
vim.g.spellfile_URL = "https://ftp.nluug.nl/vim/runtime/spell"

-- Performance
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Mason PATH
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. ":" .. vim.env.PATH
