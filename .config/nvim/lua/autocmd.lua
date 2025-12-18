local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-----------------------------------------------------------
-- File handling group
-----------------------------------------------------------
local file_group = augroup("FileSettings", { clear = true })

-- File load events
autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
	group = file_group,
	callback = function(args)
		local file = vim.api.nvim_buf_get_name(args.buf)
		local buftype = vim.bo[args.buf].buftype

		if args.event == "UIEnter" then
			vim.g.ui_entered = true
		end
		if file == "" or buftype == "nofile" or not vim.g.ui_entered then
			return
		end

		vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
		augroup("NvFilePost", { clear = false })

		vim.schedule(function()
			vim.api.nvim_exec_autocmds("FileType", {})
			if vim.g.editorconfig then
				require("editorconfig").config(args.buf)
			end
		end)
	end,
})

-----------------------------------------------------------
-- Yank highlight
-----------------------------------------------------------
autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ timeout = 300 })
	end,
})

-----------------------------------------------------------
-- Filetype rules
-----------------------------------------------------------
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "/tmp/calcurse*", "~/.calcurse/notes/*" },
	command = "setf markdown",
})

autocmd("FileType", {
	pattern = { "css", "html", "sh" },
	callback = function()
		vim.cmd.ColorizerAttachToBuffer()
	end,
})

-- Private journal configuration
autocmd({ "BufNewFile", "BufReadPre" }, {
	group = augroup("PrivateJrnl", { clear = true }),
	pattern = "*.jrnl",
	callback = function()
		vim.o.shada = ""
		vim.o.swapfile = false
		vim.o.undofile = false
		vim.o.backup = false
		vim.o.writebackup = false
		vim.o.shelltemp = false
		vim.o.history = 0
		vim.o.modeline = false
		vim.o.secure = true
	end,
})

-----------------------------------------------------------
-- Close helper buffers with 'q'
-----------------------------------------------------------
local close_group = augroup("CloseWithQ", { clear = true })
local closeable_ft = {
	"PlenaryTestPopup",
	"checkhealth",
	"dbout",
	"gitsigns-blame",
	"grug-far",
	"help",
	"lspinfo",
	"neotest-output",
	"neotest-output-panel",
	"neotest-summary",
	"notify",
	"qf",
	"spectre_panel",
	"startuptime",
	"tsplayground",
	"man",
}

autocmd("FileType", {
	group = close_group,
	pattern = closeable_ft,
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-----------------------------------------------------------
-- Restore window views
-----------------------------------------------------------
autocmd("BufWinLeave", {
	pattern = "*.*",
	command = "mkview",
})

autocmd("BufWinEnter", {
	pattern = "*.*",
	command = "silent! loadview",
})

-----------------------------------------------------------
-- Autoformatting on save
-----------------------------------------------------------
autocmd("BufWritePre", {
	group = file_group,
	callback = function()
		local cursor = vim.api.nvim_win_get_cursor(0)
		local line_count = vim.api.nvim_buf_line_count(0)

		vim.cmd([[keeppatterns %s/\s\+$//e]]) -- Trim trailing spaces
		vim.cmd([[keeppatterns %s/\n\+\%$//e]]) -- Trim extra empty EOF lines

		if vim.fn.expand("%:e") == "c" or vim.fn.expand("%:e") == "h" then
			vim.cmd([[keeppatterns %s/\%$/\r/e]]) -- Ensure final newline
		end

		if cursor[1] > line_count then
			cursor[1] = line_count
		end
		pcall(vim.api.nvim_win_set_cursor, 0, cursor)
	end,
})

-- Neomutt cleanup
autocmd("BufWritePre", {
	pattern = "*neomutt*",
	command = "%s/^--$/-- /e",
})

-- Clean LaTeX aux files on exit
autocmd("BufWritePost", {
    pattern = "*.tex",
    callback = function()
        vim.cmd("silent !latexmk -c " .. vim.fn.expand("%:p"))
    end,
})


-----------------------------------------------------------
-- Auto-create directories
-----------------------------------------------------------
autocmd("BufWritePre", {
	group = file_group,
	callback = function(event)
		if not event.match:match("^%w%w+:[\\/][\\/]") then
			local file = vim.uv.fs_realpath(event.match) or event.match
			vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
		end
	end,
})

-----------------------------------------------------------
-- Manpage buffers not listed
-----------------------------------------------------------
autocmd("FileType", {
	group = augroup("man_unlisted", { clear = true }),
	pattern = "man",
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-----------------------------------------------------------
-- Disable auto-comments
-----------------------------------------------------------
autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-----------------------------------------------------------
-- Markdown & text settings
-----------------------------------------------------------
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.{md,txt}",
	command = "setlocal tw=80 colorcolumn=80 fo=awqtc comments+=nb:> " .. "spell tabstop=2 shiftwidth=2 expandtab",
})

-- Email & Neomutt settings
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "{neomutt-*,*.eml}",
	command = "setlocal tw=72 colorcolumn=72 fo=awq comments+=nb:> spell" .. " | match ErrorMsg '\\s\\+$'",
})
