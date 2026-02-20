local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- File handling group
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

-- Yank highlight
autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank { timeout = 300 }
  end,
})

autocmd("FileType", {
  pattern = { "css", "html", "sh" },
  callback = function()
    vim.cmd.ColorizerAttachToBuffer()
  end,
})

-- Restore window views
autocmd("BufWinLeave", {
  pattern = "*.*",
  command = "mkview",
})

autocmd("BufWinEnter", {
  pattern = "*.*",
  command = "silent! loadview",
})

-- Auto-create directories
autocmd("BufWritePre", {
  group = file_group,
  callback = function(event)
    if not event.match:match "^%w%w+:[\\/][\\/]" then
      local file = vim.uv.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end
  end,
})

-- Manpage buffers not listed
autocmd("FileType", {
  group = augroup("man_unlisted", { clear = true }),
  pattern = "man",
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.{md,txt}",
  command = "setlocal tw=80 colorcolumn=80 fo=awqtc comments+=nb:> "
    .. "spell tabstop=2 shiftwidth=2 expandtab",
})

-- Email & Neomutt settings
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "{neomutt-*,*.eml}",
  command = "setlocal tw=72 colorcolumn=72 fo=awq comments+=nb:> spell"
    .. " | match ErrorMsg '\\s\\+$'",
})

-- disable automatic comment on newline
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove { "c", "r", "o" }
  end,
})

autocmd("BufWritePre", {
  pattern = "*",
  command = "Trim",
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = {
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
    "lazy",
    "mason",
    "checkhealth",
    "man",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd "close"
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

local create_cmd = vim.api.nvim_create_user_command

create_cmd("TSInstallAll", function()
  local spec = require("lazy.core.config").plugins["nvim-treesitter"]
  local opts = type(spec.opts) == "table" and spec.opts or {}
  require("nvim-treesitter").install(opts.ensure_installed)
end, {})
