local dap = require "dap"
local dapui = require "dapui"
local dapvtext = require "nvim-dap-virtual-text"

-- Basic debugging keymaps, feel free to change to your liking!
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "Debug: Set Breakpoint" })

vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

dapvtext.setup()
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
require("dap-python").setup(path)
