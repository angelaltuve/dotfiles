local map = vim.keymap.set

vim.diagnostic.config({
	severity_sort = true,
	float = {
		border = "rounded",
		source = "if_many",
	},
	underline = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚",
			[vim.diagnostic.severity.WARN] = "󰀪",
			[vim.diagnostic.severity.INFO] = "󰋽",
			[vim.diagnostic.severity.HINT] = "󰌶",
		},
	},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		prefix = "●",
	},
})

-- Enhanced completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = { "documentation", "detail", "additionalTextEdits" },
	},
}

-- Lua-specific LSP settings
local lua_lsp_settings = {
	Lua = {
		workspace = {
      runtime = { version = "LuaJIT" },
			library = {
				vim.fn.expand("$VIMRUNTIME/lua"),
				vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
				"${3rd}/luv/library",
			},
		},
	},
}

-- Disable semantic tokens
local on_init = function(client)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

-- LSP keymaps and autocommands
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		if not event.buf or not event.data then
			return
		end

		-- Helper function for keymap descriptions
		local function opts(desc)
			return { buffer = event.buf, desc = "LSP: " .. desc }
		end

		-- Navigation mappings
		map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
		map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
		map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
		map("n", "gr", vim.lsp.buf.references, opts("Show references"))
		map("n", "gT", vim.lsp.buf.type_definition, opts("Go to type definition"))
		map("n", "<leader>dss", require("telescope.builtin").lsp_document_symbols, opts("Document Symbols"))
		map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts("Workspace Symbols"))

		-- Code actions
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
		map("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
		map("n", "K", vim.lsp.buf.hover, opts("Hover documentation"))
		map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Signature help"))

		-- Workspace management
		map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
		map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
		map("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts("List workspace folders"))

		-- Get the attached LSP client
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.supports_method then
			-- Set up document highlighting
			if client:supports_method("textDocument/documentHighlight") then
				local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight-" .. event.buf, { clear = true })

				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})
			end

			-- Set up inlay hints
			if client:supports_method("textDocument/inlayHint") then
				map("n", "<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, opts("Toggle inlay hints"))
			end
		end
	end,
})

-- Configure LSP servers
local servers = {
	"bashls",
	"clangd",
	"cssls",
	"html",
	"lua_ls",
	"marksman",
	"pylsp",
	"texlab",
}

vim.lsp.config("*", { capabilities = capabilities, on_init = on_init })
vim.lsp.config("lua_ls", { settings = lua_lsp_settings })
vim.lsp.enable(servers)
