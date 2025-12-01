local map = vim.keymap.set

-----------------------------------------------------------
-- Basic editing shortcuts
-----------------------------------------------------------
map("n", ";", ":", { desc = "Command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")

-- Move within insert mode
map("i", "<C-b>", "<ESC>^i", { desc = "Line start" })
map("i", "<C-e>", "<End>", { desc = "Line end" })
map("i", "<C-h>", "<Left>", { desc = "Left" })
map("i", "<C-l>", "<Right>", { desc = "Right" })
map("i", "<C-j>", "<Down>", { desc = "Down" })
map("i", "<C-k>", "<Up>", { desc = "Up" })

-----------------------------------------------------------
-- Window navigation
-----------------------------------------------------------
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

-----------------------------------------------------------
-- General utilities
-----------------------------------------------------------
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Copy whole file" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-----------------------------------------------------------
-- Window management
-----------------------------------------------------------
map("n", "<leader>-", "<C-W>s", { desc = "Split below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Close window", remap = true })

-----------------------------------------------------------
-- Better navigation (wrap-aware)
-----------------------------------------------------------
map({ "n", "x" }, "j", "v:count==0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count==0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count==0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count==0 ? 'gk' : 'k'", { expr = true, silent = true })

-----------------------------------------------------------
-- Window resizing
-----------------------------------------------------------
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Resize up" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Resize down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Resize left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Resize right" })

-----------------------------------------------------------
-- Move lines
-----------------------------------------------------------
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-----------------------------------------------------------
-- Buffers
-----------------------------------------------------------
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>q", "<cmd>BufferClose", { desc = "Close buffer" })
map("n", "<leader>Q", "<cmd>BufferClose!", { desc = "Force Close buffer" })
map("n", "<leader>U", "::bufdo bd<CR>", { desc = "Close All Buffers" })
map("n", "<leader>vs", "<cmd>vsplit<CR>:bnext<cr>", { desc = "ver split + open next buffer" })

-------------------------------------------------------------
-- buffer position nav + reorder
-------------------------------------------------------------
map("n", "<AS-h>", "<Cmd>BufferMovePrevious<CR>")
map("n", "<AS-l>", "<Cmd>BufferMoveNext<CR>")
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>")
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>")
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>")
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>")
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>")
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>")
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>")
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>")
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>")
map("n", "<A-0>", "<Cmd>BufferLast<CR>")
map("n", "<A-p>", "<Cmd>BufferPin<CR>")

-----------------------------------------------------------
-- Better search navigation
-----------------------------------------------------------
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true })
map("o", "n", "'Nn'[v:searchforward]", { expr = true })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search" })
map("x", "N", "'nN'[v:searchforward]", { expr = true })
map("o", "N", "'nN'[v:searchforward]", { expr = true })

-----------------------------------------------------------
-- Undo breakpoints
-----------------------------------------------------------
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-----------------------------------------------------------
-- Better indenting
-----------------------------------------------------------
map("v", "<", "<gv")
map("v", ">", ">gv")

-----------------------------------------------------------
-- Commands
-----------------------------------------------------------
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
--map("n", "<leader>fb", "<cmd>enew<cr>", { desc = "New file" })

-----------------------------------------------------------
-- Inspection
-----------------------------------------------------------
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect pos" })
map("n", "<leader>uu", function()
	vim.treesitter.inspect_tree()
	vim.api.nvim_input("I")
end, { desc = "Inspect tree" })

-----------------------------------------------------------
-- Tools
-----------------------------------------------------------
map("n", "<leader>ul", '<cmd>silent !xdg-open "<cWORD>"<cr>', { desc = "Open URL" })
map("n", "<leader>x", '<cmd>!chmod +x %<cr><cmd>echo "Made executable: ".expand("%")<cr>', { desc = "Make executable" })
map("n", "<leader>cv", '<cmd>!opout "%:p"<cr>', { desc = "Open PDF" })
map("n", "<leader>cp", '<cmd>w<bar>!compiler "%:p"<cr>', { desc = "Compile file" })
map("n", "<leader>W", ":set wrap!<CR>", { desc = "toggle wrap" })
map("n", "<leader>ma", function()
	local bufdir = vim.fn.expand("%:p:h")
	vim.cmd("lcd " .. bufdir)
	vim.cmd("!sudo make uninstall && sudo make clean install %")
end, { desc = "Quick make in dir of buffer" })

-----------------------------------------------------------
-- Formatting
-----------------------------------------------------------
map({ "n", "x" }, "<leader>fm", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "Format file" })

-----------------------------------------------------------
-- Tabs
-----------------------------------------------------------
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close others" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Prev tab" })

-----------------------------------------------------------
-- Git
-----------------------------------------------------------
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>")
map("n", "<leader>gi", "<cmd>Gitsigns toggle_current_line_blame<cr>")

-----------------------------------------------------------
-- Diagnostics
-----------------------------------------------------------
local diagnostic_jump = function(next, severity)
	local direction = next and 1 or -1
	severity = severity and vim.diagnostic.severity[severity:upper()] or nil
	return function()
		vim.diagnostic.jump({
			count = direction,
			severity = severity,
			float = true,
		})
	end
end

map("n", "<leader>dv", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })
map("n", "<leader>dc", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "]d", diagnostic_jump(1), { desc = "Next diagnostic" })
map("n", "[d", diagnostic_jump(-1), { desc = "Prev diagnostic" })
map("n", "]e", diagnostic_jump(1, "ERROR"), { desc = "Next error" })
map("n", "[e", diagnostic_jump(-1, "ERROR"), { desc = "Prev error" })
map("n", "]w", diagnostic_jump(1, "WARN"), { desc = "Next warning" })
map("n", "[w", diagnostic_jump(-1, "WARN"), { desc = "Prev warning" })

-----------------------------------------------------------
-- Replace under cursor
-----------------------------------------------------------
map("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word" })
map("n", "<leader>sa", ":%s//g<Left><Left>", { noremap = true })

-----------------------------------------------------------
-- Comment toggling
-----------------------------------------------------------
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-----------------------------------------------------------
-- NvimTree
-----------------------------------------------------------
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Tree toggle" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Tree focus" })

-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
map("n", "<leader>fe", "<cmd>Telescope marks<CR>")
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>")
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
map("n", "<leader>fn", "<cmd>Telescope nerdy<CR>")
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>")
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>")
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>")
map("n", "<leader>fs", "<cmd>Telescope spell_suggest<CR>")
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>")
map("n", "<leader>fu", "<cmd>Telescope undo<cr>")

-----------------------------------------------------------
-- Toggle spell (en/es)
-----------------------------------------------------------
map("n", "<leader>o", function()
	vim.wo.spell = true
	vim.bo.spelllang = vim.bo.spelllang == "en_us" and "es" or "en_us"
	print("Spell language: " .. vim.bo.spelllang)
end, { desc = "Toggle spell language" })

------------------------------------------------------------
-- decisive csv
------------------------------------------------------------
map("n", "<leader>csa", ":lua require('decisive').align_csv({})<cr>", { silent = true, desc = "Align CSV" })
map("n", "<leader>csA", ":lua require('decisive').align_csv_clear({})<cr>", { silent = true, desc = "Align CSV clear" })
map("n", "[c", ":lua require('decisive').align_csv_prev_col()<cr>", { silent = true, desc = "Align CSV prev col" })
map("n", "]c", ":lua require('decisive').align_csv_next_col()<cr>", { silent = true, desc = "Align CSV" })
