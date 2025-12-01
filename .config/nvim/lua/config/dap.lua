local dap, dapui = require("dap"), require("dapui")

-- Keymaps
local map = vim.keymap.set
local opts = { silent = true, noremap = true }

-- Debugger controls
map("n", "<F5>", dap.continue, opts)
map("n", "<F10>", dap.step_over, opts)
map("n", "<F11>", dap.step_into, opts)
map("n", "<F12>", dap.step_out, opts)
map("n", "<Leader>b", dap.toggle_breakpoint, opts)
map("n", "<Leader>B", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)
map("n", "<Leader>lp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, opts)
map("n", "<Leader>dr", dap.repl.open, opts)
map("n", "<Leader>dl", dap.run_last, opts)

-- UI controls
map("n", "<Leader>du", dapui.toggle, opts)
map({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end, opts)
map({ "n", "v" }, "<Leader>dp", function()
	require("dap.ui.widgets").preview()
end, opts)
map("n", "<Leader>df", function()
	require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames)
end, opts)

-- Debugger events
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

dap.configurations.java = {
	{
		name = "Debug Launch (2GB)",
		type = "java",
		request = "launch",
		vmArgs = "" .. "-Xmx2g ",
	},
	{
		name = "Debug Attach (8000)",
		type = "java",
		request = "attach",
		hostName = "127.0.0.1",
		port = 8000,
		timeout = 30000,
	},
	{
		name = "Debug Attach (5005)",
		type = "java",
		request = "attach",
		hostName = "127.0.0.1",
		port = 5005,
		timeout = 30000,
	},
	{
		name = "My Custom Java Run Configuration",
		type = "java",
		request = "launch",
		mainClass = "replace.with.your.fully.qualified.MainClass",
		vmArgs = "" .. "-Xmx2g ",
	},
}

dap.adapters.python = {
	type = "executable",
	command = "python",
	args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return "python"
		end,
	},
}

dap.adapters.bashdb = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
	name = "bashdb",
}

dap.configurations.sh = {
	{
		type = "bashdb",
		request = "launch",
		name = "Launch file",
		showDebugOutput = true,
		pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
		pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
		trace = true,
		file = "${file}",
		program = "${file}",
		cwd = "${workspaceFolder}",
		pathCat = "cat",
		pathBash = "/bin/bash",
		pathMkfifo = "mkfifo",
		pathPkill = "pkill",
		args = {},
		argsString = "",
		env = {},
		terminalKind = "integrated",
	},
}

dapui.setup({
	controls = {
		element = "repl",
		enabled = false,
		icons = {
			disconnect = "",
			pause = "",
			play = "",
			run_last = "",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = "",
		},
	},
	element_mappings = {},
	expand_lines = true,
	floating = {
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	force_buffers = true,
	icons = {
		collapsed = "",
		current_frame = "",
		expanded = "",
	},
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.50,
				},
				{
					id = "stacks",
					size = 0.30,
				},
				{
					id = "watches",
					size = 0.10,
				},
				{
					id = "breakpoints",
					size = 0.10,
				},
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},
	mappings = {
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t",
	},
	render = {
		indent = 1,
		max_value_lines = 100,
	},
})

vim.api.nvim_set_hl(0, "DapStoppedHl", { fg = "#98BB6C", bg = "#2A2A2A", bold = true })
vim.api.nvim_set_hl(0, "DapStoppedLineHl", { bg = "#204028", bold = true })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStoppedHl", linehl = "DapStoppedLineHl", numhl = "" })
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
